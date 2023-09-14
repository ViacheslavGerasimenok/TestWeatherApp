//
//  Request.swift
//  TestWeatherApp
//
//  Created by Bleiki on 14/09/2023.
//

struct Request<T: Decodable> {
    let host: String
    let path: String
    let method: HTTPMethod
    let headers: [String: String]?
    let parameters: [String: Any]?
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
    case head = "HEAD"
}
