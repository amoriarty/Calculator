//
//  CalculatorController.swift
//  Calculator
//
//  Created by Alexandre LEGENT on 13/11/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import Foundation

protocol CalculatorDelegate: class {
    var printed: String? { get set }
}

final class CalculatorController {
    typealias Operator = (Int, Int) -> (Int, Bool)
    weak var delegate: CalculatorDelegate?
    private var left: String?
    private var right: String?
    private var currentOperator: String?
    private var mode = false
    
    private let operators: [String: Operator] = [
        "+": { $0.addingReportingOverflow($1) },
        "-": { $0.subtractingReportingOverflow($1) },
        "x": { $0.multipliedReportingOverflow(by: $1) },
        "/": { $0.dividedReportingOverflow(by: $1) },
    ]
    
    // MARK:- Accessor
    func press(_ button: String) {
        print("[DEBUG]: BUTTON PRESSED \(button)")
        
        switch button {
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9": press(digit: button)
        case "+", "-", "x", "/": press(operatr: button)
        case "+/-": pressInvers()
        case "=": pressEqual()
        case "C": reset()
        default: break
        }
    }
    
    // MARK:- Logics
    private func press(digit: String) {
        if mode { currentOperator = nil }
        mode = false
        
        /* If left isn't defined, add current digit to it. */
        guard let left = left else {
            self.left = digit
            delegate?.printed = self.left
            return
        }
        
        /* If operator isn't defined, append digit to left. */
        guard currentOperator != nil else {
            self.left = left + digit
            delegate?.printed = self.left
            return
        }
        
        /* If right isn't defined, add current digit to it. */
        guard let right = right else {
            self.right = digit
            delegate?.printed = self.right
            return
        }
        
        /* Finally, append digit to right if all guard statement have passed. */
        self.right = right + digit
        delegate?.printed = self.right
    }
    
    private func press(operatr: String) {
        currentOperator = operatr
        
        guard !mode else {
            self.right = nil
            return
        }
        
        pressEqual()
        mode = false
        right = nil
    }
    
    private func pressEqual() {
        /* If no operator is set, do nothing */
        guard let operatr = currentOperator else { return }
        
        /* Checking that both value is available */
        guard let left = left, let right = right else { return }
        
        /* Checking that conversion in Int success, otherwise present an error */
        guard let iLeft = Int(left), let iRight = Int(right) else {
            presentError()
            return
        }
        
        /* Getting calcul back and defined a result */
        guard let calcul = operators[operatr] else { return }
        let result = calcul(iLeft, iRight)
        
        /* Checking if an overflow occured, present error otherwise. */
        guard result.1 == false else {
            presentError()
            return
        }
        
        /* Setting result */
        let sResult = String(result.0)
        self.left = sResult
        delegate?.printed = sResult
        mode = true
    }
    
    private func pressInvers() {
        /* If right doesn't exist, same procedure but with left instead. */
        guard let right = right, right != "", right != "0", !mode else {
            guard let left = left, left != "", left != "0" else { return }
            guard let iLeft = Int(left) else { return }
            let value = iLeft * -1
            self.left = String(value)
            delegate?.printed = self.left
            return
        }
        
        /* Convert value in Int, then invers it and cast it back to string */
        guard let iRight = Int(right) else { return }
        let value = iRight * -1
        self.right = String(value)
        delegate?.printed = self.right
    }
    
    private func presentError() {
        reset()
        delegate?.printed = "Error"
    }
    
    private func reset() {
        left = nil
        right = nil
        currentOperator = nil
        delegate?.printed = "0"
    }
}

