//
//  ButtonCell.swift
//  Calculator
//
//  Created by Émilie Legent on 20/03/2018.
//  Copyright © 2018 Alexandre Legent. All rights reserved.
//

import UIKit

final class ButtonCell: UICollectionViewCell {
    var button: String? {
        didSet { label.text = button }
    }
    
    var textColor: UIColor? {
        didSet { label.textColor = textColor }
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30)
        return label
    }()
    
    // MARK:- Inits
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        addSubview(label)
        _ = label.center(self)
    }
}
