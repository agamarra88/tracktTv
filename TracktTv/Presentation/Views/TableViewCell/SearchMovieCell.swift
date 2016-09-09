//
//  SearchMovieCell.swift
//  TracktTv
//
//  Created by Arturo Gamarra on 9/9/16.
//  Copyright © 2016 Trivago. All rights reserved.
//

import UIKit

class SearchMovieCell: UITableViewCell {
    
    // MARK: - Properties
    @IBOutlet weak var moviewImageview: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!

    // MARK: - Public
    func setupCellWihMovie(movie:Movie) {
        self.subtitleLabel.text = movie.overview
        self.yearLabel.text = "\(movie.year)"
        self.titleLabel.text = movie.title
        if let url = NSURL(string: movie.thumbImageURL) {
            moviewImageview.af_setImageWithURL(url, placeholderImage: UIImage.fromColor(UIColor.whiteColor()))
        }
    }

}
