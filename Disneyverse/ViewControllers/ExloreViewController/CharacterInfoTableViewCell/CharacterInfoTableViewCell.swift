//
//  CharacterInfoTableViewCell.swift
//  Disneyverse
//
//  Created by Faizan Memon on 11/05/23.
//

import Foundation
import UIKit
import SDWebImage

final class CharacterInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    func setupCell(viewModel: CharacterInfoTableViewCellViewModel) {
        profileImageView.sd_setImage(
            with: URL(string: viewModel.profileImageUrl),
            placeholderImage: UIImage(systemName: "person.fill")
        )
        profileImageView.layer.cornerRadius = 28
        nameLabel.text = viewModel.name
    }
}
