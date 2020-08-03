//
//  Utils.swift
//  VideoRecorderApp
//
//  Created by Enst_MB1 on 02/08/20.
//  Copyright © 2020 Enst_MB1. All rights reserved.
//

import UIKit


extension UIButton {
    
    func makeRoundCornerButton() {
        layer.cornerRadius = frame.height * 0.5
        layer.masksToBounds = true
        layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.1725490196, blue: 0.1411764706, alpha: 1)
        layer.borderWidth = 2
    }

    func makeRoundCornerButtonWithoutBorder() {
        layer.cornerRadius = frame.height * 0.5
        layer.masksToBounds = true
    }
}

extension UITextField {
    
    func makeRoundCornerTextfield() {
        layer.cornerRadius = 7
        layer.masksToBounds = true
        layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        layer.borderWidth = 1
    }
}

extension UIImageView {
    
    func makeRoundCornerImageView() {
        layer.cornerRadius = 5
        layer.masksToBounds = true
    }
}
