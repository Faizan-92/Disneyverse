//
//  CharacterInfoTableViewCellViewModel.swift
//  Disneyverse
//
//  Created by Faizan Memon on 11/05/23.
//

import Foundation

final class CharacterInfoTableViewCellViewModel {
    let name: String
    let profileImageUrl: String
    
    init(info: CharacterInfo) {
        name = info.name ?? ""
        profileImageUrl = info.imageUrl ?? ""
    }
}
