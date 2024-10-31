//
//  NetworkManager.swift
//  MovieSearchApp
//
//  Created by Lahiru Chathuranga on 2024-10-31.
//

import Foundation
import Combine

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case decodingFailed
    case custom(error: String)
}
class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetchData<T: Codable>(from urlString: String) -> AnyPublisher<T, NetworkError> {
        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> NetworkError in
                let customError = Responsehandler.handle(error: error)
                return NetworkError.custom(error: customError)
            }
            .eraseToAnyPublisher()
    }
}
