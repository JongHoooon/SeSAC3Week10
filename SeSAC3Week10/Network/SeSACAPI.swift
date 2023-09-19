//
//  SeSACAPI.swift
//  SeSAC3Week10
//
//  Created by JongHoon on 2023/09/19.
//

import Foundation

import Alamofire

//enum Router: URLRequestConvertible {
//    
//    func asURLRequest() throws -> URLRequest {
//        
//    }
//}


enum SeSACAPI {
    private static let key = "kTIzwJcDLJgzVqbNtt7hlgSbFJlVVCeM6qjogbqwGuc"
    
    case search(query: String)
    case random
    case photo(id: String) // 연관값, associated value
    
    private var baseURL: String {
        return "https://api.unsplash.com/"
    }
    
    var endpoint: URL {
        switch self {
        case .search:
            return URL(string: baseURL + "search/photos")!
        case .random:
            return URL(string: baseURL + "photos/random")!
        case let .photo(id):
            return URL(string: baseURL + "photos/\(id)")!
        }
    }

    var headers: HTTPHeaders {
        return ["Authorization": "Client-ID \(SeSACAPI.key)"]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var query: [String: String] {
        switch self {
        case let .search(query):
            return ["query": query]
        case .random, .photo:
            return ["": ""]
        }
    }
}
