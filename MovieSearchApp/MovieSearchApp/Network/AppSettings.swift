//
//  AppSettings.swift
//  MovieSearchApp
//
//  Created by Lahiru Chathuranga on 2024-10-31.
//

import Foundation

enum Environment {
    case development
    case production
}

class AppSettings {
    static let environment: Environment = .development
    
    static var baseURL: String {
        switch environment {
        case .development:
            return "https://www.omdbapi.com"
        case .production:
            return ""
        }
    }
    
    static var apiKey: String {
        switch environment {
        case .development:
            return "8d6aa4ca"
        case .production:
            return ""
        }
    }
}
