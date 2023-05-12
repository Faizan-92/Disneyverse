//
//  VideoGameCollectionViewCell.swift
//  Disneyverse
//
//  Created by Faizan Memon on 12/05/23.
//

import Foundation
import UIKit

final class VideoGameCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!

    let selectedStateColor = UIColor.purple
    let nonSelectedStateColor = UIColor.lightGray

    override var isSelected: Bool {
        didSet {
            handleCellSelection()
        }
    }

    func configure(title: String, font: UIFont) {
        titleLabel.text = title
        titleLabel.textColor = UIColor.black
        titleLabel.font = font
        containerView.backgroundColor = nonSelectedStateColor
        containerView.layer.cornerRadius = containerView.frame.height / 2
        handleCellSelection()
    }

    func handleCellSelection() {
        if isSelected {
            containerView.backgroundColor = selectedStateColor
        } else {
            containerView.backgroundColor = nonSelectedStateColor
        }
    }
}

