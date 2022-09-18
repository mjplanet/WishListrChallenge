//
//  Movie.swift
//  WishListrChallenge
//
//  Created by Mobin Jahantark on 9/17/22.
//  Copyright © 2022 mobinjt.com. All rights reserved.
//

import Foundation

struct Movies: Hashable, Decodable {
    let movieItems: [MovieItem]?
    
    enum CodingKeys: String, CodingKey {
        case movieItems = "Search"
    }
}

struct MovieItem: Hashable, Codable {
    let uuid = UUID()
    
    var title: String?
    var year: String?
    var posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case posterPath = "Poster"
    }
    
    static func ==(lhs: MovieItem, rhs: MovieItem) -> Bool {
        return lhs.uuid == rhs.uuid
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
