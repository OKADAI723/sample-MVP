//
//  UserPresenter.swift
//  sample-MVP
//
//  Created by Yudai Fujioka on 2021/07/27.
//

import Foundation
import UIKit

protocol UserPresenterDelegate: AnyObject {
    func presentUsers(users: [UserModel])
    func presentAlert(title: String, message: String)
    
}

typealias PresenterDelegate = UserPresenterDelegate & UIViewController

class UserPresenter {
    weak var delegate: UserPresenterDelegate?
    
    public func getUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let _data = data, error == nil else {
                return
            }
            do {
                let users = try JSONDecoder().decode([UserModel].self, from: _data)
                self?.delegate?.presentUsers(users: users)
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
    public func setViewDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    public func didTapUser(user: UserModel) {
        delegate?.presentAlert(title: user.name, message: "\(user.name) has an email of \(user.email) and username is \(user.username)")
    }
}
