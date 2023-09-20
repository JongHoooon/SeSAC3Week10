//
//  Network.swift
//  SeSAC3Week10
//
//  Created by JongHoon on 2023/09/19.
//

import Foundation

import Alamofire

final class Network {

    static let shared = Network()
    private init() { }
    
    func requestConvertible<T: Decodable>(
        type: T.Type,
        api: Router,
        completion: @escaping (Result<T, Error>) -> Void
    ) {   // search photo
        
        AF.request(api)
            .responseDecodable(
                of: type,
                completionHandler: { response in
                    switch response.result {
                    case let .success(data):
                        completion(.success(data))
                        dump(data)
                    case let .failure(error):
//                        let statusCode = response.response?.statusCode ?? 500
//                        guard let error = SeSACError(rawValue: statusCode) else { return }
                        completion(.failure(error))
                    }
                }
            )

        
//        AF.request(     // search photo
//            api.endpoint,
//            method: api.method,
//            parameters: api.query,
//            encoding: URLEncoding(destination: .queryString),
//            headers: api.headers
//        )
//        .responseDecodable(
//            of: type,
//            completionHandler: { response in
//                switch response.result {
//                case let .success(data):
//                    completion(.success(data))
//                    dump(data)
//                case .failure(_):
//                    let statusCode = response.response?.statusCode ?? 500
//                    guard let error = SeSACError(rawValue: statusCode) else { return }
//                    completion(.failure(error))
//                }
//            }
//        )
    }
    
    func request<T: Decodable>(
        type: T.Type,
        api: SeSACAPI,
        completion: @escaping (Result<T, SeSACError>) -> Void
    ) {   // search photo
        
        AF.request(     // search photo
            api.endpoint,
            method: api.method,
            parameters: api.query,
            encoding: URLEncoding(destination: .queryString),
            headers: api.headers
        )
        .responseDecodable(
            of: type,
            completionHandler: { response in
                switch response.result {
                case let .success(data):
                    completion(.success(data))
                    dump(data)
                case .failure(_):
                    let statusCode = response.response?.statusCode ?? 500
                    guard let error = SeSACError(rawValue: statusCode) else { return }
                    completion(.failure(error))
                }
            }
        )
    }
}
