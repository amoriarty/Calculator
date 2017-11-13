//
//  CalculatorController.swift
//  Calculator
//
//  Created by Alexandre LEGENT on 13/11/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import Foundation

protocol CalculatorDelegate: class {
	func have(_ result: String)
	func divisionByZero()
}

class CalculatorController {
	weak var delegate: CalculatorDelegate?
	var operation: String?
	private var left: Int?
	private var right: Int?
	
	private let operations: [String: (Int, Int) -> Int ] = [
		"+": { $0 + $1 },
		"-": { $0 - $1 },
		"/": { $0 / $1 },
		"x": { $0 * $1 }
	]
	
	var result: Int? {
		guard let left = left else { return nil }
		guard let right = right else { return left }
		guard let operation = operation else { return left }
		guard let closure = operations[operation] else { return left }
		guard right != 0 else {
			delegate?.divisionByZero()
			return nil
		}
		return closure(left, right)
	}
	
	var leftIsset: Bool {
		return left != nil
	}
	
	func set(with string: String) {
		switch left == nil {
		case true: left = Int(string)
		case false: right = Int(string)
		}
		
		guard right != nil else { return }
		guard let result = result else { return }
		delegate?.have(String(result))
		left = result
		right = nil
	}
	
	func reset() {
		left = nil
		right = nil
		operation = nil
	}
}
