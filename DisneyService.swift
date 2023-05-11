//
//  DisneyService.swift
//  Disneyverse
//
//  Created by Faizan Memon on 11/05/23.
//

import Foundation
import Alamofire
import RxSwift

enum DisneyServiceEndPoint: BaseServiceEndPoint {

    case fetchAllCharacters
    case getOneCharacter(id: String)
    case filterCharacters(name: String)

    var endPoint: URL {
        return baseUrl.appendingPathComponent(path)
    }

    var path: String {
        switch self {
        case .fetchAllCharacters, .filterCharacters:
            return "character"
        case .getOneCharacter(let characterId):
            return "character/" + (characterId)
        }
    }

    var queryParams: [URLQueryItem]? {
        switch self {
        case .filterCharacters(let inputName):
            return [URLQueryItem(name: "name", value: inputName)]
        default:
            return nil
        }
    }

    var methodType: HTTPMethod {
        // Since all the APIs are get only api right now
        return .get
    }
}


final class DisneyService: BaseService {
    
    func fetchAllCharacters() -> Observable<CharacterInfoResponseModel?> {
        let endPoint: DisneyServiceEndPoint = .fetchAllCharacters
        return makeRxRequest(
            url: endPoint.url,
            method: endPoint.methodType
        )
    }

    func fetchCharacters(havingName name: String) -> Observable<CharacterInfoResponseModel?> {
        let endPoint: DisneyServiceEndPoint = .filterCharacters(name: name)
        return makeRxRequest(
            url: endPoint.url,
            method: endPoint.methodType
        )
    }
    
}
