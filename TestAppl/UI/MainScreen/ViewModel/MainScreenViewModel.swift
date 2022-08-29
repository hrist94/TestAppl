//
//  MainScreenViewModel.swift
//  Test
//
//  Created by Kirill Khristenko on 28.08.2022.
//

import Foundation
import Combine

final class MainScreenViewModel {
    
    @Published private(set) var bestSellers: [BestSeller] = []
    @Published private(set) var homeStore: [HomeStore] = []
    @Published private(set) var data: MainScreenData?
    @Published private(set) var state: MainScreenViewModelState = .loading
    
    private let service: MainScreenServiceProtocol
    private var bindings = Set<AnyCancellable>()
    
    init(service: MainScreenServiceProtocol = MainScreenService()) {
        self.service = service
    }
    
    func fetchData() {
        state = .loading
        service
            .getBestSellers()
            .sink { completion in
                switch completion {
                case .finished:
                    self.state = .finishedLoading
                case .failure(_):
                    self.state = .error(.dataFetch)
                }
            } receiveValue: { [weak self] data in
                self?.data = data
            }
            .store(in: &bindings)
    }
}

enum MainScreenViewModelError: Error, Equatable {
    case dataFetch
}

enum MainScreenViewModelState: Equatable {
    case loading
    case finishedLoading
    case error(MainScreenViewModelError)
}
