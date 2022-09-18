//
//  Responses.swift
//  WishListrChallenge
//
//  Created by Mobin Jahantark on 9/18/22.
//  Copyright © 2022 mobinjt.com. All rights reserved.
//

import Foundation

struct NetworkRequestError: Error {
    let error: Error?
    
    var localizedDescription: String {
        return error?.localizedDescription ?? "Network request error"
    }
}

/// 4xx or a 5xx errors
struct ApiError: Error {
    let data: Data?
    let httpUrlResponse: HTTPURLResponse
}

/// thrown by InitializableWithData.init(data: Data?) implementations when parsing the data
struct ApiParseError: Error {
    static let code = 999
    
    let error: Error
    let httpUrlResponse: HTTPURLResponse
    let data: Data?
    
    var localizedDescription: String {
        return error.localizedDescription
    }
}

/// Successful API response and it includes the generic data as well
struct ApiResponse<T: Decodable> {
    let entity: T
    let httpUrlResponse: HTTPURLResponse
    let data: Data?
    
    init(data: Data?, httpUrlResponse: HTTPURLResponse) throws {
        do {
            self.entity = try JSONDecoder().decode(T.self, from: data ?? Data())
            self.httpUrlResponse = httpUrlResponse
            self.data = data
        } catch {
            throw ApiParseError(error: error, httpUrlResponse: httpUrlResponse, data: data)
        }
    }
}
