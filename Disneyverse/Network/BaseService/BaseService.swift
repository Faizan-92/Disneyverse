//
//  BaseService.swift
//  Disneyverse
//
//  Created by Faizan Memon on 11/05/23.
//

import Foundation
import Alamofire
import RxSwift

class BaseService {
    
    /// Calls API using params and logs request and response objects to console for debugging. Also validates the response
    /// using status code
    /// - Parameters:
    ///   - url: url which should be hit
    ///   - method: REST method type. e.g. get, put, post, delete, patch, etc.
    ///   - parameters: The query params to be appended to base urlString
    ///   - completionHandler: Completion handler for successful API completion
    ///   - errorHandler: Closure to handle error in API response
    func callApi<T: Codable>(
        url: URL?,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        completionHandler: @escaping((T) -> Void),
        errorHandler: @escaping((AFError) -> Void)
    ) {
        guard let urlString = url?.absoluteString else {
            errorHandler(.parameterEncodingFailed(reason: .missingURL))
            return
        }

        let request = AF.request(
            urlString,
            method: method,
            parameters: parameters
        )
        .debug()
        .validate()
        .responseDecodable(of: T.self) { response in
            Logger.log(response.value.jsonString)
            if let value = response.value {
                completionHandler(value)
            } else if let error = response.error {
                errorHandler(error)
            }
        }
        Logger.log(request.description)
    }

    /// Calls API using params and logs request and response objects to console for debugging. Also validates the response
    /// using status code and returns Observable to subscribe to response or error.
    /// - Parameters:
    ///   - url: url which should be hit
    ///   - method: REST method type. e.g. get, put, post, delete, patch, etc.
    ///   - parameters: The query params to be appended to base urlString
    ///   - completionHandler: Completion handler for successful API completion
    ///   - errorHandler: Closure to handle error in API response
    /// - Returns: Observable can be subscribed to, to get notified about API response or error.
    func makeRxRequest<T: Codable>(
        url: URL?,
        method: HTTPMethod,
        parameters: Parameters? = nil
    ) -> Observable<T?> {

        guard let urlString = url?.absoluteString else {
            return Observable.just(nil)
        }

        return Observable.create { observer in
            let request = AF.request(
                urlString,
                method: method,
                parameters: parameters
            )
            .debug()
            .validate()
            .responseDecodable(of: T.self) { response in
                Logger.log(response.value.jsonString)
                switch response.result {
                case .success(let result):
                    observer.onNext(result)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }

            Logger.log(request.description)

            return Disposables.create {
                request.cancel()
            }
        }
    }

}
