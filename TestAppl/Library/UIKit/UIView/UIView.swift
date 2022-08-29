//
//  UIView.swift
//  Test
//
//  Created by Kirill Khristenko on 29.08.2022.
//

import UIKit

extension UIView {
    
    func addShadow() {
        self.layer.shadowRadius = 10
        self.layer.shadowColor = #colorLiteral(red: 0.6549019608, green: 0.6705882353, blue: 0.7882352941, alpha: 1)
        self.layer.shadowOpacity = 0.2
    }
}
