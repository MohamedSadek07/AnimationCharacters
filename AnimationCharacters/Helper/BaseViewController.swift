//
//  BaseViewController.swift
//  AnimationCharacters
//
//  Created by Mohamed Sadek on 25/11/2024.
//

import UIKit

class BaseViewController: UIViewController {
    private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        return indicator
    }()

    private var overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.isHidden = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
    }

    private func setupActivityIndicator() {
        // Configure the overlay view
        overlayView.frame = view.bounds
        overlayView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(overlayView)

        // Configure and add the activity indicator
        activityIndicator.center = overlayView.center
        overlayView.addSubview(activityIndicator)
    }

    func showActivityIndicator() {
        overlayView.isHidden = false
        activityIndicator.startAnimating()
    }

    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        overlayView.isHidden = true
    }
}

