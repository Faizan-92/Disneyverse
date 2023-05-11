//
//  ExploreViewModel.swift
//  Disneyverse
//
//  Created by Faizan Memon on 11/05/23.
//

import Foundation
import RxSwift

final class ExploreViewModel {
    
    private let disneyService = DisneyService()
    private var disposeBag = DisposeBag()

    func fetchAllCharacters() {
        disneyService.fetchAllCharacters(
            completionHandler: { charactersInfo in
                
            },
            errorHandler: {
                Logger.log("api failed: fetchAllCharacters")
            }
        )
    }

    func fetchCharacter(havingName name: String) {
        disneyService.fetchCharacters(havingName: name)
            .compactMap { $0 }
            .withUnretained(self)
            .subscribe(onNext: { owner, response in
                Logger.log("api rx: " + response.jsonString)
            })
            .disposed(by: disposeBag)
    }
}
