//
//  SearchViewModelTestCases.swift
//  MovieSearchAppTests
//
//  Created by Lahiru Chathuranga on 2024-10-31.
//

import XCTest
import Combine
@testable import MovieSearchApp

final class SearchViewModelTestCases: XCTestCase {
    var sut: SearchViewModel?
    
    override func setUpWithError() throws {
        sut = SearchViewModel(movieRepository: MockMovieService())
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testSearchMoviesWithValidQueryReturnsNonEmptyResults() {
        // Given
        let searchKey = "avatar"
        let expectation = XCTestExpectation(description: "Wait for movies to be updated with non-empty data")
        var cancellables = Set<AnyCancellable>()
        
        // Subscribe to changes in `movies`
        sut?.$movies
            .dropFirst()
            .sink { movies in
                if !movies.isEmpty {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        // When
        sut?.searchMovies(query: searchKey)
        
        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertFalse(sut?.movies.isEmpty == true, "Movies should not be empty after a valid search query")
    }
    
    func testSearchMoviesWithInValidQueryReturnsEmptyResults() {
        // Given
        let searchKey = "unknown movie"
        
        // When
        sut?.searchMovies(query: searchKey)
        
        // Then
        XCTAssertTrue(sut?.movies.isEmpty == true)
        
        XCTAssertNil(sut?.errorMessage)
    }
}
