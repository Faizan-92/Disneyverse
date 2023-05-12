//
//  VideoGameCollectionViewCell.swift
//  Disneyverse
//
//  Created by Faizan Memon on 12/05/23.
//

import Foundation
import UIKit

final class VideoGameCollectionViewCell: UICollectionViewCell {

    @IBOutlet var lblTitle:UILabel!
    @IBOutlet weak var closeButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 1
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.height / 2
    }

    func configure(title: String) {
        lblTitle.text = title
        lblTitle.textColor = .black
        layer.borderColor = UIColor.random.cgColor
        backgroundColor = UIColor.random
        closeButton.titleLabel?.text = ""
    }
}

