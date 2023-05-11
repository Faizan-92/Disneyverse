//
//  CharacterDetailViewController + CollectionView.swift
//  Disneyverse
//
//  Created by Faizan Memon on 11/05/23.
//

import Foundation
import UIKit

extension CharacterDetailViewController: UICollectionViewDelegate {
    
}

extension CharacterDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.filmsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FilmDetailCollectionViewCell.className,
            for: indexPath
        ) as! FilmDetailCollectionViewCell
        
        let filmName = viewModel.filmsList[indexPath.row] ?? ""
        let cellViewModel = FilmDetailCollectionViewCellViewModel(name: filmName)
        cell.setupCell(viewModel: cellViewModel)
        return cell
    }
}
