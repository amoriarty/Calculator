//
//  MainController.swift
//  Calculator
//
//  Created by Alexandre LEGENT on 23/10/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import UIKit

class MainController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CalculatorDelegate {
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    private let buttons = ["C", "+/-", "", "/", "7", "8", "9", "x", "4", "5", "6", "-", "1", "2", "3", "+", "", "0", "", "="]
    private let reuseid = "ButtonCell"
	private let calculator = CalculatorController()
	private var shouldClear = false
	
    // MARK:- Views
	private let resultLabel: UILabel = {
		let label = UILabel()
		label.text = "0"
		label.textAlignment = .right
		label.textColor = .white
		label.font = .systemFont(ofSize: 70)
		return label
	}()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.delegate = self
        view.dataSource = self
        return view
    }()
	
    // MARK:- View lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
        view.addSubview(collectionView)
		view.addSubview(resultLabel)
        collectionView.register(ButtonCell.self, forCellWithReuseIdentifier: reuseid)
		calculator.delegate = self
		setupLayouts()
	}
	
    // MARK:- Setups
	private func setupLayouts() {
        _ = collectionView.fill(.horizontaly, view.safeAreaLayoutGuide)
        _ = collectionView.constraint(.bottom, to: view.safeAreaLayoutGuide)
        _ = collectionView.constraint(.height, to: view.safeAreaLayoutGuide, multiplier: 0.75)
        _ = resultLabel.fill(.horizontaly, collectionView)
		_ = resultLabel.constraint(.bottom, to: collectionView, .top, constant: 10)
	}
    
    // MARK:- Collection View Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseid, for: indexPath) as! ButtonCell
        cell.button = buttons[indexPath.item]
        
        /* Setting up background color for some cells.
         * Default cell background color is defined in it's own init() */
        if indexPath.item / 4 < 1 {
            cell.backgroundColor = .gray
        }
        
        if indexPath.item % 4 == 3 {
            cell.backgroundColor = .orange
            cell.textColor = .white
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 4, height: collectionView.frame.height / 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let button = buttons[indexPath.item]
        
        switch button {
        case "+/-": break // TODO: Implement +/-
        case "=": calculator.set(with: resultLabel.text!)
        case "C":
            resultLabel.text = "0"
            calculator.reset()
        case "+", "/", "x", "-":
            calculator.operation = title
            shouldClear = true
            guard resultLabel.text! != "0" else { return }
            calculator.set(with: resultLabel.text!)
        case "0":
            if resultLabel.text! == "0" { return }
            else { resultLabel.text?.append(button) }
        default:
            if shouldClear {
                resultLabel.text = "0"
                shouldClear = false
            }
            if resultLabel.text! == "0" { resultLabel.text? = button }
            else { resultLabel.text?.append(button) }
        }

    }
    
    // MARK:- Calculator Delegate
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

