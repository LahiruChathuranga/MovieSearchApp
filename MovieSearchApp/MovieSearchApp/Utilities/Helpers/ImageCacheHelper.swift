//
//  ImageCacheHelper.swift
//  MovieSearchApp
//
//  Created by Lahiru Chathuranga on 2024-10-31.
//

import UIKit

class ImageCacheHelper {
    static let shared = ImageCacheHelper()
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getImage(for url: String) -> UIImage? {
        return cache.object(forKey: NSString(string: url))
    }
    
    func setImage(_ image: UIImage, for url: String) {
        cache.setObject(image, forKey: NSString(string: url))
    }
    
    func loadImage(from url: String, completion: @escaping (UIImage?) -> Void) {
        // Check cache first
        if let cachedImage = getImage(for: url) {
            completion(cachedImage)
            return
        }
        
        // Download the image
        guard let url = URL(string: url) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // Check for errors
            if let error = error {
                print("Error loading image: \(error)")
                completion(nil)
                return
            }
            
            // Check for data
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            // Cache the image
            self.setImage(image, for: url.absoluteString)
            DispatchQueue.main.async {
                completion(image)
            }
        }
        task.resume()
    }
}
