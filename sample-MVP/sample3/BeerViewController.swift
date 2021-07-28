//
//  BeerViewController.swift
//  sample-MVP
//
//  Created by Yudai Fujioka on 2021/07/28.
//

import UIKit

final class BeerViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: CELL_ID)
        }
    }
    
    private let CELL_ID = "CELL_ID"
    
    private var presenter: BeerListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        //Presenterへ伝える
        presenter = BeerListPresenter(with: self)
        presenter.ViewDidLoad()
    }
}

extension BeerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //Presenterへ伝える
        presenter.didSelectRowAt(indexPath)
    }
}

extension BeerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Presenterへ伝える
        return presenter.numberOfBeers
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID , for: indexPath)
        //Presenterへ伝える
        let beer = presenter.beer(forRow: indexPath.row)
        cell.textLabel?.text = beer?.name
        return cell
    }
}

extension BeerViewController: BeerListPresenterOutPut {
    func didFetch(_ beers: [BeerModel]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailToFetchBeer(with error: Error) {
        let alert = UIAlertController(title: "エラー", message: "\(error)" , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "閉じる", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func didPrepareInfomation(of beer: BeerModel) {
        let alert = UIAlertController(title: beer.name, message: "This beer is \(beer.name).", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "閉じる", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}
