//
//  BorderedButton.swift
//  AnimationCharacters
//
//  Created by Mohamed Sadek on 25/11/2024.
//

import UIKit

@IBDesignable
class BorderedButton: UIButton {

    @IBInspectable var borderColor: UIColor = UIColor.gray {
        didSet {
            setupView()
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0.5 {
        didSet {
            setupView()
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 12 {
        didSet {
            setupView()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }

    private func setupView() {
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        if let titleLabel = titleLabel {
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        titleLabel.textColor = #colorLiteral(red: 0.149933666, green: 0, blue: 0.2669309676, alpha: 1)
        }
    }
}
