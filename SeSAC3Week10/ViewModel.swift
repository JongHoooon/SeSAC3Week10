//
//  ViewModel.swift
//  SeSAC3Week10
//
//  Created by JongHoon on 2023/09/20.
//

import Foundation

final class ViewModel {
    
    func request(completion: @escaping (URL?) -> Void) {
        Network.shared.requestConvertible(
            type: PhotoResult.self,
            api: .random,
            completion: { [weak self] result in
                switch result {
                case .success(let photoResult):
                    completion(URL(string: photoResult.urls.thumb))
                    break
                case .failure(let failure):
                    print(failure)
                }
            }
        )
    }
}
