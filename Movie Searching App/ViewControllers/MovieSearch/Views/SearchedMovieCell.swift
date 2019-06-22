//
//  SearchedMovieCell.swift
//  Movie Searching App
//
//  Created by Murat Emre Aygün on 21.06.2019.
//  Copyright © 2019 muratemreaygun. All rights reserved.
//

import Foundation
import UIKit

class SearchedMovieCell: TableViewNibCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyStyling()
    }
    
    private func applyStyling() {
        titleLabel.adjustsFontSizeToFitWidth = true
        releaseDateLabel.adjustsFontSizeToFitWidth = true
        overviewLabel.adjustsFontSizeToFitWidth = true
    }
    
    // MARK: Styling
    
    func update(searchData: SearchResult?) {
        movieImageView.ms_setImage(urlString: searchData?.poster_path)
        titleLabel.text = searchData?.original_title
        overviewLabel.text = searchData?.overview
        releaseDateLabel.text = nil
        if let releaseDate = searchData?.release_date {
            if let date = MSDateFormatter.shared.ms_date(from: releaseDate, with: .server) {
                let dateString = MSDateFormatter.shared.ms_string(from: date, with: .app)
                releaseDateLabel.text = dateString
            }
        }
    }
}
