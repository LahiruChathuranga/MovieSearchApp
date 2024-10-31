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
    private var cancellable: AnyCancellable?
    
    @Published var movies: [MovieModel] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    init(movieRepository: MovieServiceProtocol = MovieService()) {
        self.movieService = movieRepository
    }
    
    func searchMovies(query: String, page: Int) {
        isLoading = true
        cancellable?.cancel()
        cancellable = movieService.searchMovies(query: query, page: page)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                self.isLoading = false
                if case let .failure(error) = completion {
                    switch error {
                    case .custom(error: let errorMessage):
                        self.errorMessage = errorMessage
                    default:
                        break
                    }
                }
            }, receiveValue: { [weak self] searchResult in
                guard let self else { return }
                self.isLoading = false
                guard searchResult.error == nil else {
                    self.errorMessage = "Your search returned too many results.\n Please enter at least 3 characters to start the search"
                    return
                }
                /// Updating pagination data
                PaginationManager.shared.savePaginationData(dataModel: searchResult, totalItems: self.movies.count)
                self.handleMovieDataWithPagination(data: searchResult)
            })
    }
    
    private func handleMovieDataWithPagination(data: SearchedMovieListModel) {
        /// if pagination is enabled we'll have to append the data
        /// unless we can assign to the array
        if PaginationManager.shared.isLoadMore || PaginationManager.shared.isReachedLastPage {
            self.movies.append(contentsOf: data.movies ?? [])
        } else {
            self.movies = data.movies ?? []
        }
    }
}
