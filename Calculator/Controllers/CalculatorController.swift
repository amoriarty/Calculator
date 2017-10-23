//
//  CalculatorController.swift
//  Calculator
//
//  Created by Alexandre LEGENT on 23/10/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import UIKit

class CalculatorController: UIViewController {
	let calculatorView = CalculatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .white
		
		view.addSubview(calculatorView)
		_ = calculatorView.fill(view)
    }
}
