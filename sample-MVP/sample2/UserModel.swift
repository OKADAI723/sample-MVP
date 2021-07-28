//
//  UserModel.swift
//  sample-MVP
//
//  Created by Yudai Fujioka on 2021/07/27.
//

import Foundation

struct UserModel: Codable {
    let name: String
    let email: String
    let username: String
}

protocol FetchUserProtocol {
    func fetchUser(completion: @escaping(((Result<[UserModel], Error>) -> ())))
}

final class FetchUserAPI: FetchUserProtocol {
    func fetchUser(completion: @escaping (((Result<[UserModel], Error>) -> ()))) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _error = error {
                completion(.failure(_error))
            }
            
            if let _data = data {
                do {
                    let user = try JSONDecoder().decode([UserModel].self, from: _data)
                    completion(.success(user))
                } catch (let error) {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
