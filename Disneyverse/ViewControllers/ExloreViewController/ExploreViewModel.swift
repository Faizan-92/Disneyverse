//
//  ExploreViewModel.swift
//  Disneyverse
//
//  Created by Faizan Memon on 11/05/23.
//

import Foundation

final class ExploreViewModel {
    
    let disneyService = DisneyService()

    func fetchAllCharacters() {
        disneyService.fetchAllCharacters(
            completionHandler: { charactersInfo in
                
            },
            errorHandler: {
                Logger.log("api failed: fetchAllCharacters")
            }
        )
    }
    
}
