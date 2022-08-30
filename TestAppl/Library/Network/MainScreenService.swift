//
//  MainScreenService.swift
//  TestAppl
//
//  Created by Kirill Khristenko on 29.08.2022.
//

import Foundation
import Combine

class MainScreenService: MainScreenServiceProtocol {
    
    static let shared = MainScreenService()
    private init() {}
    private let apiURL = "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175"
    private let urlSession = URLSession.shared
    private let jsonDecoder = JSONDecoder()
    private var subscriptions = Set<AnyCancellable>()
    
    func fetchHotSales() -> Future<[HomeStore], MainScreenServiceError> {
        return Future<[HomeStore], MainScreenServiceError> { [unowned self] result in
            guard let url = URL(string: apiURL) else {
                return result(.failure(.urlError(URLError(URLError.unsupportedURL))))
            }
            
            self.urlSession.dataTaskPublisher(for: url)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse,
                          200...299 ~= httpResponse.statusCode else {
                        throw MainScreenServiceError.responseError((response as? HTTPURLResponse)?.statusCode ?? 500)
                        
                    }
                    return data
                }
                .decode(type: MainScreenData.self, decoder: self.jsonDecoder)
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { (completion) in
                    if case let .failure(error) = completion {
                        switch error {
                        case let urlError as URLError:
                            result(.failure(.urlError(urlError)))
                        case let decodingError as DecodingError:
                            result(.failure(.decodingError(decodingError)))
                        case let apiError as MainScreenServiceError:
                            result(.failure(apiError))
                        default:
                            result(.failure(.genericError))
                        }
                    }
                }, receiveValue: { result(.success($0.homeStore)) })
                .store(in: &self.subscriptions)
        }
    }
    func fetchBestSellers() -> Future<[BestSeller], MainScreenServiceError> {
        return Future<[BestSeller], MainScreenServiceError> { [unowned self] result in
            guard let url = URL(string: apiURL) else {
                return result(.failure(.urlError(URLError(URLError.unsupportedURL))))
            }
            
            self.urlSession.dataTaskPublisher(for: url)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse,
                          200...299 ~= httpResponse.statusCode else {
                        throw MainScreenServiceError.responseError((response as? HTTPURLResponse)?.statusCode ?? 500)
                        
                    }
                    return data
                }
                .decode(type: MainScreenData.self, decoder: self.jsonDecoder)
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { (completion) in
                    if case let .failure(error) = completion {
                        switch error {
                        case let urlError as URLError:
                            result(.failure(.urlError(urlError)))
                        case let decodingError as DecodingError:
                            result(.failure(.decodingError(decodingError)))
                        case let apiError as MainScreenServiceError:
                            result(.failure(apiError))
                        default:
                            result(.failure(.genericError))
                        }
                    }
                }, receiveValue: { result(.success($0.bestSeller)) })
                .store(in: &self.subscriptions)
        }
    }
}
