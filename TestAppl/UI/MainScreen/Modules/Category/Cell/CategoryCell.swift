//
//  CategoryCell.swift
//  Test
//
//  Created by Kirill Khristenko on 29.08.2022.
//

import UIKit
import SnapKit

class CategoryCell: UICollectionViewCell {
    
    var cellClicked: VoidClosure?
    let icons = [#imageLiteral(resourceName: "Phone"), #imageLiteral(resourceName: "PC"), #imageLiteral(resourceName: "Health"), #imageLiteral(resourceName: "Book")]
    
    override var isSelected: Bool {
        didSet {
            self.backView.backgroundColor = isSelected ? #colorLiteral(red: 0.9982030988, green: 0.432235539, blue: 0.3056198359, alpha: 1) : UIColor.white
            self.iconView.tintColor = isSelected ? UIColor.white : UIColor.gray
            self.label.textColor = isSelected ? #colorLiteral(red: 0.9982030988, green: 0.432235539, blue: 0.3056198359, alpha: 1) : UIColor.black
        }
    }
    
    private var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 35
        view.addShadow()
        return view
    }()
    
    private var iconView: UIImageView = {
        let view = UIImageView()
        view.tintColor = .gray
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = Fonts.markProMedium(size: 12)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(category: CategoryModel) {
        self.label.text = category.name
        self.iconView.image = category.icon
    }
    
    private func addElements() {
        addSubview(backView)
        addSubview(label)
        backView.addSubview(iconView)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        backView.snp.makeConstraints { make in
            make.width.equalTo(70)
            make.height.equalTo(70)
            make.center.equalToSuperview()
        }
        
        iconView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(30)
            make.width.greaterThanOrEqualTo(18)
        }
        
        label.snp.makeConstraints { make in
            make.centerX.equalTo(iconView.snp.centerX)
            make.top.equalTo(backView.snp.bottom).offset(7)
            make.height.equalTo(15)
        }
    }
}
