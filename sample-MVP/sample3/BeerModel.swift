//
//  BeerModel.swift
//  sample-MVP
//
//  Created by Yudai Fujioka on 2021/07/28.
//

import Foundation

struct BeerModel: Codable {
    let name: String
    let id: Int
}

protocol PunkAPIDataModelInput {
    func fetchBeers(completion: @escaping((Result<[BeerModel], Error>) -> ()))
}

class PunkAPIDataModel: PunkAPIDataModelInput {
    func fetchBeers(completion: @escaping ((Result<[BeerModel], Error>) -> ())) {
        guard let url = URL(string: "https://api.punkapi.com/v2/beers") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _error = error {
                completion(.failure(_error))
                return
            }
            
            if let _data = data {
                do {
                    let beerData = try JSONDecoder().decode([BeerModel].self, from: _data)
                    completion(.success(beerData))
                } catch(let error) {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
