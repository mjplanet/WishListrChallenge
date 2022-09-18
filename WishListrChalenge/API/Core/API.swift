//
//  API.swift
//  WishListrChallenge
//
//  Created by Mobin Jahantark on 9/18/22.
//  Copyright © 2022 mobinjt.com. All rights reserved.
//

import Foundation

typealias Result<T> = Swift.Result<T, Error>

protocol ApiRequest {
    var urlRequest: URLRequest { get }
}

protocol ApiClient {
    func execute<T>(request: ApiRequest, completionHandler: @escaping (_ result: Result<ApiResponse<T>>) -> Void)
}

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }

class ApiClientImplementation: ApiClient {
    let urlSession: URLSessionProtocol
    
    init(configuration: URLSessionConfiguration = .default) {
        urlSession = URLSession(configuration: configuration)
    }
    
    /// Used for testing purposes
    init(urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
    }
    
    // MARK: - ApiClient
    
    func execute<T>(request: ApiRequest, completionHandler: @escaping (Result<ApiResponse<T>>) -> Void) {
        let dataTask = urlSession.dataTask(with: request.urlRequest) { (data, response, error) in
            guard let httpUrlResponse = response as? HTTPURLResponse else {
                completionHandler(.failure(NetworkRequestError(error: error)))
                return
            }
            
            let successRange = 200...299
            if successRange.contains(httpUrlResponse.statusCode) {
                do {
                    let response = try ApiResponse<T>(data: data, httpUrlResponse: httpUrlResponse)
                    completionHandler(.success(response))
                } catch {
                    completionHandler(.failure(error))
                }
            } else {
                completionHandler(.failure(ApiError(data: data, httpUrlResponse: httpUrlResponse)))
            }
        }
        dataTask.resume()
    }
}

extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}
