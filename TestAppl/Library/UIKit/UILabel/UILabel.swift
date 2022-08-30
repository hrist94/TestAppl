//
//  UILabel.swift
//  TestAppl
//
//  Created by Kirill Khristenko on 30.08.2022.
//

import UIKit

extension UILabel {
    
    func setStrikethroughText() {
        let text = self.text ?? ""
        let range = NSRange(location: 0, length: text.count)
        let mutableString = NSMutableAttributedString(attributedString: attributedText ?? NSAttributedString())
        mutableString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: range)
        self.attributedText = mutableString
    }
}

