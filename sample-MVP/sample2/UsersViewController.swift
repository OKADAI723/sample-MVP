//
//  UsersViewController.swift
//  sample-MVP
//
//  Created by Yudai Fujioka on 2021/07/27.
//

import UIKit

final class UsersViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: CELL_ID)
        }
    }
    
    private let presenter = UserPresenter()
    private let CELL_ID = "CELL_ID"
    private let CELL_NIB = "CELL_NIB"
    
    private var users: [UserModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        presenter.setViewDelegate(delegate: self)
        presenter.getUsers()
        
    }
}

extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        presenter.didTapUser(user: users[indexPath.row])
    }
}

extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath )
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
    
    
}

extension UsersViewController: UserPresenterDelegate {
    func presentUsers(users: [UserModel]) {
        self.users = users
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "閉じる", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}
