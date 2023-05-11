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
    private var currentPage: Int = 1
    private var totalPages = Int.max
    private var pageSize = 20
    private var previouslySearchedName: String?
    let hideZeroStateViewSubject = PublishSubject<Bool>()
    
    var characters: [CharacterInfo] = [ ]

    func fetchCharacters(havingName newName: String) -> Observable<[CharacterInfo]?> {
        // Reset current and total pages count on receiving new name
        if previouslySearchedName != newName {
            currentPage = 1
            totalPages = Int.max
        } else { // Else fetch the next page of current name
            // But, if all pages are already fetched, don't hit API
            if currentPage == totalPages {
                return .just(nil)
            }
            currentPage += 1
        }

        previouslySearchedName = newName
        return disneyService.fetchCharacters(
            havingName: newName,
            pageNumber: currentPage,
            pageSize: pageSize
        )
            .map { [weak self] response -> [CharacterInfo]? in
                self?.totalPages = response?.pageInfo?.totalPages ?? 0
                let shouldHideZeroStateView = self?.totalPages != 0
                self?.hideZeroStateViewSubject.onNext(shouldHideZeroStateView)
                return response?.data
            }
        
    }

    func updateCharacters(newList: [CharacterInfo], shouldReplace: Bool) {
        if shouldReplace {
            characters = newList
        } else {
            characters += newList
        }
    }
}
