//
//  HomeTableViewCell.swift
//  Movie
//
//  Created by Yashar on 7/21/19.
//  Copyright © 2019 Yashar Azabdaftari. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    // ===========================
    // MARK: - Properties
    // ===========================
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var movieDateLabel: UILabel!
    @IBOutlet private weak var movieOverViewLabel: UILabel!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    var moveViewModel: MovieViewModel! {
        didSet {
            movieDateLabel.text = moveViewModel.movieDate
            movieOverViewLabel.text = moveViewModel.movieOverView
            movieTitleLabel.text = moveViewModel.movieTitle
            movieImageView.loadImageAsync(url: moveViewModel.moviePosterUrl)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}
// ==================
// MARK: ReusableView
// ==================
extension HomeTableViewCell: ReusableView {}

// =====================
// MARK: NibLoadableView
// =====================
extension HomeTableViewCell: NibLoadableView {}
