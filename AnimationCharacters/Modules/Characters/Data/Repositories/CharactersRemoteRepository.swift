//
//  CharactersRemoteRepository.swift
//  iJusoor
//
//  Created by Mohamed Sadek on 24/11/2024.
//

import Foundation
import Combine

class CharactersRemoteRepository {
    let networkApiClient = NetworkAPIClient(configuration: URLSession.shared.configuration, session: .shared)
}

extension CharactersRemoteRepository: CharactersRemoteRepositoryProtocol{
    func getCharactersList(with body: CharactersRequestModel) -> AnyPublisher<CharactersResponseModel, NetworkError> {
        networkApiClient.request(
            request: CharactersAPIRequest.getCharacters(body: body).asURLRequest,
          mapToModel: CharactersResponseModel.self
        )
    }

    func filterCharactersByStatus(with body: FilterCharactersRequestModel) -> AnyPublisher<CharactersResponseModel, NetworkError> {
        networkApiClient.request(
            request: CharactersAPIRequest.filterCharacters(body: body).asURLRequest,
          mapToModel: CharactersResponseModel.self
        )
    }
}
