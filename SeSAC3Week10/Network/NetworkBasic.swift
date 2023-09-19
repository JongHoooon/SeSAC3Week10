//
//  NetworkBasic.swift
//  SeSAC3Week10
//
//  Created by JongHoon on 2023/09/19.
//

import Foundation

import Alamofire

enum SeSACError: Int, Error {
    case unauthorized = 401
    case permissionDenied = 403
    case invalidServer = 500
    case missingParameter = 400
    
    var errorDescription: String {
        switch self {
        case .unauthorized:
            return "인증 정보가 없습니다."
        case .permissionDenied:
            return "권한이 없습니다."
        case .invalidServer:
            return "서버 점검 중입니다."
        case .missingParameter:
            return "검색어를 입력해주세요."
        }
    }
}

final class NetworkBasic {
    
    static let shared = NetworkBasic()
    private init() {}
    
    func request(api: SeSACAPI, query: String, completion: @escaping (Result<Photo, SeSACError>) -> Void) {   // search photo
 
        AF.request(     // search photo
            api.endpoint,
            method: api.method,
            parameters: api.query,
            encoding: URLEncoding(destination: .queryString),
            headers: api.headers
        )
        .responseDecodable(
            of: Photo.self,
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
    
    func random(api: SeSACAPI, completion: @escaping (Result<PhotoResult, SeSACError>) -> Void) { // random photo

        AF.request(     // search photo
            api.endpoint,
            method: api.method,
            headers: api.headers
        )
        .responseDecodable(
            of: PhotoResult.self,
            completionHandler: { response in
                switch response.result {
                case let .success(data):
                    completion(.success(data))
                case .failure(_):
                    let statusCode = response.response?.statusCode ?? 500
                    guard let error = SeSACError(rawValue: statusCode) else { return }
                    completion(.failure(error))
                }
            }
        )
    }
    
    func detailPhoto(api: SeSACAPI, id: String, completion: @escaping (Result<PhotoResult, SeSACError>) -> Void) {
        AF.request(     // search photo
            api.endpoint,
            method: api.method,
            headers: api.headers
        )
        .responseDecodable(
            of: PhotoResult.self,
            completionHandler: { response in
                switch response.result {
                case let .success(data):
                    completion(.success(data))
                case .failure(_):
                    let statusCode = response.response?.statusCode ?? 500
                    guard let error = SeSACError(rawValue: statusCode) else { return }
                    completion(.failure(error))
                }
            }
        )
    }
}
