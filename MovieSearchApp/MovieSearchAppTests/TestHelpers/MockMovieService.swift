//
//  MockMovieService.swift
//  MovieSearchAppTests
//
//  Created by Lahiru Chathuranga on 2024-10-31.
//

import Foundation
import Combine
@testable import MovieSearchApp

class MockMovieService: MovieServiceProtocol {
    func searchMovies(query: String) -> AnyPublisher<SearchedMovieListModel, NetworkError> {
        if query.lowercased() == "avatar" {
            // Mock data for a successful response
            let mockData = SearchedMovieListModel(movies: [
                MovieModel(title: "Avatar", movieYear: "2009", posterImage: "somePosterURL"),
                MovieModel(title: "Avatar: The Way of Water", movieYear: "2022", posterImage: "somePosterURL2")
            ], totalResults: "2", response: "true")
            
            return Just(mockData)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
            
        } else {
            // Mock error response
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
    }
}
