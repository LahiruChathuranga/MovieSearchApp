//
//  UIView+Extentions.swift
//  MovieSearchApp
//
//  Created by Lahiru Chathuranga on 2024-10-31.
//

import UIKit

extension UIView {
    func setCornerRadius(_ radius: Double) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}
