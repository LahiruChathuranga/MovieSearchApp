//
//  paginationHelperTestCases.swift
//  MovieSearchAppTests
//
//  Created by Lahiru Chathuranga on 2024-10-31.
//

import XCTest
@testable import MovieSearchApp

final class paginationHelperTestCases: XCTestCase {
    var sut: PaginationManager?
    
    override func setUpWithError() throws {
        sut = PaginationManager.shared
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testDoesNotLoadNextPageWhenTotalCountEqualsRetrievedCount() {
        // given
        let mockData = SearchedMovieListModel(movies: [
            MovieModel(title: "Avatar", movieYear: "2009", posterImage: "somePosterURL"),
            MovieModel(title: "Avatar: The Way of Water", movieYear: "2022", posterImage: "somePosterURL2")
        ], totalResults: "2", response: "true")
        
        // when
        sut?.savePaginationData(dataModel: mockData, totalItems: 2)
        
        // then
        XCTAssertEqual(sut?.nextPage, 0)
        XCTAssertEqual(sut?.isLoadMore, false)
    }
    
    func testLoadsNextPageWhenTotalCountExceedsRetrievedCount() {
        // given
        let mockData = SearchedMovieListModel(movies: [
            MovieModel(title: "Avatar", movieYear: "2009", posterImage: "somePosterURL"),
            MovieModel(title: "Avatar: The Way of Water", movieYear: "2022", posterImage: "somePosterURL2")
        ], totalResults: "10", response: "true")
        
        // when
        sut?.savePaginationData(dataModel: mockData, totalItems: 2)
        
        // then
        XCTAssertEqual(sut?.nextPage, 1)
        XCTAssertEqual(sut?.isLoadMore, true)
    }
    
    func testResetPaginationData() {
        // given
        let mockData = SearchedMovieListModel(movies: [
            MovieModel(title: "Avatar", movieYear: "2009", posterImage: "somePosterURL"),
            MovieModel(title: "Avatar: The Way of Water", movieYear: "2022", posterImage: "somePosterURL2")
        ], totalResults: "10", response: "true")
        
        // when
        sut?.savePaginationData(dataModel: mockData, totalItems: 2)
        sut?.resetPaginationData()
        
        // then
        XCTAssertEqual(sut?.nextPage, 0)
        XCTAssertEqual(sut?.isLoadMore, false)
        XCTAssertEqual(sut?.isReachedLastPage, false)
    }
    
}
