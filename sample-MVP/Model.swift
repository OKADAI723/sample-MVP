//
//  Model.swift
//  sample-MVP
//
//  Created by Yudai Fujioka on 2021/07/24.
//

import Foundation

protocol ModelInput {
    func sum(firstNum: Double, secondNum: Double) -> Double
}

final class Model: ModelInput {
    func sum(firstNum: Double, secondNum: Double) -> Double {
        let result = firstNum + secondNum
        return result
    }
}
