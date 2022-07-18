//
//  APIService.swift
//  SampleCombine
//
//  Created by cmStudent on 2022/07/11.
//

import Foundation
import Combine
import SwiftUI

// Publisher : 値を送信

protocol APIServiceType {
    // 成功すればリクエストで定義したレスポンス(JSON)を返し、失敗したらエラーを返す
    func request<Request>(with request: Request)
    -> AnyPublisher<[Request.Response],  APIServiceError>
    where Request: APIRequestType
    
}


final class APIService: APIServiceType {
    // 変換前のURL
    private let baseURLString: String
    init(baseURLString: String = "https://ghibliapi.herokuapp.com/films/") {
        self.baseURLString = baseURLString
    }
    
    func request<Request>(with request: Request)
    -> AnyPublisher<[Request.Response],  APIServiceError> where Request: APIRequestType {
        
        // URLの文字列をURL型に変換
        guard let pathURL = URL(string: request.path, relativeTo: URL(string:baseURLString)) else {
            print("URLが変換出来ませんでした")
            return Fail(error: APIServiceError.invalidURL).eraseToAnyPublisher()
        }
        
        var compornents = URLComponents(url: pathURL, resolvingAgainstBaseURL: true)!
//        compornents.queryItems = request.queryItems
        var request = URLRequest(url: compornents.url!)
        
        let decoder = JSONDecoder()
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { data, URLResponse in data }
            .mapError { _ in APIServiceError.responseError }
            .decode(type: [Request.Response].self, decoder: decoder)
            .mapError(APIServiceError.parseError)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}


enum APIServiceError: Error {
    /// URLが正しくない
    case invalidURL
    /// githubAPIのレスポンスにエラーがある
    case responseError
    /// JSONをパースしたときに発生したエラー
    case parseError(Error)
}

