//
//  BaseServiceEndPoint.swift
//  Disneyverse
//
//  Created by Faizan Memon on 11/05/23.
//

import Foundation
import Alamofire

protocol BaseServiceEndPoint {
    var baseUrl: URL { get }
    var queryParams: [URLQueryItem]? { get }
    var path: String { get }
    var methodType: HTTPMethod { get }
    var url: URL? { get }
}

extension BaseServiceEndPoint {
    var baseUrl: URL {
        return URL(string: "https://api.disneyapi.dev")!
    }

    var queryParams: [String: String] {
        return [:]
    }

    var url: URL? {
        let pathString = self.baseUrl.appendingPathComponent(self.path).absoluteString
        var urlComponents = URLComponents(string: pathString)
        if let queryParams = self.queryParams {
            urlComponents?.queryItems = queryParams
        }
        return urlComponents?.url
    }
}
