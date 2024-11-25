//
//  MainCoordinator.swift
//  AnimationCharacters
//
//  Created by Mohamed Sadek on 24/11/2024.
//

import Foundation
import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    private let main = Storyboards.main.rawValue

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        // Initialize Dependencies
        let remoteRepo = CharactersRemoteRepository()
        let charactersUseCase = CharactersUseCase(remoteCharactersRepo: remoteRepo)
        let viewModel = CharactersViewModel(charactersUseCase: charactersUseCase,
                                            mainCoordinator: self)
        let charactersVC = CharactersViewController.instantiate(main)
        // Passing Dependencies
        charactersVC.viewModel = viewModel
        navigationController.pushViewController(charactersVC, animated: true)
    }

    func navigateToCharacterDetails(id: Int) {
        // Initialize Dependencies
        let remoteRepo = CharacterDetailsRemoteRepository()
        let characterDetailsUseCase = CharacterDetailsUseCase(remoteCharacterDetailsRepo: remoteRepo)
        let viewModel = CharacterDetailsViewModel(characterDetailsUseCase: characterDetailsUseCase, mainCoordinator: self)
        let charcterDetailsVC = CharacterDetailsViewController.instantiate(main)
        // Passing Dependencies & variables
        charcterDetailsVC.viewModel = viewModel
        charcterDetailsVC.selectedCharacterId = id
        navigationController.pushViewController(charcterDetailsVC, animated: true)
    }

    func popViewController() {
        navigationController.popViewController(animated: true)
    }
}
