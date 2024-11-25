//
//  CharactersUseCase.swift
//  iJusoor
//
//  Created by Mohamed Sadek on 24/11/2024.
//

import Foundation
import Combine

/// UseCase Protocol
protocol CharactersUseCaseProtocol: AnyObject {
    func getCharactersList(with body: CharactersRequestModel) -> AnyPublisher<CharactersResponse, NetworkError>
    func filterCharactersByStatus(with body: FilterCharactersRequestModel) -> AnyPublisher<CharactersResponse, NetworkError>
}

/// UseCase
class CharactersUseCase {
    //MARK: Variables
    private let remoteCharactersRepo: CharactersRemoteRepositoryProtocol
    private var cancelable: Set<AnyCancellable> = []
    //MARK: Init
    init(remoteCharactersRepo: CharactersRemoteRepositoryProtocol) {
        self.remoteCharactersRepo = remoteCharactersRepo
    }
    //MARK: Methods
    private func mapCharacters(_ response: CharactersResponseModel) -> CharactersResponse {
        let characters = response.results?.map { character in
            CharacterModelItem(id: character.id ?? 0,
                               image: character.image ?? "",
                               name: character.name ?? "",
                               specie: character.species ?? "",
                               gender: character.gender ?? "",
                               location: character.location?.name ?? "",
                               status: character.status ?? "")
        }
        return CharactersResponse(characters: characters ?? [],
                                  pagesCount: response.info?.pages ?? 0)
    }
}

/// UseCase Extension
extension CharactersUseCase: CharactersUseCaseProtocol {
    func getCharactersList(with body: CharactersRequestModel) -> AnyPublisher<CharactersResponse, NetworkError> {
        return Future<CharactersResponse, NetworkError> { [weak self] promise in
            guard let self else { return }
            remoteCharactersRepo.getCharactersList(with: body)
                .sink(
                    receiveCompletion: { result in
                        if case .failure(let error) = result {
                            promise(.failure(error))
                        }
                    },
                    receiveValue: {[weak self] response in
                        guard let self else { return }
                        promise(.success(mapCharacters(response)))
                    }).store(in: &cancelable)
        }
        .eraseToAnyPublisher()
    }

    func filterCharactersByStatus(with body: FilterCharactersRequestModel) -> AnyPublisher<CharactersResponse, NetworkError> {
        return Future<CharactersResponse, NetworkError> { [weak self] promise in
            guard let self else { return }
            remoteCharactersRepo.filterCharactersByStatus(with: body)
                .sink(
                    receiveCompletion: { result in
                        if case .failure(let error) = result {
                            promise(.failure(error))
                        }
                    },
                    receiveValue: {[weak self] response in
                        guard let self else { return }
                        promise(.success(mapCharacters(response)))
                    }).store(in: &cancelable)
        }
        .eraseToAnyPublisher()
    }
}



