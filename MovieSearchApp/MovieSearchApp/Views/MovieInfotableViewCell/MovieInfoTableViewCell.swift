//
//  MovieInfoTableViewCell.swift
//  MovieSearchApp
//
//  Created by Lahiru Chathuranga on 2024-10-31.
//

import UIKit

class MovieInfoTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var labelMovieTitle: UILabel!
    @IBOutlet weak var labelReleasedYear: UILabel!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    
    // MARK: - Variables
    static let cellIdentifire = "MovieInfoTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        moviePosterImageView.image = UIImage(named: "placeholder")
    }
    
    func setupUI() {
        containerView.setCornerRadius(10)
    }
    
    func configureCell(with model: MovieModel) {
        labelMovieTitle.text = model.title
        labelReleasedYear.text = "Released on: \(model.movieYear ?? "N/A")"
        
        if let imageUrlString = model.posterImage {
            ImageCacheHelper.shared.loadImage(from: imageUrlString) { [weak self] image in
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.moviePosterImageView.image = image == nil ? UIImage(named: "placeholder") : image
                }
            }
        } else {
            self.moviePosterImageView.image = UIImage(named: "placeholder")
        }
    }
}
