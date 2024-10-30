//
//  MovieService.swift
//  MovieSearchApp
//
//  Created by Lahiru Chathuranga on 2024-10-31.
//

import Foundation
import Combine

protocol MovieServiceProtocol {
    func searchMovies(query: String) -> AnyPublisher<SearchedMovieListModel, NetworkError>
}
class MovieService: MovieServiceProtocol {
    func searchMovies(query: String) -> AnyPublisher<SearchedMovieListModel, NetworkError> {
        let urlString = APIEndpoints.searchMovies(query: query)
        return NetworkManager.shared.fetchData(from: urlString)
    }
}
