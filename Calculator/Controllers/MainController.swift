//
//  MainController.swift
//  Calculator
//
//  Created by Alexandre LEGENT on 23/10/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import UIKit

class MainController: UIViewController, ButtonDelegate {
	let buttonsView = ButtonsView()
	
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
		print("\(title)")
	}
}

