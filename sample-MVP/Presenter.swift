//
//  Presenter.swift
//  sample-MVP
//
//  Created by Yudai Fujioka on 2021/07/24.
//

import Foundation
protocol PresenterInput {
    
    func caluculateButtonTapped(firstText: String, secondText: String)
    
}

protocol PresenterOutPut {
    func setResultLabel(resultText: String)
}

class Presenter: PresenterInput {
    
    let view: PresenterOutPut
    let model: ModelInput
    
    init(view: PresenterOutPut, model: ModelInput) {
        self.view = view
        self.model = model
    }
    
    func caluculateButtonTapped(firstText: String, secondText: String) {
        guard let firstNum = Double(firstText),
              let secondNum = Double(secondText)
        else {
            return
        }
        
        view.setResultLabel(resultText: String(format: "%.1f", model.sum(firstNum: firstNum, secondNum: secondNum)))
        
    }
}
