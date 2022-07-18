//
//  SearchRepositoryRequest.swift
//  SampleCombine
//
//  Created by cmStudent on 2022/07/13.
//

import Foundation

// Subscriber : 値を受信

protocol APIRequestType {
    associatedtype Response: Decodable
    
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
}

struct MovieRequest: APIRequestType {
    typealias Response = Ghibli
    
    let path = "/films/"
    
    var queryItems: [URLQueryItem]?
    
    var id: String = ""
    
    init(id: String) {
        self.id = id
        self.queryItems = [.init(name: "id", value: id)]
    }
}
