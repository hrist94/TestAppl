//
//  LocationPopUpView.swift
//  Test
//
//  Created by Kirill Khristenko on 29.08.2022.
//

import UIKit
import SnapKit

class LocationPopUpView: UIView {
    
    var stackViewClicked: VoidClosure?
    
    private var locationImage: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "Local")
        view.tintColor = #colorLiteral(red: 0.9982030988, green: 0.432235539, blue: 0.3056198359, alpha: 1)
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private var label: UILabel = {
        let label = UILabel()
        label.text = "Zihuatanejo, Gro"
        label.font = Fonts.markProMedium(size: 15)
        label.textColor = .black
        return label
    }()
    
    private var popUpArrow: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "PopUp")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 15
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        addSubview(locationImage)
        addSubview(label)
        addSubview(popUpArrow)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        label.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.greaterThanOrEqualTo(120)
            make.center.equalToSuperview()
        }
        
        locationImage.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.width.equalTo(12)
            make.centerY.equalTo(label.snp.centerY)
            make.right.equalTo(label.snp.left).offset(-11)
        }

        popUpArrow.snp.makeConstraints { make in
            make.height.equalTo(5)
            make.width.equalTo(10)
            make.centerY.equalTo(label.snp.centerY)
            make.left.equalTo(label.snp.right).offset(5)
        }
        
        
    }
    
}
