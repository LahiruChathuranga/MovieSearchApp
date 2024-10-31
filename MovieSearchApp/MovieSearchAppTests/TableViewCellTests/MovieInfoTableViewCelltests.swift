//
//  MovieInfoTableViewCelltests.swift
//  MovieSearchAppTests
//
//  Created by Lahiru Chathuranga on 2024-10-31.
//

import XCTest
@testable import MovieSearchApp

final class MovieInfoTableViewCelltests: XCTestCase {
    
    var sut: MovieInfoTableViewCell?
    
    override func setUpWithError() throws {
        let nib = UINib(nibName: MovieInfoTableViewCell.cellIdentifire, bundle: nil)
        sut = nib.instantiate(withOwner: nil, options: nil).first as? MovieInfoTableViewCell
        sut?.layoutIfNeeded()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testConfigureCellWithImageUrlSetTheImageAndValues() {
        // given
        let movieModel = MovieModel(title: "Avatar", movieYear: "2000", posterImage: "photo")
        
        // when
        sut?.configureCell(with: movieModel)
        
        // then
        XCTAssertEqual(sut?.labelMovieTitle.text, "Avatar")
    }
    
    func testConfigureCellWithoutImageUrlNotSetTheImage() {
        // given
        let movieModel = MovieModel(title: "Avatar", movieYear: "2000", posterImage: nil)
        
        // when
        sut?.configureCell(with: movieModel)
        
        // then
        XCTAssertNotNil(sut?.moviePosterImageView?.image)
    }
}
