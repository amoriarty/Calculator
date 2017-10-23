//
//  CalculatorController.swift
//  Calculator
//
//  Created by Alexandre LEGENT on 23/10/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import UIKit

class CalculatorController: UIViewController {
	
	let stack: UIStackView = {
		let colors: [ UIColor ] = [ .brown, .purple, .green, .yellow, .orange ]
		var index = 0
		let stack = UIStackView()
		
		stack.axis = .vertical
		stack.distribution = .fillEqually
		stack.translatesAutoresizingMaskIntoConstraints = false
		
		for row in 0...3 {
			let subStack = UIStackView()
			
			subStack.axis = .horizontal
			subStack.distribution = .fillEqually
			subStack.translatesAutoresizingMaskIntoConstraints = false
			
			for column in 0...3 {
				let view = UIView()
				view.backgroundColor = colors[ index % 5 ]
				view.translatesAutoresizingMaskIntoConstraints = false
				subStack.addArrangedSubview(view)
				index += 1
			}
			
			stack.addArrangedSubview(subStack)
		}
		return stack
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .white
		
		view.addSubview(stack)
		_ = stack.fill(view)
    }
}
