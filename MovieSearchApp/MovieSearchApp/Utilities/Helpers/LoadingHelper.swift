//
//  LoadingHelper.swift
//  MovieSearchApp
//
//  Created by Lahiru Chathuranga on 2024-10-31.
//

import Foundation
import RappleProgressHUD

protocol LoadingManagerDelegate {
    func startLoading()
    func stopLoading()
}
extension LoadingManagerDelegate {
    func startLoading() {
        DispatchQueue.main.async {
            let attributes = RappleActivityIndicatorView.attribute(style: .apple,
                                                                   tintColor: .red,
                                                                   progressBG: .white)
            RappleActivityIndicatorView.startAnimatingWithLabel("Just a moment",
                                                                attributes: attributes)
        }
    }
    
    func stopLoading() {
        RappleActivityIndicatorView.stopAnimation()
    }
}
