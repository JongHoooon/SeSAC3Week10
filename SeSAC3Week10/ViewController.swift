//
//  ViewController.swift
//  SeSAC3Week10
//
//  Created by JongHoon on 2023/09/19.
//

import UIKit

import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Network.shared.request(
//            type: Photo.self,
//            api: .search(query: "apple"),
//            completion: { result in
//                switch result {
//                case let .success(success):
//                    dump(success)
//                case let .failure(failure):
//                    print(failure.errorDescription)
//                }
//            }
//        )
//        
//        Network.shared.request(
//            type: PhotoResult.self,
//            api: .random,
//            completion: { result in
//                switch result {
//                case let .success(success):
//                    dump(success)
//                case let .failure(failure):
//                    print(failure.errorDescription)
//                }
//            }
//        )
        
//        NetworkBasic.shared.random { photo, error in
//            if let error {
//
//            }
//
//            if let photo {
//
//            }
//        }

//        NetworkBasic.shared.request(query: <#T##String#>, completion: <#T##(Result<Photo, Error>) -> Void#>)
        
        Network.shared.request(
            type: PhotoResult.self,
            api: .photo(id: "Mc911VCPEk0"),
            completion: { result in
                switch result {
                case let .success(success):
                    dump(success)
                case let .failure(failure):
                    print(failure.errorDescription)
                }
            })
    }
}

// Codable: Decodable + Encodable
struct Photo: Decodable {
    let total: Int
    let total_pages: Int
    let results: [PhotoResult]
}

struct PhotoResult: Decodable {
    let id : String
    let created_at: String
    let urls: PhotoURL
}

struct PhotoURL: Decodable {
    let full: String
    let thumb: String
}
