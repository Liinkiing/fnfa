//
//  FilterButton.swift
//  fnfa
//
//  Created by Jbara Omar on 21/02/2018.
//  Copyright © 2018 JBARA Omar. All rights reserved.
//

import UIKit

class FilterButton: UIButton {
    
    @IBInspectable var filter: String?

    override func layoutSubviews() {
        if state == .normal {
            titleLabel?.font = UIFont.systemFont(ofSize: (titleLabel?.font.pointSize)!)
            style()
        } else if state == .selected {
            titleLabel?.font = UIFont.boldSystemFont(ofSize: (titleLabel?.font.pointSize)!)
            style()
        }
        super.layoutSubviews()
    }
    
    private func style() {
        if state == .normal {
            layer.borderWidth = 0
            layer.cornerRadius = 0
            layer.borderColor = nil
            layer.shadowRadius = 0
            layer.shadowColor = nil
            layer.shadowOpacity = 0
            layer.shadowOffset = CGSize(width: 0, height: 0)
        } else if state == .selected {
            layer.borderWidth = 2
            layer.cornerRadius = 10
            layer.borderColor = #colorLiteral(red: 0, green: 0.8916617036, blue: 0.5365658998, alpha: 1)
            layer.shadowRadius = 6
            layer.shadowColor = #colorLiteral(red: 0, green: 0.8916617036, blue: 0.5365658998, alpha: 1)
            layer.shadowOpacity = 0.6
            layer.shadowOffset = CGSize(width: 0, height: 0)
        }
        
    }

}
