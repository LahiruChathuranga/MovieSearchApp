//
//  SearchViewControllerTests.swift
//  MovieSearchAppTests
//
//  Created by Lahiru Chathuranga on 2024-10-31.
//

import XCTest
import Combine
@testable import MovieSearchApp

final class SearchViewControllerTests: XCTestCase {
    
    var sut: SearchViewController?

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
        sut?.loadViewIfNeeded()
        
        sut?.viewModel = SearchViewModel(movieRepository: MockMovieService())
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testResetDataForEmptySearchText() {
        sut?.resetDataForEmptySearchText()
        
        XCTAssertEqual(sut?.labelNoSearchResults.isHidden, true)
    }
}
