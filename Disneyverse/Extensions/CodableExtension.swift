//
//  CodableExtension.swift
//  Disneyverse
//
//  Created by Faizan Memon on 11/05/23.
//

import Foundation

extension Encodable {
    var jsonString: String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted // Optional: to make the JSON string more readable
        if let jsonData = try? encoder.encode(self),
           let decodedString = String(data: jsonData, encoding: .utf8) {
            return decodedString
        }
        return "Failed to encode"
    }
}
