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

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var zeroStateView: UIView!
    @IBOutlet weak var characterListTableView: UITableView!

    private let viewModel = ExploreViewModel()
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
        searchBar.searchTextField.rx.text
            .compactMap { $0 }
            .filter { $0.count > 2 || $0.isEmpty } // at least 3 characters or 0 characters
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance) // wait for 500ms
            .withUnretained(self) // substitute of weak self
            .flatMapLatest({ (owner: ExploreViewController, inputText: String) -> Observable<[CharacterInfo]?> in
                // In case of no text input, fetch all characters
                if inputText.isEmpty {
                    return owner.viewModel.fetchAllCharacters()
                } else { // Else fetch characters having matching name
                    return owner.viewModel.fetchCharacter(havingName: inputText)
                }
            })
            .withUnretained(self)
            .subscribe(onNext: { owner, characters in
                owner.zeroStateView.isHidden = characters != nil
                owner.viewModel.updateCharacters(
                    newList: characters ?? [],
                    shouldReplace: true
                )
                owner.characterListTableView.reloadData()
            })
            .disposed(by: disposeBag)
    }

    private func addGestures() {
        
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(UIInputViewController.dismissKeyboard)
        )
        view.addGestureRecognizer(tap)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension ExploreViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CharacterInfoTableViewCell.className,
            for: indexPath
        )
        return cell
    }
}

extension ExploreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
}

extension ExploreViewController: UISearchBarDelegate { }

