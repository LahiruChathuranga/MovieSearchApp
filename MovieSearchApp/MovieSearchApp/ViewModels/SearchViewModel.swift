//
//  SearchViewModel.swift
//  MovieSearchApp
//
//  Created by Lahiru Chathuranga on 2024-10-31.
//

import Foundation
import Combine

class SearchViewModel {
    private var movieService: MovieServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    @Published var movies: [MovieModel] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    init(movieRepository: MovieServiceProtocol = MovieService()) {
        self.movieService = movieRepository
    }
    
    func searchMovies(query: String) {
        isLoading = true
        movieService.searchMovies(query: query)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = "Error: \(error.localizedDescription)"
                }
            }, receiveValue: { [weak self] searchResult in
                self?.isLoading = false
                self?.movies = searchResult.movies ?? []
            })
            .store(in: &cancellables)
    }
}
