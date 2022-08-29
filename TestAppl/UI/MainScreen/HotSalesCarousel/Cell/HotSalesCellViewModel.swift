//
//  HotSalesCellViewModel.swift
//  Test
//
//  Created by Kirill Khristenko on 29.08.2022.
//

import UIKit
import Combine

class HotSalesCellViewModel {
    @Published var headerLabel: String = ""
    @Published var discriptionLabel: String = ""
    @Published var isNew: Bool = false
    @Published var image: String = ""
        
    private let offer: HomeStore
    
    init(offer: HomeStore) {
        self.offer = offer
        
        setUpBindings()
    }
    
    private func setUpBindings() {
        headerLabel = offer.title ?? ""
        discriptionLabel = offer.subtitle ?? ""
        image = offer.picture
        isNew = offer.isNew ?? false
    }
}

enum HotSalesSection {
    case main
}
