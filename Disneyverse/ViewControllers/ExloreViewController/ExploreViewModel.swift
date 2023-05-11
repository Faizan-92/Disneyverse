//
//  ExploreViewModel.swift
//  Disneyverse
//
//  Created by Faizan Memon on 11/05/23.
//

import Foundation
import RxSwift
import RxRelay

final class ExploreViewModel {
    
    private let disneyService = DisneyService()
    private var disposeBag = DisposeBag()
    
    var characters: [CharacterInfo] = [ ]

    func fetchAllCharacters() -> Observable<[CharacterInfo]?> {
        disneyService.fetchAllCharacters()
            .map { $0?.data }
    }

    func fetchCharacter(havingName name: String) -> Observable<[CharacterInfo]?> {
        disneyService.fetchCharacters(havingName: name)
            .map { $0?.data }
    }

    func updateCharacters(newList: [CharacterInfo], shouldReplace: Bool) {
        if shouldReplace {
            characters = newList
        } else {
            characters += newList
        }
    }
}
