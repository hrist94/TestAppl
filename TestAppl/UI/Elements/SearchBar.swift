//
//  SearchBar.swift
//  Test
//
//  Created by Kirill Khristenko on 29.08.2022.
//

import UIKit
import SnapKit

class SearchBar: UIView {
    
    var barcodeScannerClicked: VoidClosure?
    
    var shouldSaveValueEachChanging: Bool = false
    
    var placeHolder: String = "" {
        didSet {
            textField.attributedPlaceholder = NSAttributedString(string: "search")
        }
    }
    
    private var previousValue = ""
    
    private var searchBarStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()
    
    private var searchBackView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 17
        view.backgroundColor = .white
        view.addShadow()
        return view
    }()
    
    private var searchIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "Search")
        imageView.tintColor = #colorLiteral(red: 0.9982030988, green: 0.432235539, blue: 0.3056198359, alpha: 1)
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private var clearIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "clear.fill")
        imageView.tintColor = #colorLiteral(red: 0.9982030988, green: 0.432235539, blue: 0.3056198359, alpha: 1)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private var barcodeScannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "QRcode")
        imageView.tintColor = .white
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private var barcodeScannerBackView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9982030988, green: 0.432235539, blue: 0.3056198359, alpha: 1)
        view.layer.cornerRadius = 17
        return view
    }()
    
    private var searchIconsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 11
        return stackView
    }()
    
    private var textField: UITextField = {
        let textField = UITextField()
        textField.setContentHuggingPriority(UILayoutPriority(rawValue: 300), for: .horizontal)
        textField.tintColor = .white
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 14)
        textField.placeholder = "Search"
        textField.returnKeyType = .search
        textField.enablesReturnKeyAutomatically = true
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addElements()
        addTargets()
        
        clearIconImageView.isHidden = true
        
        textField.delegate = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func becomeResponder() {
        textField.becomeFirstResponder()
    }
    
    func resignResponder() {
        textField.resignFirstResponder()
    }
    
    private func addTargets() {
        clearIconImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clearButtonClicked)))
        barcodeScannerImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(scannerButtonClicked)))
    }
    
    @objc func clearButtonClicked() {
        textField.text = ""
    }
    
    @objc func scannerButtonClicked() {
        barcodeScannerClicked?()
    }
    
    func addElements() {
        addSubview(searchIconImageView)
        
        addSubview(searchBackView)
        searchIconsStackView.addArrangedSubview(searchIconImageView)
        searchIconsStackView.addArrangedSubview(textField)
        searchIconsStackView.addArrangedSubview(clearIconImageView)
        
        searchBackView.addSubview(searchIconsStackView)
        
        searchBarStackView.addArrangedSubview(searchBackView)
        searchBarStackView.addArrangedSubview(barcodeScannerBackView)
        barcodeScannerBackView.addSubview(barcodeScannerImageView)
        
        addSubview(searchBarStackView)
        
        makeConstraints()
    }
    
    func makeConstraints() {
        searchIconImageView.snp.makeConstraints { make in
            make.height.width.equalTo(16)
        }
        
        clearIconImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(16)
        }
       
        barcodeScannerImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(15)
            make.center.equalToSuperview()
        }
        
        barcodeScannerBackView.snp.makeConstraints { make in
            make.width.height.equalTo(34)
        }
        
        searchBackView.snp.makeConstraints { (make) in
            make.height.equalTo(34)
        }
        
        searchIconsStackView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-8)
            make.left.equalToSuperview().offset(24)
        }
        
        searchBarStackView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
        }
    }
}

extension SearchBar: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        clearIconImageView.isHidden = text.isEmpty
        previousValue = text
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        clearIconImageView.isHidden = true
        previousValue = text
        
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        clearIconImageView.isHidden = text.isEmpty
        if shouldSaveValueEachChanging {
            previousValue = text
        }
    }
}
