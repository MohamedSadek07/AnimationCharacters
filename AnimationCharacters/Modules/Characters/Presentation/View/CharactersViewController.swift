//
//  CharactersViewController.swift
//  AnimationCharacters
//
//  Created by Mohamed Sadek on 24/11/2024.
//

import UIKit
import SwiftUI

class CharactersViewController: BaseViewController, Storyboarded {

    //MARK: IBOUtlets
    @IBOutlet weak var charactersTableView: UITableView!

    //MARK: Variables
    weak var mainCoordinate: MainCoordinator?
    var viewModel: CharactersViewModel?
    var characters: [CharacterModelItem] = []

    //MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        charactersTableView.register(UITableViewCell.self, forCellReuseIdentifier: "CharacterCell")
        bindViewModel()
        viewModel?.getCharacters(page: viewModel?.pageNumber ?? 0)
    }

    //MARK: Methods
    private func setupNavigationBar() {
          let titleLabel = UILabel()
          titleLabel.text = "Characters"
          titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
          titleLabel.textColor = .black

          let leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
          navigationItem.leftBarButtonItem = leftBarButtonItem
      }

    private func bindViewModel() {
        viewModel?.characters.bind {[weak self] (data) in
            guard let self = self else {return}
            self.characters = data
            self.charactersTableView.reloadData()
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
               AlertUtility.showAlert(title: "Success", message: message, VC: self)
            }
        }
    }


    //MARK: Actions
}

/// TableView Extension
extension CharactersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath)

        // Use a SwiftUI view for the row content
        let item = characters[indexPath.row]
        let swiftUIView = CharacterCellView(dataSource: CharacterCellViewDataSource(name: item.name,
            specie: item.specie,
            imageLink: item.image))
        let hostingController = UIHostingController(rootView: swiftUIView)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false

        // Clear existing subviews to avoid duplication
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }

        cell.contentView.addSubview(hostingController.view)
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor)
        ])

        return cell
    }
}

/// ScrollView Extension
extension CharactersViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let _ = scrollView as? UITableView {
            let bottomEdge = Int(scrollView.contentOffset.y + scrollView.frame.size.height)
            if (bottomEdge >= Int(scrollView.contentSize.height)) {
                if let returnedPagesCount = self.viewModel?.returnedPagesCount, let pageNumber = self.viewModel?.pageNumber {
                    if returnedPagesCount > pageNumber {
                        self.viewModel?.pageNumber += 1
                        viewModel?.getCharacters(page: viewModel?.pageNumber ?? 0)
                    }
                }
            }
        }
    }
}
