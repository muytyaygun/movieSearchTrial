//
//  MovieSearchDataController.swift
//  Movie Searching App
//
//  Created by Murat Emre Aygün on 21.06.2019.
//  Copyright © 2019 muratemreaygun. All rights reserved.
//

import Foundation
import ObjectMapper

class MovieSearchDataController: DataController {
    static let sharedInstance = MovieSearchDataController()
    
    func searchMovies(request: MovieSearchRequest, completion: @escaping (_ response: MovieSearchResponse?,_ error: NSError?) -> Void) {
        let endpoint = "search/movie"
        let parameters: [String : Any] = Mapper<MovieSearchRequest>().toJSON(request)
        self.getRequest(endpoint: endpoint, parameters: parameters, completion: completion)
    }
}

