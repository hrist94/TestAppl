//
//  MainScreenView.swift
//  TestApp
//
//  Created by Kirill Khristenko on 28.08.2022.
//

import UIKit
import SnapKit

class MainScreenView: UIView {
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isUserInteractionEnabled = true
        return scrollView
    }()
    
    private var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var locationPopUp: LocationPopUpView = {
        let view = LocationPopUpView()
        return view
    }()
    
    private var filterButton: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "Filter")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private var categoryCarousel: UIView = {
        let view = CategoryCarouselView()
        return view
    }()
    
    private var searchBar: SearchBar = {
        let view = SearchBar()
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var hotSalesCollectionView: HotSalesView = {
        let view = HotSalesView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addElements()
        addTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(locationPopUp)
        contentView.addSubview(filterButton)
        contentView.addSubview(categoryCarousel)
        contentView.addSubview(searchBar)
        contentView.addSubview(hotSalesCollectionView)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(1100)
        }
        
        locationPopUp.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.width.greaterThanOrEqualTo(120)
            make.height.equalTo(20)
        }
        
        filterButton.snp.makeConstraints { make in
            make.width.equalTo(11)
            make.height.equalTo(13)
            make.centerY.equalTo(locationPopUp.snp.centerY)
            make.right.equalToSuperview().offset(-35)
        }
        
        categoryCarousel.snp.makeConstraints { make in
            make.top.equalTo(locationPopUp.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(138)
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(categoryCarousel.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(34)
        }
        
        hotSalesCollectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom).offset(24)
            make.height.equalTo(220)
        }
        
    }
    
    private func addTargets() {
        
    }
}
