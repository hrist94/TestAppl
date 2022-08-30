//
//  BestSalesCell.swift
//  TestAppl
//
//  Created by Kirill Khristenko on 30.08.2022.
//

import UIKit
import SnapKit

class BestSellerCell: UICollectionViewCell {
    
    var isFav: Bool = false {
        didSet {
            if isFav {
                self.favIcon.image = #imageLiteral(resourceName: "FavFill")
            } else {
                self.favIcon.image = #imageLiteral(resourceName: "FavEmpty")
            }
        }
    }
    var viewModel: BestSellersCellViewModel! {
        didSet { setUpViewModel() }
    }
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let image: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private var nameProduct: UILabel = {
        let label = UILabel()
        label.font = Fonts.markProMedium(size: 10)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private var oldPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = #colorLiteral(red: 0.8374214172, green: 0.8374213576, blue: 0.8374213576, alpha: 1)
        label.textAlignment = .center
        label.setStrikethroughText()
        return label
    }()
    
    private var discountPrice: UILabel = {
        let label = UILabel()
        label.font = Fonts.markProBold(size: 16)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private var favBackView: UIView = {
        let view = UIView()
        view.addShadow()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()
    
    private var favIcon: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "FavEmpty")
        view.tintColor = #colorLiteral(red: 0.9982030988, green: 0.432235539, blue: 0.3056198359, alpha: 1)
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        layer.cornerRadius = 10
        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        addSubview(backView)
        backView.addSubview(image)
        backView.addSubview(nameProduct)
        backView.addSubview(discountPrice)
        backView.addSubview(oldPrice)
        backView.addSubview(favBackView)
        favBackView.addSubview(favIcon)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        image.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(168)
        }
        
        discountPrice.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(21)
            make.top.equalTo(image.snp.bottom).offset(7)
            make.width.greaterThanOrEqualTo(50)
        }
        
        oldPrice.snp.makeConstraints { make in
            make.left.equalTo(discountPrice.snp.right).offset(7)
            make.centerY.equalTo(discountPrice.snp.centerY)
        }
        
        nameProduct.snp.makeConstraints { make in
            make.top.equalTo(discountPrice.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(21)
        }
        
        favBackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(11)
            make.right.equalToSuperview().offset(-15)
            make.width.height.equalTo(25)
        }
        
        favIcon.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(10)
        }
    }
    
    private func setUpViewModel() {
        self.nameProduct.text = viewModel.nameProduct
        self.discountPrice.text = "$\(viewModel.discountPrice)"
        self.oldPrice.text = "$\(viewModel.oldPrice)"
        self.image.loadImage(from: viewModel.image)
        self.isFav = viewModel.isFav
    }
}
