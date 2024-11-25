//
//  CharactersRepositoryInterfaces.swift
//  iJusoor
//
//  Created by Mohamed Sadek on 24/11/2024.
//

import Foundation
import Combine

protocol CharactersRemoteRepositoryProtocol: AnyObject {
    func getCharactersList(with body: CharactersRequestModel) -> AnyPublisher<CharactersResponseModel, NetworkError>
    func filterCharactersByStatus(with body: FilterCharactersRequestModel) -> AnyPublisher<CharactersResponseModel, NetworkError>
}
