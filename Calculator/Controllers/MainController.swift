//
//  MainController.swift
//  Calculator
//
//  Created by Alexandre LEGENT on 23/10/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import UIKit

final class MainController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CalculatorDelegate {
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    private let calculator = CalculatorController()
    private let reuseid = "ButtonCell"
    private let buttons = ["C", "+/-", "", "/", "7", "8", "9", "x", "4", "5", "6", "-", "1", "2", "3", "+", "", "0", "", "="]
    var printed: String? {
        didSet { printedLabel.text = printed }
    }
	
    // MARK:- Views
	private let printedLabel: UILabel = {
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
        setupViews()
		setupLayouts()
        calculator.delegate = self
        collectionView.register(ButtonCell.self, forCellWithReuseIdentifier: reuseid)
	}
    
    /* This function, call when device rotate, will force collection view to resize every cell */
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { [unowned self] _ in
            self.collectionView.collectionViewLayout.invalidateLayout()
        }, completion: nil)
    }
	
    // MARK:- Setups
    private func setupViews() {
        view.addSubview(collectionView)
        view.addSubview(printedLabel)
    }
    
	private func setupLayouts() {
        _ = collectionView.fill(.horizontaly, view.safeAreaLayoutGuide)
        _ = collectionView.constraint(.bottom, to: view.safeAreaLayoutGuide)
        _ = collectionView.constraint(.height, to: view.safeAreaLayoutGuide, multiplier: 0.75)
        _ = printedLabel.fill(.horizontaly, collectionView)
		_ = printedLabel.constraint(.bottom, to: collectionView, .top, constant: 10)
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
        
        if button != "" {
            calculator.press(button)
        }
    }
    
    // MARK:- Calculator Delegate
    func set(text: String) {
        printedLabel.text = text
    }
}

