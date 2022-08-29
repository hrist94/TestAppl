//
//  CategoryCarousel.swift
//  Test
//
//  Created by Kirill Khristenko on 29.08.2022.
//

import UIKit
import SnapKit

class CategoryCarousel: UIView {
    
    private let categories: [CategoryModel] = [CategoryModel(icon: #imageLiteral(resourceName: "Phone"), name: "Phones"), CategoryModel(icon: #imageLiteral(resourceName: "PC"), name: "Computer"), CategoryModel(icon: #imageLiteral(resourceName: "Health"), name: "Health"), CategoryModel(icon: #imageLiteral(resourceName: "Book"), name: "Books"), CategoryModel(icon: #imageLiteral(resourceName: "Phone"), name: "Phones"), CategoryModel(icon: #imageLiteral(resourceName: "PC"), name: "Computer"), CategoryModel(icon: #imageLiteral(resourceName: "Health"), name: "Health"), CategoryModel(icon: #imageLiteral(resourceName: "Book"), name: "Books")]
    
    private var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Select Category"
        label.textColor = .black
        label.font = Fonts.markProBold(size: 25)
        label.textAlignment = .center
        return label
    }()
    
    private var allButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(red: 0.9982030988, green: 0.432235539, blue: 0.3056198359, alpha: 1), for: .normal)
        button.setTitle("view all", for: .normal)
        return button
    }()
    
    private lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let sidesOffset: CGFloat = 10
        
        let side: CGFloat = 70
        layout.itemSize = CGSize(width: side, height: side)
        layout.sectionInset = UIEdgeInsets(top: 0, left: sidesOffset, bottom: 0, right: sidesOffset)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .infinite, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryCell.self)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.clipsToBounds = false
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
        addSubview(headerLabel)
        addSubview(allButton)
        addSubview(categoryCollectionView)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        headerLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(17)
            make.top.equalToSuperview()
            make.width.equalTo(193)
            make.height.equalTo(32)
        }
        
        allButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-33)
            make.centerY.equalTo(headerLabel.snp.centerY)
            make.height.equalTo(19)
            make.width.equalTo(60)
        }
        
        categoryCollectionView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(headerLabel.snp.bottom).offset(20)
            make.height.equalTo(92)
        }
    }
    
}

extension CategoryCarousel: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCollectionReusableCell(withType: CategoryCell.self, for: indexPath)
        cell.configure(category: self.categories[indexPath.row])
        
        return cell
    }
}
