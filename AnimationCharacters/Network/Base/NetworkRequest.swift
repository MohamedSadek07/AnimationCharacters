//
//  NetworkRequest.swift
//  AnimationCharacters
//
//  Created by Mohamed Sadek on 24/11/2024.
//

import Foundation

protocol NetworkRequest {
    var path: String { get }
    var endPoint: String { get }
    var headers: HTTPHeaders? { get }
    var queryParams: Parameters? { get }
    var parameters: Parameters? { get }
    var method: HTTPMethod { get }
}

extension NetworkRequest {
    private var components: URLComponents {
        let components = URLComponents()
        return components
    }

    private var baseHeaders: HTTPHeaders {
        let headers = [
            "Content-Type": "application/json",
            "Accept": "application/json",
        ]
        return headers
    }

    private func addQueryItems(queryParams: [String: Any]) -> [URLQueryItem] {
        return queryParams.map({
            URLQueryItem(name: $0.key, value: "\($0.value)")}
        )
    }

    func asURLRequest() -> URLRequest {
        /// URL Components
        var components = components
        components.path = "/" + path

        /// Request
        guard let componentsURL = components.url else {
            print("Invalid URL Components: \(components)")
            return URLRequest(url: URL(string: "https://google.com")!)
        }
        var urlRequest = URLRequest(url: componentsURL)
        if path.contains("https://") || path.contains("http://"),
           let url = URL(string: path) {
            urlRequest = URLRequest(url: url)
        }
        /// Method Type
        urlRequest.httpMethod = method.rawValue

        /// Headers
        let requestHeaders = baseHeaders + headers
        requestHeaders.forEach {
            urlRequest.addValue($1, forHTTPHeaderField: $0)
        }

        /// Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch let error {
                print(error)
            }
        }
        return urlRequest
    }
}

typealias HTTPHeaders = [String:String]
typealias Parameters = [String: Any]
