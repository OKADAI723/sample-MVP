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
    
    private let CELL_ID = "CELL_ID"
    private let CELL_NIB = "CELL_NIB"
    
    private var presenter: UserPresenter!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        presenter = UserPresenter(with: self)
        presenter.viewDidLoad()
        
        
    }
}

extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        presenter.didSelectRowAt(indexPath)
    }
}

extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfUsers
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath )
        let user = presenter.user(forRow: indexPath.row)
        cell.textLabel?.text = user?.name
        return cell
    }
    
    
}

extension UsersViewController: UserPresenterOutPut {
    func didFetch(_ users: [UserModel]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailToFetchUser(with error: Error) {
        let alert = UIAlertController(title: "エラー", message: "\(error)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "閉じる", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func didPrepareInfomation(of user: UserModel) {
        let alert = UIAlertController(title: "エラー", message: user.name, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "閉じる", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    
}
