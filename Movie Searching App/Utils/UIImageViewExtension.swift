//
//  UIImageViewExtension.swift
//  Movie Searching App
//
//  Created by Murat Emre Aygün on 21.06.2019.
//  Copyright © 2019 muratemreaygun. All rights reserved.
//

import Foundation
import SDWebImage

extension UIImageView {
    func ms_setImage(urlString: String?) {
        if var imageUrlName = urlString {
            imageUrlName = Constants.imageBaseUrl + imageUrlName
            
            if let imageUrl = URL.init(string: imageUrlName) {
                self.sd_setImage(with: imageUrl)
            }
        }
    }
}

