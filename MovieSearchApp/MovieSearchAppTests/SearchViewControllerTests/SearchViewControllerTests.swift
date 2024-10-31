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
        sut = SearchViewController()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
}
