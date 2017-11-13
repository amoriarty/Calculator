//
//  ButtonsView.swift
//  Calculator
//
//  Created by Alexandre LEGENT on 23/10/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import UIKit

class ButtonsView: UIView {
	private let texts = ["C", "+/-", "", "/", "7", "8", "9", "x", "4", "5", "6", "-", "1", "2", "3", "+", "", "0", "", "="]
//	private var buttons = [ ButtonView ]()
	weak var delegate: ButtonDelegate? {
		didSet {
			mainStack.arrangedSubviews.forEach { stack in
				guard let stack = stack as? UIStackView else { return }
				stack.arrangedSubviews.forEach({ button in
					guard let button = button as? ButtonView else { return }
					button.delegate = delegate
				})
			}
		}
	}
	
	let mainStack: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		
		stack.axis = .vertical
		stack.distribution = .fillEqually
		return stack
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		translatesAutoresizingMaskIntoConstraints = false
		backgroundColor = .white
		
		addSubview(mainStack)
		_ = mainStack.fill(self)
		
		setupStacks()
	}
	
	private func setupStacks() {
		for x in 0..<5 {
			let stack = horizontalView()
			
			for y in 0..<4 {
				let button = buttonView(index: 4 * x + y)
				stack.addArrangedSubview(button)
			}
			mainStack.addArrangedSubview(stack)
		}
	}
	
	private func horizontalView() -> UIStackView {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .horizontal
		stack.distribution = .fillEqually
		return stack
	}
	
	private func buttonView(index: Int) -> ButtonView {
		let button = ButtonView()
		button.title = texts[index]
		button.index = index
		return button
	}
	
	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
