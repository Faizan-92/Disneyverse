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

    case getOneCharacter(id: String)
    case filterCharacters(name: String, pageNumber: Int, pageSize: Int)

    var endPoint: URL {
        return baseUrl.appendingPathComponent(path)
    }

    var path: String {
        switch self {
        case .filterCharacters:
            return "character"
        case .getOneCharacter(let characterId):
            return "character/" + (characterId)
        }
    }

    var queryParams: [URLQueryItem]? {
        switch self {
        case .filterCharacters(let inputName, let pageNumber, let pageSize):
            return [
                URLQueryItem(name: "name", value: inputName),
                URLQueryItem(name: "page", value: String(pageNumber)),
                URLQueryItem(name: "pageSize", value: String(pageSize))
            ]
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
    
    func fetchCharacters(
        havingName name: String,
        pageNumber: Int,
        pageSize: Int,
        errorHandler: @escaping (() -> Void)
    ) -> Observable<CharacterInfoResponseModel?> {

        let endPoint: DisneyServiceEndPoint = .filterCharacters(
            name: name,
            pageNumber: pageNumber,
            pageSize: pageSize
        )

        return makeRxRequest(
            url: endPoint.url,
            method: endPoint.methodType,
            errorHandler: errorHandler
        )
    }
    
}
