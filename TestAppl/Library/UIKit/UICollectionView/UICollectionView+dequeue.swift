//
//  UICollectionView+dequeue.swift
//  TestApp
//
//  Created by Kirill Khristenko on 28.08.2022.
//

import UIKit

extension UICollectionView {
    
    func dequeueCollectionReusableCell<View: UICollectionViewCell>(withType type: View.Type, for indexPath: IndexPath) -> View {
        let indetifier = String(describing: type)
        let cell = self.dequeueReusableCell(withReuseIdentifier: indetifier, for: indexPath) as! View
        return cell
    }
    
    func register<View: UICollectionViewCell>(_ cellClass: View.Type) {
        self.register(cellClass, forCellWithReuseIdentifier: "\(cellClass)")
    }
}
