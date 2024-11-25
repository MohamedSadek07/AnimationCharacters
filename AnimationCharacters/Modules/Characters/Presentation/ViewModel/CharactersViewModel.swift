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
    //MARK: Variables
    private let charactersUseCase: CharactersUseCaseProtocol
    private var cancelable: Set<AnyCancellable> = []
    var characters = Bindable([CharacterModelItem]())
    var isLoading = Bindable(false)
    var errorMessage = Bindable(String())
    var pageNumber = 1
    var returnedPagesCount = 0
    var isFilterApplied = false
    var currentStatus = ""
    //MARK: - Init
    init(charactersUseCase: CharactersUseCaseProtocol) {
        self.charactersUseCase = charactersUseCase
    }
}

extension CharactersViewModel {
    func getCharacters() {
        isLoading.value = true
        let requestModel = CharactersRequestModel(page: self.pageNumber)
        charactersUseCase.getCharactersList(with: requestModel).sink {  [weak self] result in
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
    
    func filterCharacters(status: String) {
        isLoading.value = true
        let requestModel = FilterCharactersRequestModel(page: self.pageNumber, status: status)
        charactersUseCase.filterCharactersByStatus(with: requestModel).sink {  [weak self] result in
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
    
    func resetPaginationAttributes() {
        pageNumber = 1
        returnedPagesCount = 0
        characters.value.removeAll()
    }
}
