//
//  ViewController.swift
//  sample-MVP
//
//  Created by Yudai Fujioka on 2021/07/24.
//

import UIKit

final class ViewController: UIViewController {
    
    var presenter: PresenterInput!
    
   
    
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
}

extension ViewController: PresenterOutPut {
    
    func setResultLabel(resultText: String) {
        resultLabel.text = resultText
    }
    
}
