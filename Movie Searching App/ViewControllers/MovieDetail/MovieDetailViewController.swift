//
//  MovieDetailViewController.swift
//  Movie Searching App
//
//  Created by Murat Emre Aygün on 20.06.2019.
//  Copyright © 2019 muratemreaygun. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailViewController: BaseViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    @IBOutlet weak var moviePointLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    var movieSearchViewModel: MovieSearchViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyling()
        update(movie: movieSearchViewModel?.selectedMovie)
    }
    
    // MARK: Styling
    
    private func applyStyling() {
        titleLabel.adjustsFontSizeToFitWidth = true
        movieReleaseDateLabel.adjustsFontSizeToFitWidth = true
        moviePointLabel.adjustsFontSizeToFitWidth = true
        movieOverviewLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func update(movie: SearchResult?) {
        titleLabel.text = movie?.original_title
        movieImageView.ms_setImage(urlString: movie?.poster_path)
        movieOverviewLabel.text = movie?.overview
        if let point = movie?.vote_average {
            moviePointLabel.text = "\(point) / 10"
        }
        if let releaseDate = movie?.release_date {
            if let date = MSDateFormatter.shared.ms_date(from: releaseDate, with: .server) {
                let dateString = MSDateFormatter.shared.ms_string(from: date, with: .app)
                movieReleaseDateLabel.text = dateString
            }
        }
    }
    
    // MARK: Actions
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true);
    }
}
