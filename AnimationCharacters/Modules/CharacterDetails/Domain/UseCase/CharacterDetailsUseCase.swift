//
//  CharacterDetailsUseCase.swift
//  iJusoor
//
//  Created by Mohamed Sadek on 25/11/2024.
//

import Foundation
import Combine

/// UseCase Protocol
protocol CharacterDetailsUseCaseProtocol: AnyObject {
    func getCharacterDetails(with body: CharacterDetailsRequestModel) -> AnyPublisher<CharacterModelItem, NetworkError>
}

/// UseCase
class CharacterDetailsUseCase {
    //MARK: Variables
    private let remoteCharacterDetailsRepo: CharacterDetailsRemoteRepositoryProtocol
    private var cancelable: Set<AnyCancellable> = []
    //MARK: Init
    init(remoteCharacterDetailsRepo: CharacterDetailsRemoteRepositoryProtocol) {
        self.remoteCharacterDetailsRepo = remoteCharacterDetailsRepo
    }

    //MARK: Methods
    private func mapCharacterDetails(_ response: CharacterDetailsResponseModel) -> CharacterModelItem {
         return CharacterModelItem(id: response.id ?? 0,
                               image: response.image ?? "",
                               name: response.name ?? "",
                               specie: response.species ?? "",
                               gender: response.gender ?? "",
                               location: response.location?.name ?? "",
                               status: response.status ?? "")
    }
}

/// UseCase Extension
extension CharacterDetailsUseCase: CharacterDetailsUseCaseProtocol{
    func getCharacterDetails(with body: CharacterDetailsRequestModel) -> AnyPublisher<CharacterModelItem, NetworkError> {
        return Future<CharacterModelItem, NetworkError> { [weak self] promise in
            guard let self else { return }
            remoteCharacterDetailsRepo.getCharacterDetails(with: body)
                .sink(
                    receiveCompletion: { result in
                        if case .failure(let error) = result {
                            promise(.failure(error))
                        }
                    },
                    receiveValue: {[weak self] response in
                        guard let self else { return }
                        promise(.success(mapCharacterDetails(response)))
                    }).store(in: &cancelable)
        }
        .eraseToAnyPublisher()
    }
}
