//
//  CharacterDetailViewController.swift
//  Disneyverse
//
//  Created by Faizan Memon on 11/05/23.
//

import Foundation
import UIKit

final class CharacterDetailViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var filmsCollectionView: UICollectionView!
    @IBOutlet weak var videoGamesCollectionView: UICollectionView!

    let viewModel: CharacterDetailViewModel
    var videoGameCellSizeArray: [CGSize] = []

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
        let customLayout = CustomCollectionViewLayout()
        customLayout.delegate = self
        videoGamesCollectionView.setCollectionViewLayout(customLayout, animated: false)
        videoGamesCollectionView.bounces = false
    }

    private func calculateVideoGameCellSize() {
        for index in 0..<viewModel.videoGamesList.count {
            let font = UIFont.systemFont(ofSize: 17, weight: .regular)
            let height: CGFloat = 60
            let textToDisplay = viewModel.videoGamesList[index] ?? ""
            let fullTextWidth = textToDisplay.widthWithConstrainedHeight(height: height, font: font)
            let finalTextWidth = min(fullTextWidth, 180)
            let width = finalTextWidth + 40
            videoGameCellSizeArray.append(CGSize(width: width, height: height))
        }
    }
}

