//
//  MovieSearchViewModel.swift
//  Movie Searching App
//
//  Created by Murat Emre Aygün on 21.06.2019.
//  Copyright © 2019 muratemreaygun. All rights reserved.
//

import Foundation

class MovieSearchViewModel {
    
    var movieSearchResults: [SearchResult]?
    var selectedMovie: SearchResult?
    
    var searchString: String?
    var totalPageCount: Int?
    var page: Int = 1
    
    var canFetchMore: Bool {
        if let totalPageCount = totalPageCount {
            if totalPageCount >= 1000 {
                return page < 1000
            }
            else {
                return page < totalPageCount
            }
        }
        else {
            return true
        }
    }
    
    func getSearchedMovies(apiKey: String = "2696829a81b1b5827d515ff121700838",completion: @escaping (_ isSuccessful: Bool) -> Void) {
        let request = MovieSearchRequest()
        request.apiKey = apiKey
        request.query = searchString
        request.page = "\(page)"
        print("\(request.query) page: \(request.page)")
        MovieSearchDataController.sharedInstance.searchMovies(request: request) {[weak self] (response: MovieSearchResponse?, error: NSError?) in
            guard let strongSelf = self else {return}
            if let response = response {
                if strongSelf.page == 1 {
                    strongSelf.movieSearchResults = response.results
                }
                else {
                    strongSelf.movieSearchResults?.append(contentsOf: response.results ?? [])
                }
                strongSelf.totalPageCount = response.total_pages
                completion(true)
            }
            else {
                completion(false)
            }
        }
    }
}
