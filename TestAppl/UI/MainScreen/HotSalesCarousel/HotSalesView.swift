//
//  HotSalesView.swift
//  Test
//
//  Created by Kirill Khristenko on 29.08.2022.
//

import UIKit
import SnapKit
import Combine

class HotSalesView: UIView {
    
    var idCellClicled: IntClosure?
    
    var offers: [HomeStore] = []
    
    private var headelLabel: UILabel = {
        let label = UILabel()
        label.text = "Hot sales"
        label.font = Fonts.markProBold(size: 25)
        label.textColor = .black
        return label
    }()
    
    private var seeMoreButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(red: 0.9982030988, green: 0.432235539, blue: 0.3056198359, alpha: 1), for: .normal)
        button.setTitle("see more", for: .normal)
        return button
    }()
    
    private lazy var hotSalesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let sidesOffset: CGFloat = 10
        
        let width: CGFloat = UIScreen.main.bounds.width - 30
        layout.itemSize = CGSize(width: width, height: 180)
        layout.sectionInset = UIEdgeInsets(top: 0, left: sidesOffset, bottom: 0, right: sidesOffset)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .infinite, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HotSalesCell.self)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.clipsToBounds = false
        collectionView.isPagingEnabled = false
        collectionView.isScrollEnabled = true
        
        return collectionView
    }()
}

extension HotSalesView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCollectionReusableCell(withType: HotSalesCell.self, for: indexPath)
//        cell.setup
        
        return cell
    }
}
