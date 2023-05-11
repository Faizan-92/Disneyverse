//
//  IconAsset.swift
//  Disneyverse
//
//  Created by Faizan Memon on 11/05/23.
//

import Foundation
import UIKit

public enum IconAsset: String {
    case oops = "ic_oops"

    public var templateImage: UIImage? {
        return UIImage(named: self.rawValue, in: Bundle.main, compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
    }

    public var originalImage: UIImage? {
        return UIImage(named: self.rawValue, in: Bundle.main, compatibleWith: nil)?.withRenderingMode(.alwaysOriginal)
    }
}
