//
//  CharacterDetailViewController.swift
//  Disneyverse
//
//  Created by Faizan Memon on 11/05/23.
//

import Foundation
import UIKit
import WebKit

final class CharacterDetailViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var filmsCollectionView: UICollectionView!
    @IBOutlet weak var sourceTextView: UITextView!
    @IBOutlet weak var videoGamesCollectionView: UICollectionView!

    let viewModel: CharacterDetailViewModel
    var videoGameCellSizeArray: [CGSize] = []
    var videoGameCellsOffset: [(CGFloat, CGFloat)] = []
    let filmListFont = UIFont.systemFont(ofSize: 17, weight: .regular)
    let filmListItemPadding: CGFloat = 5
    let filmListItemHeight: CGFloat = 60
    let videoGameListFont = UIFont.systemFont(ofSize: 12, weight: .regular)
    let videoGameCellMaxWidth: CGFloat = 120

    init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: CharacterDetailViewController.className, bundle: nil)
        self.navigationItem.title = "Details"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        profileImage.sd_setImage(
            with: viewModel.imageUrl,
            placeholderImage: UIImage(systemName: "person.fill")
        )
        nameLabel.text = viewModel.name
        setupSourceTextView(url: viewModel.sourceUrl)
        setupFilmsCollectionViewIfNeeded()
        setupVideoGamesCollectionViewIfNeeded()
    }

    private func setupFilmsCollectionViewIfNeeded() {
        guard viewModel.filmsList.count > 0 else { return }
    
        filmsCollectionView.delegate = self
        filmsCollectionView.dataSource = self

        filmsCollectionView.register(
            UINib(nibName: FilmDetailCollectionViewCell.className, bundle: nil),
            forCellWithReuseIdentifier: FilmDetailCollectionViewCell.className
        )
        filmsCollectionView.showsHorizontalScrollIndicator = false
    }

    private func setupVideoGamesCollectionViewIfNeeded() {
        guard viewModel.videoGamesList.count > 0 else { return }
        calculateVideoGameCellSize()
    
        videoGamesCollectionView.delegate = self
        videoGamesCollectionView.dataSource = self
        videoGamesCollectionView.register(
            UINib(nibName: VideoGameCollectionViewCell.className, bundle: nil),
            forCellWithReuseIdentifier: VideoGameCollectionViewCell.className
        )
        videoGamesCollectionView.showsHorizontalScrollIndicator = false
        videoGamesCollectionView.showsVerticalScrollIndicator = false
        videoGamesCollectionView.allowsMultipleSelection = true
        let customLayout = CustomCollectionViewLayout()
        customLayout.delegate = self
        videoGamesCollectionView.setCollectionViewLayout(customLayout, animated: false)
        videoGamesCollectionView.bounces = false
    }

    private func calculateVideoGameCellSize() {
        for index in 0..<viewModel.videoGamesList.count {
            let height: CGFloat = 60
            let textToDisplay = viewModel.videoGamesList[index] ?? ""
            let fullTextWidth = textToDisplay.widthWithConstrainedHeight(height: height, font: videoGameListFont)
            let finalTextWidth = min(fullTextWidth, videoGameCellMaxWidth)
            let width = finalTextWidth + 30 // 30 is padding
            videoGameCellSizeArray.append(CGSize(width: width, height: height))
        }
    }

    private func setupSourceTextView(url: URL?) {
        sourceTextView.delegate = self
        let attributedString = NSMutableAttributedString(string: sourceTextView.text)
        if let url {
            let range = NSRange(location: 0, length: attributedString.length)
            attributedString.addAttribute(.link, value: url, range: range)
            sourceTextView.attributedText = attributedString
        }
        sourceTextView.linkTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blue]
    }
}

extension CharacterDetailViewController: UITextViewDelegate {

    func textView(
        _ textView: UITextView,
        shouldInteractWith URL: URL,
        in characterRange: NSRange,
        interaction: UITextItemInteraction
    ) -> Bool {
        let viewController = WebViewController()
        viewController.loadUrl(viewModel.sourceUrl)
        self.present(viewController, animated: true)
        return false
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false // To disable copy/paste prompts
    }
}
