//
//  InputController.swift
//  Calculator
//
//  Created by Alexandre LEGENT on 23/10/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import UIKit

class InputController: UIViewController, ButtonDelegate {
	let inputView = InputView()

    override func viewDidLoad() {
        super.viewDidLoad()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .white
		
		inputView.delegate = self
		
		view.addSubview(inputView)
		_ = inputView.fill(view)
    }
	
	func didTap(_ sender: ButtonView) {
		print("EVERYBODY DO THE DROP")
	}
}
