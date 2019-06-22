//
//  NetworkManager.swift
//  Movie Searching App
//
//  Created by Murat Emre Aygün on 21.06.2019.
//  Copyright © 2019 muratemreaygun. All rights reserved.
//

import Foundation

enum NetworkingMode: String {
    case production = "https://api.themoviedb.org/3/"
}

let networkingMode: NetworkingMode = .production

class NetworkManager {
    static let sharedInstance = NetworkManager.init(baseURL: networkingMode.rawValue)
    
    let baseURL: String
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
}
