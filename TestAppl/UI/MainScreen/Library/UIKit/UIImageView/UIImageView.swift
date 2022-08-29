//
//  UIImageView.swift
//  Test
//
//  Created by Kirill Khristenko on 29.08.2022.
//

import UIKit
import Kingfisher

extension UIImageView {
    func loadImage(from imageURL: String, completionHandler: VoidClosure? = nil) {
        guard !imageURL.isEmpty else {
            self.image = #imageLiteral(resourceName: "Book")
            return
        }
        
        guard let url = URL(string: imageURL) else {
            self.image = #imageLiteral(resourceName: "Book")
            return
        }
        self.kf.setImage(with: url) { (result) in
            switch result {
            case .success(_):
                self.backgroundColor = .clear
            case .failure(let error):
                print(error)
                self.image = #imageLiteral(resourceName: "Book")
            }
            completionHandler?()
        }
    }
}
