//
//  MovieRequest.swift
//  WishListrChalenge
//
//  Created by Mobin Jahantark on 9/18/22.
//  Copyright © 2022 mobinjt.com. All rights reserved.
//

import Foundation

struct MovieServiceRequest: ApiRequest {

    private let apiKey = "7adbf12c"
    let page: Int = 1
    
    var urlRequest: URLRequest {
        var components = URLComponents(string: "http://www.omdbapi.com")!
        
        let keyQueryItem = URLQueryItem(name: "apikey", value: apiKey)
        let searchedQueryItem = URLQueryItem(name: "s", value: "batman")
        let typeQueryItem = URLQueryItem(name: "type", value: "movie")
//        let pageQueryItem = URLQueryItem(name: "page", value: "\(page)")
        components.queryItems = [keyQueryItem, searchedQueryItem, typeQueryItem]
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        return request
    }
    
}
