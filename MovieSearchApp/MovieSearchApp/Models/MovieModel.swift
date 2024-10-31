//
//  MovieModel.swift
//  MovieSearchApp
//
//  Created by Lahiru Chathuranga on 2024-10-31.
//

import Foundation

struct MovieModel: Codable {
    let title: String?
    let movieYear: String?
    let posterImage: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case movieYear = "Year"
        case posterImage = "Poster"
    }
}
