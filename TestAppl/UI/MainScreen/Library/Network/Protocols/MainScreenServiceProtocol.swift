//
//  MainScreenServiceProtocol.swift
//  TestAppl
//
//  Created by Kirill Khristenko on 29.08.2022.
//

import Foundation
import Combine

protocol MainScreenServiceProtocol {
    
    func fetchHotSales() -> Future<[HomeStore], MainScreenServiceError>
//    func fetchBestSellers() -> Future<[Be], MainScreenServiceError>
}
