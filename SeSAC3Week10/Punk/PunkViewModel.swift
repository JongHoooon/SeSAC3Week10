//
//  PunkViewModel.swift
//  SeSAC3Week10
//
//  Created by JongHoon on 2023/09/21.
//

import Foundation

final class PunkViewModel {
    
    func fetchBeers(completion: @escaping ([Beer]) -> Void) {
        Task {
            do {
                let beers = try await PunkManager.shared.punkRequest(of: [Beer].self, api: .getBeers)
                completion(beers)
            } catch {
                print(error)
            }
        }
    }
    
    func fetchBeer(id: Int, completion: @escaping (Beer) -> Void) {
        Task {
            do {
                let beer = try await PunkManager.shared.punkRequest(of: Beer.self, api: .getSingleBeer(id: id))
                completion(beer)
            } catch {
                print(error)
            }
        }
    }
    
    func randomBeer(completion: @escaping (Beer) -> Void) {
        Task {
            do {
                let beer = try await PunkManager.shared.punkRequest(of: Beer.self, api: .getRandomBeer)
                completion(beer)
            } catch {
                print(error)
            }
        }
    }
}
