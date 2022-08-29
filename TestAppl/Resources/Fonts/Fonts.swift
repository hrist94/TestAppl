//
//  Fonts.swift
//  Test
//
//  Created by Kirill Khristenko on 29.08.2022.
//

import Foundation
import UIKit

enum Fonts {
    
    static func markProBold(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Mark Pro Bold", size: size) else { return UIFont.systemFont(ofSize: size) }
        return font
    }
    
    static func markProMedium(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "MarkPro-Medium", size: size) else { return UIFont.systemFont(ofSize: size) }
        return font
    }
    
    static func markProRegular(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "MarkPro-Regular", size: size) else { return UIFont.systemFont(ofSize: size) }
        return font
    }
}
