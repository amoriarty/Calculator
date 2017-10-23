//
//  ButtonView.swift
//  Calculator
//
//  Created by Alexandre LEGENT on 23/10/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import UIKit

class ButtonView: UIButton {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		translatesAutoresizingMaskIntoConstraints = false

		titleLabel?.textAlignment = .center
		setTitleColor(.black, for: .normal)
		
		layer.borderColor = UIColor.black.cgColor
		layer.borderWidth = 0.5
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
