//
//  NetworkErrorResponse.swift
//  AnimationCharacters
//
//  Created by Mohamed Sadek on 24/11/2024.
//

import Foundation

struct NetworkErrorResponse: Codable {
    let error: NetworkErrorModel?
}

struct NetworkErrorModel: Codable {
    let code: Int?
    let message: String?
    let messages: [String]?
    let date: String?
    let status: Int?
}
