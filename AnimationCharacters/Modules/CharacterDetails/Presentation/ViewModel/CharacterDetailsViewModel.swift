//
//
//  CharacterDetailsViewModel.swift
//  iJusoor
//
//  Created by Mohamed Sadek on 25/11/2024.
//

import Foundation
import Combine


class CharacterDetailsViewModel {
    //MARK: Variables
    private let characterDetailsUseCase: CharacterDetailsUseCaseProtocol
    private var cancelable: Set<AnyCancellable> = []
    var isLoading = Bindable(false)
    var errorMessage = Bindable(String())
    var characterDetails = Bindable(CharacterModelItem())
    //MARK: - Init
    init(characterDetailsUseCase: CharacterDetailsUseCaseProtocol) {
        self.characterDetailsUseCase = characterDetailsUseCase
    }
}


extension CharacterDetailsViewModel: CharactersDetailsViewModelProtocol {
    func getCharacterDetails(id: Int) {
        if id != 0 {
            isLoading.value = true
            let requestModel = CharacterDetailsRequestModel(id: id)
            characterDetailsUseCase.getCharacterDetails(with: requestModel).sink {  [weak self] result in
                guard let self else { return }
                DispatchQueue.main.async {
                    self.isLoading.value = false
                }
                if case .failure(let error) = result {
                    switch error {
                    case let .internalError(errorResponse):
                        errorMessage.value = errorResponse.error ?? ""
                    case .noInternetConnection:
                        errorMessage.value = "No Internet Connection"
                    default:
                        break
                    }
                }
            } receiveValue: {[weak self] response in
                guard let self else { return }
                print("Details", response)
                self.characterDetails.value = response
            }.store(in: &cancelable)
        } else {
            Log.error("Invalid character id")
        }
    }
}

