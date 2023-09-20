//
//  Router.swift
//  SeSAC3Week10
//
//  Created by JongHoon on 2023/09/20.
//

import Foundation

import Alamofire

enum Router: URLRequestConvertible {
    
    private static let key = "kTIzwJcDLJgzVqbNtt7hlgSbFJlVVCeM6qjogbqwGuc"
    
    case search(query: String)
    case random
    case photo(id: String) // 연관값, associated value
    
    private var baseURL: URL {
        return URL(string: "https://api.unsplash.com")!
    }
    
    private var path: String {
        switch self {
        case .search:
            return "search/photos"
        case .random:
            return "photos/random"
        case let .photo(id):
            return "photos/\(id)"
        }
    }

    private var headers: HTTPHeaders {
        return ["Authorization": "Client-ID \(Router.key)"]
    }
    
    private var method: HTTPMethod {
        return .get
    }
    
    private var query: [String: String] {
        switch self {
        case let .search(query):
            return ["query": query]
        case .random, .photo:
             return ["": ""]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.headers = headers
        request = try URLEncodedFormParameterEncoder(destination: .methodDependent)
            .encode(query, into: request)
        return request
    }
}
