//
//  MovieService.swift
//  WishListrChalenge
//
//  Created by Mobin Jahantark on 9/18/22.
//  Copyright © 2022 mobinjt.com. All rights reserved.
//

import Foundation

typealias MovieApiServiceResultCompletion = (_ result: Result<Movies>) -> Void

protocol MovieApiService {
    func movies(page: Int, completion: @escaping MovieApiServiceResultCompletion)
}

class MovieApiServiceImplementation: MovieApiService {
    
    let apiClient: ApiClient
    
    init(_ apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func movies(page: Int, completion: @escaping MovieApiServiceResultCompletion) {
        apiClient.execute(request: MovieServiceRequest(page: page)) { (result: Result<ApiResponse<Movies>>) in
            switch result {
            case .success(let movies):
                completion(.success(movies.entity))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
