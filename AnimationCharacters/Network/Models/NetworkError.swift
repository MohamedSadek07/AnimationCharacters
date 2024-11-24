//
//  NetworkError.swift
//  AnimationCharacters
//
//  Created by Mohamed Sadek on 24/11/2024.
//

import Foundation

enum NetworkError: Error {
    case normalError(Error)
    case notValidURL
    case unAuthorithed
    case requestFailed
    case internalError(NetworkErrorResponse) // Will be changed according to the base error model
    case emptyErrorWithStatusCode(String)
    case decodeFailed
}
