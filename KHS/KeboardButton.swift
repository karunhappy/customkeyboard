//
//  KeboardButton.swift
//  CustomKeybaord
//
//  Created by Karun Aggarwal on 03/10/19.
//  Copyright © 2019 Karun. All rights reserved.
//

import UIKit

@IBDesignable
class KeyboardButton: UIButton {
    
    var defaultBackgroundColor: UIColor = .white
    var highlightBackgroundColor: UIColor = .lightGray
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = isHighlighted ? highlightBackgroundColor : defaultBackgroundColor
    }
    
    func commonInit() {
        layer.cornerRadius = 5.0
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 0.0
        layer.shadowOpacity = 0.35
        setTitleColor(.gray, for: .normal)
        setTitleColor(.black, for: .highlighted)
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.5
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    }
}
