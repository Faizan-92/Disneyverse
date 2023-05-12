//
//  CharacterDetailViewController + CollectionView.swift
//  Disneyverse
//
//  Created by Faizan Memon on 11/05/23.
//

import Foundation
import UIKit

extension CharacterDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let textToDisplay = (viewModel.filmsList[indexPath.row] ?? "")
        let width = textToDisplay.widthWithConstrainedHeight(height: filmListItemHeight, font: filmListFont) + 2 * filmListItemPadding
        return CGSize(width: width, height: filmListItemHeight)
    }
}

extension CharacterDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == videoGamesCollectionView ? viewModel.videoGamesList.count : viewModel.filmsList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == videoGamesCollectionView {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: VideoGameCollectionViewCell.className,
                for: indexPath
            ) as! VideoGameCollectionViewCell
            
            let gameName = viewModel.videoGamesList[indexPath.row] ?? ""
            cell.configure(title: gameName, font: videoGameListFont)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FilmDetailCollectionViewCell.className,
                for: indexPath
            ) as! FilmDetailCollectionViewCell
            
            let filmName = viewModel.filmsList[indexPath.row] ?? ""
            let cellViewModel = FilmDetailCollectionViewCellViewModel(
                name: filmName,
                font: filmListFont
            )
            cell.setupCell(viewModel: cellViewModel)
            return cell
        }
    }
}

extension CharacterDetailViewController: CustomCollectionViewLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        return videoGameCellSizeArray[indexPath.row]
    }
    
    func collectionView(_ collectionView: UICollectionView, offsetForItemAtIndexPath indexPath: IndexPath) -> (CGFloat, CGFloat) {
        var xOffset: CGFloat = 0
        var yOffset: CGFloat = 0
        // Note: the logic can be optimised further by caching the offset and size of previous cells.
        // Not doing it right now to keep code simple, as it's is just a simple calculation
        // showing almost similar CPU usage as controllers not having videoGameCollectionView.
        for index in 0..<indexPath.row {
            let cellSize = videoGameCellSizeArray[index]
            if xOffset + cellSize.width > collectionView.bounds.width {
                xOffset = cellSize.width
                yOffset += cellSize.height
            } else {
                xOffset += cellSize.width
            }
        }
        let newCellSize = videoGameCellSizeArray[indexPath.row]
        if xOffset + newCellSize.width > collectionView.bounds.width {
            xOffset = 0
            yOffset += newCellSize.height
        }
        return (xOffset, yOffset)
    }

    func getContentSize(_ collectionView: UICollectionView) -> CGSize {
        var xPos: CGFloat = 0
        var height: CGFloat = videoGameCellSizeArray[0].height
        for index in 0..<viewModel.videoGamesList.count {
            let cellSize = videoGameCellSizeArray[index]
            if xPos + cellSize.width > collectionView.bounds.width {
                xPos = 0
                height += cellSize.height
            } else {
                xPos += cellSize.width
            }
        }
        return CGSize(width: collectionView.bounds.width, height: height)
    }
}
