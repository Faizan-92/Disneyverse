//
//  ExploreViewController.swift
//  Disneyverse
//
//  Created by Faizan Memon on 11/05/23.
//

import UIKit
import RxCocoa
import RxSwift

final class ExploreViewController: UIViewController {

    deinit {
        self.view.removeGestureRecognizer(tapRecognizer)
    }

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var zeroStateView: UIView!
    @IBOutlet weak var characterListTableView: UITableView!
    
    // Non-private property as it is required in extension
    let viewModel = ExploreViewModel()

    // Whenever this tap is received, we dismiss keyboard.
    private lazy var tapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIInputViewController.dismissKeyboard)
        )
        recognizer.cancelsTouchesInView = false
        return recognizer
    }()
        

    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        addGestures()
        bindUI()
    }

    private func registerTableView() {
        characterListTableView.delegate = self
        characterListTableView.dataSource = self
        characterListTableView.register(
            UINib(nibName: CharacterInfoTableViewCell.className, bundle: nil),
            forCellReuseIdentifier: CharacterInfoTableViewCell.className
        )
    }

    private func bindUI() {
        // Whenever text is changed in search bar, this observable will be published
        searchBar.searchTextField.rx.text
            .distinctUntilChanged()
            .compactMap { $0 }
            .filter { $0.count > 2 || $0.isEmpty } // at least 3 characters or 0 characters
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance) // wait for 500ms
            .withUnretained(self) // substitute of weak self
            .flatMapLatest({ (owner: ExploreViewController, inputText: String) -> Observable<[CharacterInfo]?> in
                owner.viewModel.fetchCharacters(havingName: inputText)
            })
            .compactMap { $0 }
            .withUnretained(self)
            .subscribe(onNext: { owner, characters in
                owner.viewModel.updateCharacters(
                    newList: characters,
                    shouldReplace: true
                )
                owner.characterListTableView.reloadData()
            })
            .disposed(by: disposeBag)

        // Whenever tableview scrolls, this observable will be published
        characterListTableView.rx.contentOffset
            .skip(1) // skip initial binding, as initial case is handled by search bar binding above
            .withUnretained(self)
            .filter({ (owner: ExploreViewController, currentOffset: CGPoint) in
                guard
                    owner.characterListTableView.frame.height > 0
                else { return false }
                // Trying to fetch data for 5 tableview cells in advance.
                return currentOffset.y + owner.characterListTableView.frame.height >= owner.characterListTableView.contentSize.height - owner.characterListTableView.estimatedRowHeight * 5
            })
        // Adding throttle so that if it is triggered multiple times in 1 second, we make
        // API call only once.
            .throttle(.seconds(1), latest: false, scheduler: MainScheduler.instance)
            .withUnretained(self)
            .flatMapLatest({ (owner: ExploreViewController, _) -> Observable<[CharacterInfo]?> in
                let name = owner.searchBar.text ?? ""
                return owner.viewModel.fetchCharacters(havingName: name)
            })
            .withUnretained(self)
            .bind(onNext: { (owner: ExploreViewController, characters: [CharacterInfo]?) in
                owner.viewModel.updateCharacters(
                    newList: characters ?? [],
                    shouldReplace: false
                )
                owner.characterListTableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.hideZeroStateViewSubject
            .bind(to: zeroStateView.rx.isHidden)
            .disposed(by: disposeBag)
    }

    private func addGestures() {
        view.addGestureRecognizer(tapRecognizer)
    }

    @objc private func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
}
