//
//  ApplicationServiceProvider.swift
//  MovieSearchApp
//
//  Created by Lahiru Chathuranga on 2024-10-30.
//

import Foundation

typealias ASP = ApplicationServiceProvider.shared

class ApplicationServiceProvider {
    static let shared = ApplicationServiceProvider()
    private init() {}
    
    func configureAppearance() {
        /// setup navigation bar 
    }
}
