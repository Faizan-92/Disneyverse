//
//  UIColorExtension.swift
//  Disneyverse
//
//  Created by Faizan Memon on 12/05/23.
//

import Foundation
import UIKit

extension UIColor {
    /// Generates a random color
    static var random: UIColor {
        let redValue = CGFloat(drand48())
        let greenValue = CGFloat(drand48())
        let blueValue = CGFloat(drand48())

        return UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
    }
}
