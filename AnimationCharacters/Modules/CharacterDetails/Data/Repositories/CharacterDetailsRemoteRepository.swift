//
//  CharacterDetailsRemoteRepository.swift
//  iJusoor
//
//  Created by Mohamed Sadek on 25/11/2024.
//

import Foundation
import Combine

class CharacterDetailsRemoteRepository {
    let networkApiClient = NetworkAPIClient(configuration: URLSession.shared.configuration, session: .shared)
}

extension CharacterDetailsRemoteRepository: CharacterDetailsRemoteRepositoryProtocol{
    func getCharacterDetails(with body: CharacterDetailsRequestModel) -> AnyPublisher<CharacterDetailsResponseModel, NetworkError> {
        networkApiClient.request(
          request: CharacterDetailsAPIRequest.getCharacterDetails(body: body).asURLRequest,
          mapToModel: CharacterDetailsResponseModel.self
        )
    }
}
