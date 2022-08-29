//
//  MainScreenService.swift
//  Test
//
//  Created by Kirill Khristenko on 28.08.2022.
//

import Foundation
import Combine

protocol MainScreenServiceProtocol {
    func getBestSellers() -> AnyPublisher<MainScreenData, Error>
}

final class MainScreenService: MainScreenServiceProtocol {

    func getBestSellers() -> AnyPublisher<MainScreenData, Error> {
        var dataTask: URLSessionDataTask?
        
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = { dataTask?.cancel() }
        
        return Future<MainScreenData, Error> { [weak self] result in
            guard let urlRequest = self?.getUrlRequest() else {
                result(.failure(ServiceError.urlRequest))
                return
            }
            dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
                guard let data = data else {
                    if let error = error {
                        result(.failure(error))
                    }
                    return
                }
                do {
                    let mainData = try JSONDecoder().decode(MainScreenData.self, from: data)
                    result(.success(mainData))
                } catch {
                    result(.failure(error))
                }
            }
        }
        .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    private func getUrlRequest() -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "run.mocky.io"
        components.path = "/v3/654bd15e-b121-49ba-a588-960956b15175"
        
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.timeoutInterval = 10.0
        request.httpMethod = "GET"
        return request
    }
}

enum ServiceError: Error {
    case url(URLError)
    case urlRequest
    case decode
}


