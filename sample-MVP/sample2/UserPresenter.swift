//
//  UserPresenter.swift
//  sample-MVP
//
//  Created by Yudai Fujioka on 2021/07/27.
//

import Foundation
import UIKit

protocol UserPresenterInput {
    var numberOfUsers: Int { get }
    func user(forRow row: Int) -> UserModel?
    func viewDidLoad()
    func didSelectRowAt(_ indexPath: IndexPath)
    
}

protocol UserPresenterOutPut: AnyObject {
    func didFetch(_ users: [UserModel])
    func didFailToFetchUser(with error: Error)
    func didPrepareInfomation(of user: UserModel)
}

//typealias PresenterDelegate = UserPresenterDelegate & UIViewController

final class UserPresenter: UserPresenterInput {
    
    private weak var view: UserPresenterOutPut?
    private var dataModel: FetchUserProtocol
    
    init(with view: UserPresenterOutPut) {
        self.view = view
        self.dataModel = FetchUserAPI()
    }
    
    private(set) var users: [UserModel] = []
    
    
    func user(forRow row: Int) -> UserModel? {
        if row >= users.count {
            return nil
        }
        return users[row]
    }
    
    var numberOfUsers: Int {
        return users.count
    }
    
    func viewDidLoad() {
        dataModel.fetchUser { [weak self] result in
                    switch result {
                    case .failure(let error):
                        self?.view?.didFailToFetchUser(with: error)
                    case .success(let loadedUser):
                        self?.users = loadedUser
                        guard let beers = self?.users
                        else { fatalError() }
                        self?.view?.didFetch(beers)
                    }
                }
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        guard let user = user(forRow: indexPath.row)
            else { return }
            view?.didPrepareInfomation(of: user)
        }
    }


