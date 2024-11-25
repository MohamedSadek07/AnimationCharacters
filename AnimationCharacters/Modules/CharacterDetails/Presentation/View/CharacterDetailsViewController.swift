//
//  CharacterDetailsViewController.swift
//  iJusoor
//
//  Created by Mohamed Sadek on 25/11/2024.
//

import SwiftUI

class CharacterDetailsViewController: BaseViewController, Storyboarded {

    //MARK: IBOUtlets
    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var specieLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!

    //MARK: Variables
    weak var mainCoordinate: MainCoordinator?
    var viewModel: CharacterDetailsViewModel?
    var selectedCharacterId: Int = 0


    //MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addCustomBackButton()
        bindViewModel()
        viewModel?.getCharacterDetails(id: selectedCharacterId)
    }

    //MARK: Methods
    private func bindViewModel() {
        viewModel?.characterDetails.bind {[weak self] data in
            guard let self = self else {return}
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                self.setupUI(charcaterDetails: data)
            }
        }

        viewModel?.isLoading.bind {[weak self] isLoading in
            guard let self = self else {return}
            if isLoading {
                self.showActivityIndicator()
            } else {
                self.hideActivityIndicator()
            }
        }

        viewModel?.errorMessage.bind {[weak self] message in
            guard let self = self else {return}
            if message.count > 0 {
                AlertUtility.showAlert(title: "Error", message: message, VC: self)
            }
        }
    }

    private func setupUI(charcaterDetails: CharacterModelItem) {
        detailsImageView.setLoadedImage(from: charcaterDetails.image)
        nameLabel.text = charcaterDetails.name
        specieLabel.text = charcaterDetails.specie
        genderLabel.text = charcaterDetails.gender
        locationLabel.text = charcaterDetails.location
        statusLabel.text = charcaterDetails.status
    }

    private func addCustomBackButton() {
        let backButton = UIButton(type: .system)
        backButton.setTitle("", for: .normal)
        backButton.setImage(UIImage(named: "customBackButton"), for: .normal)
        backButton.tintColor = .black
        backButton.backgroundColor = .white
        backButton.layer.cornerRadius = 22
        backButton.addTarget(self, action: #selector(navigationControllerPopAction), for: .touchUpInside)

        // Replace the default back button with the custom button
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }

    //MARK: Actions
    @objc private func navigationControllerPopAction()  {
        mainCoordinate?.popViewController()
    }
}
