//
//  Movie.swift
//  WishListrChalenge
//
//  Created by Mobin Jahantark on 9/17/22.
//  Copyright © 2022 mobinjt.com. All rights reserved.
//

import Foundation

struct Movie: Hashable {
    var title: String?
    var year: String?
    var posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case posterPath = "Poster"
    }
    
    // Computed variables
    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        guard let url = URL(string: path) else { return nil }
        return url
    }
}
