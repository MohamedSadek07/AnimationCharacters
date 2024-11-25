//
//  CharactersAPIRequest.swift
//  AnimationCharacters
//
//  Created by Mohamed Sadek on 24/11/2024.
//

import Foundation

enum CharactersAPIRequest {
    case getCharacters(body: CharactersRequestModel)
    case filterCharacters(body: FilterCharactersRequestModel)
}

extension CharactersAPIRequest: NetworkRequest {
  var method: HTTPMethod {
        return .GET
  }

  var path: String {
      switch self {
      case .getCharacters, .filterCharacters:
          return Constants.Network.baseURL + "/character"
      }
  }

  var parameters: Parameters? {
    nil
  }

  var headers: HTTPHeaders? {
    nil
  }

  var queryParams: [String : Any]? {
      switch self {
      case let .getCharacters(body):
          return body.asDictionary
      case let .filterCharacters(body):
          return body.asDictionary
      }
  }
}
