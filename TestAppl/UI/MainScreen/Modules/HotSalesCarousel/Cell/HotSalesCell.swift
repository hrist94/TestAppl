//
//  HotSalesCell.swift
//  Test
//
//  Created by Kirill Khristenko on 29.08.2022.
//

import UIKit
import SnapKit

class HotSalesCell: UICollectionViewCell {
    
    var buyButtonClicked: IntClosure?
    var isNew: Bool = false {
        didSet {
            if isNew {
                self.newBadgeBack.isHidden = false
            } else {
                self.newBadgeBack.isHidden = true
            }
        }
    }
    
    var viewModel: HotSalesCellViewModel! {
        didSet { setUpViewModel() }
    }
    
    private var backImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private var headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.layer.shadowRadius = 5
        label.layer.shadowOpacity = 1
        label.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        label.font = Fonts.markProBold(size: 25)
        return label
    }()
    
    private var discriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Fonts.markProRegular(size: 11)
        return label
    }()
    
    private var buyButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitle("Buy now!", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.cornerRadius = 11
        return button
    }()
    
    private var newBadgeBack: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9982030988, green: 0.432235539, blue: 0.3056198359, alpha: 1)
        view.layer.cornerRadius = 14
        return view
    }()
    
    private var newBadgeLabel: UILabel = {
        let label = UILabel()
        label.text = "New"
        label.font = Fonts.markProMedium(size: 10)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 15
        
        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        addSubview(backImage)
        newBadgeBack.addSubview(newBadgeLabel)
        backImage.addSubview(headerLabel)
        backImage.addSubview(discriptionLabel)
        backImage.addSubview(buyButton)
        backImage.addSubview(newBadgeBack)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        backImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        headerLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.top.equalToSuperview().offset(60)
            make.height.equalTo(30)
        }
        
        discriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(5)
            make.height.equalTo(15)
            make.left.equalToSuperview().offset(30)
        }
        
        buyButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.bottom.equalToSuperview().offset(-30)
            make.width.equalTo(98)
            make.height.equalTo(23)
        }
        
        newBadgeBack.snp.makeConstraints { make in
            make.height.width.equalTo(27)
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(30)
        }
        
        newBadgeLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(22)
            make.height.equalTo(12)
        }
    }
    
    private func setUpViewModel() {
        self.headerLabel.text = viewModel.headerLabel
        self.discriptionLabel.text = viewModel.discriptionLabel
        self.backImage.loadImage(from: viewModel.image)
        self.isNew = viewModel.isNew
    }
}
