//
//  MSDateFormatter.swift
//  Movie Searching App
//
//  Created by Murat Emre Aygün on 21.06.2019.
//  Copyright © 2019 muratemreaygun. All rights reserved.
//

import Foundation

enum DateFormat: String {
    case server = "yyyy-MM-dd"
    case app    = "MMMM yyyy"
}

class MSDateFormatter: DateFormatter {
    static let shared = MSDateFormatter()
    
    func ms_date(from string: String, with format: DateFormat = .server) -> Date? {
        self.dateFormat = format.rawValue
        self.timeZone = TimeZone.init(identifier: "Europe/Istanbul")
        return self.date(from: string)
    }
    
    func ms_string(from date: Date, with format: DateFormat = .server) -> String {
        self.dateFormat = format.rawValue
        self.timeZone = TimeZone.init(identifier: "Europe/Istanbul")
        return self.string(from: date)
    }
}
