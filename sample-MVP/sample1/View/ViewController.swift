//
//  ViewController.swift
//  sample-MVP
//
//  Created by Yudai Fujioka on 2021/07/24.
//

import UIKit

final class ViewController: UIViewController {
    
    var presenter: PresenterInput!
    
   
    
    @IBOutlet private weak var beerAPIButton: UIButton! {
        didSet {
            beerAPIButton.addTarget(self, action: #selector(tappedBeerAPIButton), for: .touchUpInside)
        }
    }
    @IBOutlet private weak var nextButton: UIButton! {
        didSet {
            nextButton.addTarget(self, action: #selector(tappedNextButton), for: .touchUpInside)
        }
    }
    @IBOutlet private weak var firstTextField: UITextField!
    @IBOutlet private weak var secondTextField: UITextField!
    @IBOutlet private weak var calculateButton: UIButton! {
        didSet {
            calculateButton.addTarget(self, action: #selector(tappedCaluculateButton), for: .touchUpInside)
        }
    }
    
    @IBOutlet private weak var resultLabel: UILabel! {
        didSet {
               if resultLabel == nil {
                   print("Label set to nil!")
               }
           }
    }
    
    func inhect(presenter: Presenter) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
}

@objc private extension ViewController {
    func tappedCaluculateButton() {
        guard let firstText = firstTextField.text,
              let secondText = secondTextField.text else {
            return
        }
        presenter.caluculateButtonTapped(firstText: firstText, secondText: secondText)
    }
    
    func tappedNextButton() {
        guard let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateInitialViewController() as? UsersViewController else {
            fatalError()
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tappedBeerAPIButton() {
        guard let vc = UIStoryboard.init(name: "Beer", bundle: nil).instantiateInitialViewController() as? BeerViewController else {
            fatalError()
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: PresenterOutPut {
    
    func setResultLabel(resultText: String) {
        resultLabel.text = resultText
    }
    
    
    
}
