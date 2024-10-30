//
//  SearchMovieListModel.swift
//  MovieSearchApp
//
//  Created by Lahiru Chathuranga on 2024-10-31.
//

import Foundation

struct SearchedMovieListModel: Codable {
    let movies: [MovieModel]?
    let totalResults: String?
    let response: Bool
    
    enum CodingKeys: String, CodingKey {
        case movies = "Search"
        case totalResults = "totalResults"
        case response = "Response"
    }
}
