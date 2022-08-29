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
    
    lazy var hotSalesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let sidesOffset: CGFloat = 10
        
        let width: CGFloat = UIScreen.main.bounds.width - 20
        layout.itemSize = CGSize(width: width, height: 180)
        layout.sectionInset = UIEdgeInsets(top: 5, left: sidesOffset, bottom: 5, right: sidesOffset)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .infinite, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.register(HotSalesCell.self)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.clipsToBounds = false
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = true
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        addSubview(headelLabel)
        addSubview(seeMoreButton)
        addSubview(hotSalesCollectionView)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        headelLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(17)
            make.width.equalTo(111)
            make.height.equalTo(32)
        }
        
        seeMoreButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-33)
            make.centerY.equalTo(headelLabel.snp.centerY)
            make.width.equalTo(75)
            make.height.equalTo(19)
        }
        
        hotSalesCollectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(182)
            make.top.equalTo(headelLabel.snp.bottom).offset(8)
        }
    }
}

extension HotSalesView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offers.count
    }
}
