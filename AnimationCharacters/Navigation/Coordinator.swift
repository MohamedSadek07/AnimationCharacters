//
//  Coordinator.swift
//  AnimationCharacters
//
//  Created by Mohamed Sadek on 24/11/2024.
//

import UIKit

protocol Coordinator : AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
