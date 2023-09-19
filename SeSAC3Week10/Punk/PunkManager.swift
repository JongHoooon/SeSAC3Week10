//
//  PunkManager.swift
//  SeSAC3Week10
//
//  Created by JongHoon on 2023/09/19.
//

import Foundation

import Alamofire

final class PunkManager {
    
    static let shared = PunkManager()
    private init() {}
    
    func punkRequest<T: Decodable>(
        of: T.Type,
        api: PunkAPI
    ) async throws -> T {
        
        let dataTask = AF.request(api)
            .validate()
            .serializingDecodable(of)
        
        switch await dataTask.result {
        case let .success(data):
            return data
        case let .failure(error):
            throw error
        }
    }
}
