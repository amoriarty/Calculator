//
//  MainController.swift
//  Calculator
//
//  Created by Alexandre LEGENT on 23/10/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import UIKit

class MainController: UIViewController {
	let calculator = CalculatorController()
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
	let resultLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "0"
		label.textAlignment = .right
		label.textColor = .white
		label.font = .systemFont(ofSize: 42)
		return label
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(calculator.view)
		view.addSubview(resultLabel)
		
		setupLayouts()
	}
	
	private func setupLayouts() {
		_ = calculator.view.fill(.horizontaly, view)
		_ = calculator.view.constraint(.bottom, to: view)
		_ = calculator.view.constraint(.height, to: view, multiplier: 0.75)
		
		_ = resultLabel.fill(.horizontaly, view, constant: 10)
		_ = resultLabel.constraint(.bottom, to: calculator.view, .top, constant: 10)
	}
}

