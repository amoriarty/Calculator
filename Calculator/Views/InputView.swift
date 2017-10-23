//
//  InputView.swift
//  Calculator
//
//  Created by Alexandre LEGENT on 23/10/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import UIKit

class InputView: UIStackView {
	private let texts = ["C", "+/-", "%", "/", "7", "8", "9", "x", "4", "5", "6", "-", "1", "2", "3", "+", "0", "", "", "="]
	private var buttons = [ ButtonView ]()
	weak var delegate: ButtonDelegate? {
		didSet { buttons.forEach { (button) in button.delegate = delegate } }
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		translatesAutoresizingMaskIntoConstraints = false
		
		axis = .vertical
		distribution = .fillEqually
		setupViews()
	}
	
	private func setupViews() {
		var index = 0
		
		for _ in 0...4 {
			let stack = UIStackView()
			
			stack.axis = .horizontal
			stack.distribution = .fillEqually
			stack.translatesAutoresizingMaskIntoConstraints = false
			for _ in 0...3 {
				let button = setupButton(index)
				stack.addArrangedSubview(button)
				index += 1
			}
			addArrangedSubview(stack)
		}
	}
	
	private func setupButton(_ index: Int) -> ButtonView {
		let button = ButtonView()
		
		button.setTitle(texts[index], for: .normal)
		if index / 4 < 1 {
			button.backgroundColor = .gray
		}
		if index % 4 == 3 {
			button.backgroundColor = .orange
			button.setTitleColor(.white, for: .normal)
		}
		buttons.append(button)
		return button
	}
	
	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
