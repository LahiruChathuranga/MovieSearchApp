//
//  Responsehandler.swift
//  MovieSearchApp
//
//  Created by Lahiru Chathuranga on 2024-10-31.
//

import Foundation

class Responsehandler {
    static func handle(error: Error) -> String {
        if let urlError = error as? URLError {
            switch urlError.code {
            case .timedOut:
                return "The request timed out. Please try again later."
            case .cancelled:
                return "The request was cancelled."
            case .notConnectedToInternet:
                return "You are not connected to the internet. Please check your internet connection and try again."
            case .badURL:
                return "The URL provided is not valid."
            case .userAuthenticationRequired:
                return "User authentication is required to access the resource."
            default:
                return "An unexpected error occurred. Please try again later."
            }
        } else {
            return "An internal error occurred. Please try again later."
        }
    }
}
