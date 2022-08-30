//
//  BestSalesViewModel.swift
//  TestAppl
//
//  Created by Kirill Khristenko on 30.08.2022.
//

import UIKit
import Combine

class BestSellersCellViewModel {
    @Published var nameProduct: String = ""
    @Published var oldPrice: Int = 0
    @Published var discountPrice: Int = 0
    @Published var image: String = ""
    @Published var isFav: Bool = false
        
    private let offer: BestSeller
    
    init(offer: BestSeller) {
        self.offer = offer
        
        setUpBindings()
    }
    
    private func setUpBindings() {
        nameProduct = offer.title ?? ""
        oldPrice = offer.priceWithoutDiscount ?? 0
        discountPrice = offer.discountPrice ?? 0
        image = offer.picture ?? ""
        isFav = offer.isFavorites ?? false
    }
}

