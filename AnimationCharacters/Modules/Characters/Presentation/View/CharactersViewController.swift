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
    var viewModel: CharactersViewModel?
    var characters: [CharacterModelItem] = []

    //MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup Left naviagtion title
        setupNavigationBar()
        // Register for cell
        charactersTableView.register(UITableViewCell.self, forCellReuseIdentifier: "CharacterCell")
        // Bind viewModel data
        bindViewModel()
        // call getCharacters request
        viewModel?.getCharacters()
    }

    //MARK: Methods
    private func setupNavigationBar() {
          let titleLabel = UILabel()
          titleLabel.text = "Characters"
          titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
          titleLabel.textColor = #colorLiteral(red: 0.149933666, green: 0, blue: 0.2669309676, alpha: 1)

          let leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
          navigationItem.leftBarButtonItem = leftBarButtonItem
      }

    private func bindViewModel() {
        viewModel?.characters.bind {[weak self] (data) in
            guard let self = self else {return}
            if !data.isEmpty {
                self.characters = data
                self.charactersTableView.reloadData()
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


    //MARK: Actions
    @IBAction func filterButtonsTapped(_ sender: UIButton) {
        let tag = sender.tag
        viewModel?.resetPaginationAttributes()
        viewModel?.isFilterApplied = true
        let status = FilterStatuses(rawValue: tag)?.returnString() ?? ""
        viewModel?.currentStatus = status
        viewModel?.filterCharacters(status: status)
    }
}

/// TableView Extension
extension CharactersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath)

        // Use a SwiftUI view for the row content
        let character = characters[indexPath.row]
        let swiftUIView = CharacterCellView(dataSource: CharacterCellViewDataSource(
            name: character.name,
            specie: character.specie,
            imageLink: character.image))
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
        viewModel?.pushtoDetailsView(characterID: character.id)
    }
}

/// ScrollView Extension
extension CharactersViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let _ = scrollView as? UITableView {
            let bottomEdge = Int(scrollView.contentOffset.y + scrollView.frame.size.height)
            // check if user scrolled to bottom of the tableView
            if (bottomEdge >= Int(scrollView.contentSize.height)) {
                if let returnedPagesCount = self.viewModel?.returnedPagesCount, let pageNumber = self.viewModel?.pageNumber {
                    // check if there are more pages
                    if returnedPagesCount > pageNumber {
                        self.viewModel?.pageNumber += 1
                        if let isFilterApplied = viewModel?.isFilterApplied, isFilterApplied{
                            viewModel?.filterCharacters(status:  viewModel?.currentStatus ?? "")
                        } else {
                            viewModel?.getCharacters()
                        }
                    }
                }
            }
        }
    }
}
