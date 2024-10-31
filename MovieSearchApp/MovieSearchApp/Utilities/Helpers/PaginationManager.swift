//
//  PaginationManager.swift
//  MovieSearchApp
//
//  Created by Lahiru Chathuranga on 2024-10-31.
//

import Foundation

class PaginationManager {
    static let shared = PaginationManager()
    private init() {}
    
    // MARK: - Variables
    var nextPage: Int = 0
    var isLoadMore: Bool = false
    var isReachedLastPage: Bool = false
    
    func savePaginationData(dataModel: SearchedMovieListModel, totalItems: Int) {
        guard let totalResults = dataModel.totalResults, let movies = dataModel.movies else { return }
        
        if totalResults.toInt() > (totalItems + movies.count) {
            nextPage += 1
            isLoadMore = true
        } else {
            isReachedLastPage = true
            isLoadMore = false
            nextPage = 0
        }
    }
    
    func resetPaginationData() {
        isReachedLastPage = false
        isLoadMore = false
        nextPage = 0
    }
}
