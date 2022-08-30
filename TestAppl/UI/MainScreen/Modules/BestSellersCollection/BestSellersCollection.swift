//
//  BestSalesCollection.swift
//  TestAppl
//
//  Created by Kirill Khristenko on 30.08.2022.
//

import UIKit
import SnapKit
import Combine

class BestSellerView: UIView {
    
    var idCellClicled: IntClosure?
    
    var offers: [BestSeller] = []
    
//    private var backView: UIView = {
//        let view = UIView()
//        return view
//    }()
    
    private var headelLabel: UILabel = {
        let label = UILabel()
        label.text = "Best Seller"
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
    
    lazy var bestSellerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let numberOfItemsInRow: CGFloat = 2
        
        let sidesOffset: CGFloat = 15
        let minimumInteritemSpacing: CGFloat = 0
        
        let cellWidth: CGFloat = ((UIScreen.main.bounds.width - sidesOffset - minimumInteritemSpacing * (numberOfItemsInRow - 1)) - sidesOffset*2 - minimumInteritemSpacing*(numberOfItemsInRow-1)) / numberOfItemsInRow
        
        layout.sectionInset = UIEdgeInsets(top: 10, left: sidesOffset, bottom: 10, right: sidesOffset)
        layout.itemSize = CGSize(width: cellWidth, height: 230)
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        layout.minimumLineSpacing = 15
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .infinite, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.register(BestSellerCell.self)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.clipsToBounds = true
        collectionView.isPagingEnabled = false
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
//        addSubview(backView)
        addSubview(bestSellerCollectionView)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        headelLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(17)
            make.width.equalTo(150)
            make.height.equalTo(32)
        }
        
        seeMoreButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-33)
            make.centerY.equalTo(headelLabel.snp.centerY)
            make.width.equalTo(75)
            make.height.equalTo(19)
        }
        
//        backView.snp.makeConstraints { make in
//            make.top.equalTo(headelLabel.snp.bottom).offset(15)
//
//        }
        
        bestSellerCollectionView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(40)
        }
    }
}

extension BestSellerView: UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
}
