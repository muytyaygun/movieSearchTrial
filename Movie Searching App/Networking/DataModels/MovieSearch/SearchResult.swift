//
//  SearchResult.swift
//  Movie Searching App
//
//  Created by Murat Emre Aygün on 21.06.2019.
//  Copyright © 2019 muratemreaygun. All rights reserved.
//

import Foundation
import ObjectMapper

class SearchResult: BaseDataModel {
    var vote_count: Int?
    var id: Int?
    var video: Bool?
    var vote_average: Double?
    var title: String?
    var popularity: Double?
    var poster_path: String?
    var original_language: String?
    var original_title: String?
    var genre_ids: [Int]?
    var backdrop_path: String?
    var adult: Bool?
    var overview: String?
    var release_date: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        vote_count          <- map["vote_count"]
        id                  <- map["id"]
        video               <- map["video"]
        vote_average        <- map["vote_average"]
        title               <- map["title"]
        popularity          <- map["popularity"]
        poster_path         <- map["poster_path"]
        original_language   <- map["original_language"]
        original_title      <- map["original_title"]
        genre_ids           <- map["genre_ids"]
        backdrop_path       <- map["backdrop_path"]
        adult               <- map["adult"]
        overview            <- map["overview"]
        release_date        <- map["release_date"]
    }
}
