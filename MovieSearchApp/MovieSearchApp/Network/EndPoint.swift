//
//  EndPoint.swift
//  MovieSearchApp
//
//  Created by Lahiru Chathuranga on 2024-10-31.
//

import Foundation

enum APIEndpoints {
    static let baseURL = AppSettings.baseURL
    static let apiKey = AppSettings.apiKey
    
    static func searchMovies(query: String) -> String {
        return "\(baseURL)/?apikey=\(apiKey)&s=\(query)"
    }
}
