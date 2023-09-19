//
//  PunkAPI.swift
//  SeSAC3Week10
//
//  Created by JongHoon on 2023/09/19.
//

import Foundation

import Alamofire

enum PunkAPI: URLRequestConvertible {
    
    case getBeers
    case getSingleBeer(id: Int)
    case getRandomBeer
    
    private var endpoint: String {
        let baseURL = "https://api.punkapi.com/v2/beers"
        switch self {
        case .getBeers:
            return baseURL
        case let .getSingleBeer(id):
            return baseURL + "/\(id)"
        case .getRandomBeer:
            return baseURL + "/random"
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        default: return .get
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: endpoint) else {
            throw PunkError.invalidURL
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}
