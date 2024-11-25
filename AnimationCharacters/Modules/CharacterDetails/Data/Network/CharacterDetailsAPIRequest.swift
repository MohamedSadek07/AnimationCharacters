//
//  CharacterDetailsAPIRequest.swift
//  AnimationCharacters
//
//  Created by Mohamed Sadek on 25/11/2024.
//

import Foundation

enum CharacterDetailsAPIRequest {
    case getCharacterDetails(body: CharacterDetailsRequestModel)
}

extension CharacterDetailsAPIRequest: NetworkRequest {
    var method: HTTPMethod {
        return .GET
    }

    var path: String {
        switch self {
        case let .getCharacterDetails(body):
            return Constants.Network.baseURL + "/character" + "/\(body.id)"
        }
    }

    var parameters: Parameters? {
        nil
    }

    var headers: HTTPHeaders? {
        nil
    }

    var queryParams: [String : Any]? {
        nil
    }
}
