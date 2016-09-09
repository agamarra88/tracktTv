//
//  MovieCell.swift
//  TracktTv
//
//  Created by Arturo Gamarra on 9/8/16.
//  Copyright © 2016 Trivago. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieCell: UICollectionViewCell {
    
    // MARK: - Properties
    @IBOutlet weak var movieImageView:UIImageView!
    @IBOutlet weak var movieTitleLabel:UILabel!
    @IBOutlet weak var yearLabel:UILabel!
    
    // MARK: - Public
    func setupCellWithMovie(movie:Movie) {
        movieTitleLabel.text = movie.title
        yearLabel.text = "\(movie.year)"
        if let url = NSURL(string: movie.thumbImageURL) {
            movieImageView.af_setImageWithURL(url, placeholderImage: UIImage.fromColor(UIColor.whiteColor()))
        }
    }
    
}
