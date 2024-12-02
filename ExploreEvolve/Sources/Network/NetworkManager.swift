//
//  NetworkManager.swift
//  ExploreEvolve
//
//  Created by Jaideep on 01/12/24.
//

import Combine
import Foundation

class NetworkManager {
    // MARK: Stored Properties
    static let shared = NetworkManager()
    private var cancellables: Set<AnyCancellable> = []
    private let decoder = JSONDecoder()
    
    
    // MARK: Initialisation
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    // MARK: Exposed Functions
    func makeGetNetworkRequest<T: Codable>(_ request: NetworkRequest, for responseType: T.Type) -> Future<T, Error> {
        return Future {[weak self] promise in
            guard let self else {
                return promise(.failure(NetworkError.scopeEscaped))
            }
            
            guard let url = request.url else {
                return promise(.failure(NetworkError.unresolvedURL))
            }
            
            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        throw NetworkError.invalidResponse
                    }
                    
                    return data
                }
                .receive(on: RunLoop.main)
                .decode(type: T.self, decoder: decoder)
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        promise(.failure(error))
                    }
                }, receiveValue: {
                    promise(.success($0))
                })
                .store(in: &cancellables)
        }
    }
    
}
