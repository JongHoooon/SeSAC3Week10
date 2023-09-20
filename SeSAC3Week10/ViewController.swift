//
//  ViewController.swift
//  SeSAC3Week10
//
//  Created by JongHoon on 2023/09/19.
//

import UIKit

import Alamofire
import SnapKit
import Kingfisher

class ViewController: UIViewController {
    
    let viewModel = ViewModel()
    
    private lazy var scrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .green
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 4.0
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()
    
    private let imageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureGesture()
        
//        viewModel.request { [weak self] url in
//            self?.imageView.kf.setImage(with: url)
//        }
        
        Network.shared.requestConvertible(
            type: PhotoResult.self, api: .random, completion: { result in
                
            })
        
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
        
//        Network.shared.request(
//            type: PhotoResult.self,
//            api: .photo(id: "Mc911VCPEk0"),
//            completion: { result in
//                switch result {
//                case let .success(success):
//                    dump(success)
//                case let .failure(failure):
//                    print(failure.errorDescription)
//                }
//            })
        
//        Task {
//            do {
//               let beers = try await PunkManager.shared.punkRequest(of: [Beer].self, api: .getBeers)
//                print(beers)
//            } catch {
//                print(error)
//            }
//        }
        
//        Task {
//            do {
//                let beer = try await PunkManager.shared.punkRequest(
//                    of: [Beer].self,
//                    api: .getSingleBeer(id: 1)
//                )
//                print(beer)
//            } catch {
//                print(error)
//            }
//        }
        
//        Task {
//            do {
//                let beer = try await PunkManager.shared.punkRequest(
//                    of: [Beer].self,
//                    api: .getRandomBeer
//                )
//                print(beer)
//            } catch {
//                print(error)
//            }
//        }
        
    }
    
    func request() {
        Network.shared.requestConvertible(
            type: PhotoResult.self,
            api: .random,
            completion: { [weak self] result in
                switch result {
                case .success(let photoResult):
                    self?.imageView.kf.setImage(with: URL(string: photoResult.urls.thumb))
                case .failure(let failure):
                    print(failure)
                }
            }
        )
    }
    
    func configureGesture() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(doubleTapGesture)
        )
        tap.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(tap)
    }
    
    @objc
    func doubleTapGesture() {
        if scrollView.zoomScale == 1 {
            scrollView.setZoomScale(2.0, animated: true)
        } else {
            scrollView.setZoomScale(1.0, animated: true)
        }
    }
    
    func configureLayout() {
        scrollView.snp.makeConstraints {
            $0.size.equalTo(200.0)
            $0.center.equalTo(view)
        }
        imageView.snp.makeConstraints {
            $0.size.equalTo(scrollView)
        }
    }
    
    func configureHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
    }
}

extension ViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
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
