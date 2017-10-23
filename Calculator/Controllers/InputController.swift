//
//  InputController.swift
//  Calculator
//
//  Created by Alexandre LEGENT on 23/10/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import UIKit

class InputController: UIViewController, ButtonDelegate {
	let input = InputView()

    override func viewDidLoad() {
        super.viewDidLoad()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .white
		
		input.delegate = self
		
		view.addSubview(input)
		_ = input.fill(view)
    }
	
	func didTap(_ sender: ButtonView) {
		print("EVERYBODY DO THE DROP")
	}
}
