//
//  CharacterDetailsRepositoryInterfaces.swift
//  iJusoor
//
//  Created by Mohamed Sadek on 25/11/2024.
//

import Foundation
import Combine

protocol CharacterDetailsRemoteRepositoryProtocol: AnyObject {
    func getCharacterDetails(with body: CharacterDetailsRequestModel) -> AnyPublisher<CharacterDetailsResponseModel, NetworkError>
}
