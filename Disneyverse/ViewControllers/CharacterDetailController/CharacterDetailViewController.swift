//
//  CharacterDetailViewController.swift
//  Disneyverse
//
//  Created by Faizan Memon on 11/05/23.
//

import Foundation
import UIKit

class CharacterDetailViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var filmsCollectionView: UICollectionView!
    @IBOutlet weak var videoGamesCollectionView: UICollectionView!

    let viewModel: CharacterDetailViewModel

    init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: CharacterDetailViewController.className, bundle: nil)
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
        setupFilmsCollectionView()
        setupVideoGamesCollectionView()
    }

    private func setupFilmsCollectionView() {
        filmsCollectionView.delegate = self
        filmsCollectionView.dataSource = self

        filmsCollectionView.register(
            FilmDetailCollectionViewCell.self,
            forCellWithReuseIdentifier: FilmDetailCollectionViewCell.className
        )
    }

    private func setupVideoGamesCollectionView() {
        
    }
}

