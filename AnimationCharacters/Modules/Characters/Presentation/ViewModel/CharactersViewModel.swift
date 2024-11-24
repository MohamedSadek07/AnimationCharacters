//
//
//  CharactersViewModel.swift
//  iJusoor
//
//  Created by Mohamed Sadek on 24/11/2024.
//

import Foundation
import Combine

class CharactersViewModel: CharactersViewModelProtocol {
    //MARK: Constants
    private let charactersUseCase: CharactersUseCaseProtocol
    private var cancelable: Set<AnyCancellable> = []
    var characters = Bindable([CharacterModelItem]())
    var isLoading = Bindable(false)
    var errorMessage = Bindable(String())
    var pageNumber = 1
    var returnedPagesCount = 0
    //MARK: - Init
    init(charactersUseCase: CharactersUseCaseProtocol) {
        self.charactersUseCase = charactersUseCase
    }
}

extension CharactersViewModel {
    func getCharacters(page: Int) {
        isLoading.value = true
        charactersUseCase.getCharactersList(with: CharactersRequestModel(page: page)).sink {  [weak self] result in
            print("Request page number", page)
            guard let self else { return }
            DispatchQueue.main.async {
            self.isLoading.value = false
            }
            if case .failure(let error) = result {
              switch error {
              case let .internalError(errorResponse):
                  errorMessage.value = errorResponse.error?.messages?.first ?? ""
              default:
                  break
              }
            }
        } receiveValue: {[weak self] response in
            guard let self else { return }
            self.returnedPagesCount = response.pagesCount
            self.characters.value += response.characters
        }.store(in: &cancelable)
    }
}
