//
//  CharacterDetailViewModel.swift
//  Disneyverse
//
//  Created by Faizan Memon on 11/05/23.
//

import Foundation
import UIKit

final class CharacterDetailViewModel {
    let imageUrl: URL?
    let name: String?
    let filmsList: [String?]
    let videoGamesList: [String?]
    let sourceUrl: URL?

    init(
        imageUrl: URL?,
        name: String?,
        filmsList: [String?],
        videoGamesList: [String?],
        sourceUrl: URL?
    ) {
        self.imageUrl = imageUrl
        self.name = name
        self.filmsList = filmsList
        self.videoGamesList = videoGamesList
        self.sourceUrl = sourceUrl
    }
}
