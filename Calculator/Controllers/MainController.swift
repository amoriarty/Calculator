//
//  MainController.swift
//  Calculator
//
//  Created by Alexandre LEGENT on 23/10/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import UIKit

class MainController: UIViewController, ButtonDelegate, CalculatorDelegate {
	let buttonsView = ButtonsView()
	let calculator = CalculatorController()
	var shouldClear = false
	
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
		view.addSubview(buttonsView)
		view.addSubview(resultLabel)
		buttonsView.delegate = self
		calculator.delegate = self
		setupLayouts()
	}
	
	private func setupLayouts() {
		buttonsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
		buttonsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
		buttonsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
		buttonsView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.75).isActive = true
		_ = resultLabel.constraint(.leading, to: buttonsView)
		_ = resultLabel.constraint(.trailing, to: buttonsView)
		_ = resultLabel.constraint(.bottom, to: buttonsView, .top, constant: 10)
	}
	
	func didTap(_ sender: ButtonView) {
		guard let title = sender.title, title != "" else { return }
		guard let char = title.first else { return }

		switch title {
		case "+/-":
			print("TOGGLE +/-")
		case "C":
			resultLabel.text = "0"
			calculator.reset()
		case "=":
			calculator.set(with: resultLabel.text!)
		case "+", "/", "x", "-":
			calculator.operation = title
			shouldClear = true
			guard resultLabel.text! != "0" else { return }
			calculator.set(with: resultLabel.text!)
		case "0":
			if resultLabel.text! == "0" { return }
			else { resultLabel.text?.append(char) }
		default:
			if shouldClear {
				resultLabel.text = "0"
				shouldClear = false
			}
			if resultLabel.text! == "0" { resultLabel.text? = title }
			else { resultLabel.text?.append(char) }
		}
	}
	
	func have(_ result: String) {
		resultLabel.text = result
		shouldClear = true
	}
	
	func divisionByZero() {
		resultLabel.text = "Error"
		shouldClear = true
		calculator.reset()
	}
}

