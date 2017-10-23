//
//  ButtonView.swift
//  Calculator
//
//  Created by Alexandre LEGENT on 23/10/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import UIKit

protocol ButtonDelegate: class {
	func didTap(_ sender: ButtonView)
}

class ButtonView: UIButton {
	weak var delegate: ButtonDelegate?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		translatesAutoresizingMaskIntoConstraints = false

		titleLabel?.textAlignment = .center
		setTitleColor(.black, for: .normal)
	
		layer.borderColor = UIColor.black.cgColor
		layer.borderWidth = 0.5
		
		addTarget(self, action: #selector(didTap), for: .touchUpInside)
	}
	
	@objc func didTap() {
		delegate?.didTap(self)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
