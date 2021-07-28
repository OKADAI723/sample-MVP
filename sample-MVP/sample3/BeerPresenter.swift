//
//  BeerPresenter.swift
//  sample-MVP
//
//  Created by Yudai Fujioka on 2021/07/28.
//

import Foundation

//入力要件
protocol BeerListPresenterInput {
    var numberOfBeers: Int { get }
    func beer(forRow row: Int) -> BeerModel?
    func ViewDidLoad()
    func didSelectRowAt(_ indexPath: IndexPath)
}

//Viewへの画面描画の指示
protocol BeerListPresenterOutPut: AnyObject {
    func didFetch(_ beers: [BeerModel])
    func didFailToFetchBeer(with error: Error)
    func didPrepareInfomation(of beer: BeerModel)
}

class BeerListPresenter: BeerListPresenterInput {
    
    private(set) var beers: [BeerModel] = []
    
    private weak var view: BeerListPresenterOutPut?
    private var dataModel: PunkAPIDataModelInput
    
    init(with view: BeerListPresenterOutPut) {
          self.view = view
          self.dataModel = PunkAPIDataModel()
      }
    
    var numberOfBeers: Int {
        return beers.count
    }
    
    func beer(forRow row: Int) -> BeerModel? {
        if row >= beers.count {
            return nil
        }
        return beers[row]
    }
    
    func ViewDidLoad() {
        dataModel.fetchBeers { [weak self] result in
                    switch result {
                    case .failure(let error):
                        self?.view?.didFailToFetchBeer(with: error)
                    case .success(let loadedBeer):
                        self?.beers = loadedBeer
                        guard let beers = self?.beers
                        else { fatalError() }
                        self?.view?.didFetch(beers)
                    }
                }
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        guard let beer = beer(forRow: indexPath.row)
            else { return }
            view?.didPrepareInfomation(of: beer)
        }
    }

