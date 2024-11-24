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
        let viewModel = CharactersViewModel(charactersUseCase: charactersUseCase)
        let charactersVC = CharactersViewController.instantiate(main)
        // Passing Dependencies
        charactersVC.viewModel = viewModel
        charactersVC.mainCoordinate = self
        navigationController.pushViewController(charactersVC, animated: true)
    }


    func navigateToCharacterDetails() {
        
    }
}
