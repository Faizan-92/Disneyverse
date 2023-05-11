//
//  Logger.swift
//  Disneyverse
//
//  Created by Faizan Memon on 11/05/23.
//

import Foundation

final class Logger {
    static func log(_ text: String?) {
        #if DEBUG
        print(text ?? "nil")
        #endif
    }
}
