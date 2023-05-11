//
//  NSObjectExtension.swift
//  Disneyverse
//
//  Created by Faizan Memon on 11/05/23.
//

import Foundation

public extension NSObject {

    var className: String {
        return "\(self)"
    }

    static var className: String {
        return "\(self)"
    }
}
