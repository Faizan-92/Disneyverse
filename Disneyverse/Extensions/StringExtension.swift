//
//  StringExtension.swift
//  Disneyverse
//
//  Created by Faizan Memon on 12/05/23.
//

import Foundation
import UIKit

extension String {
    /// Returns total width required to accommodate all characters of given string using a particular font
    func widthWithConstrainedHeight(height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.width
    }
}
