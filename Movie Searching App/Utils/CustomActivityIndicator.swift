//
//  CustomActivityIndicator.swift
//  Movie Searching App
//
//  Created by Murat Emre Aygün on 21.06.2019.
//  Copyright © 2019 muratemreaygun. All rights reserved.
//

import Foundation
import UIKit

class CustomActivityIndicator {
    static let shared = CustomActivityIndicator()
    
    var activityIndicatorView = UIActivityIndicatorView()
    
    public func startActivity(to view: UIView)
    {
        activityIndicatorView.frame = view.frame;
        activityIndicatorView.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.style = .white
        activityIndicatorView.color = UIColor.black
        activityIndicatorView.startAnimating()
        activityIndicatorView.center = view.center
        view.addSubview(activityIndicatorView)
    }
    
    public func endActivity()
    {
        activityIndicatorView.removeFromSuperview()
        activityIndicatorView.stopAnimating()
    }
}



