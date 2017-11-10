//
//  MainController.swift
//  Calculator
//
//  Created by Alexandre LEGENT on 23/10/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import UIKit

class MainController: UIViewController {
	let inputController = InputController()
	
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
		view.addSubview(inputController.view)
		view.addSubview(resultLabel)
		
		setupLayouts()
	}
	
	private func setupLayouts() {
		inputController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
		inputController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
		inputController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
		inputController.view.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.75).isActive = true
		
		_ = resultLabel.constraint(.leading, to: inputController.view)
		_ = resultLabel.constraint(.trailing, to: inputController.view)
		_ = resultLabel.constraint(.bottom, to: inputController.view, .top, constant: 10)
	}
}

