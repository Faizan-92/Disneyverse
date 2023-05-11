//
//  FilmDetailCollectionViewCell.swift
//  Disneyverse
//
//  Created by Faizan Memon on 11/05/23.
//

import Foundation
import UIKit

final class FilmDetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func setupCell(viewModel: FilmDetailCollectionViewCellViewModel) {
        nameLabel.text = viewModel.name
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
    }
}
