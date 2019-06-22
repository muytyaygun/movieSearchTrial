//
//  MovieSearchRR.swift
//  Movie Searching App
//
//  Created by Murat Emre Aygün on 21.06.2019.
//  Copyright © 2019 muratemreaygun. All rights reserved.
//

import Foundation
import ObjectMapper

class MovieSearchRequest: BaseRequest {
    var apiKey: String?
    var query: String?
    var page: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        apiKey  <- map["api_key"]
        query   <- map["query"]
        page    <- map["page"]
    }
}

class MovieSearchResponse: BaseResponse {
    var page: Int?
    var total_results: Int?
    var total_pages: Int?
    var results: [SearchResult]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        page            <- map["page"]
        total_results   <- map["total_results"]
        total_pages     <- map["total_pages"]
        results         <- map["results"]
    }
}
