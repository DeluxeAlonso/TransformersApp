//
//  SplashView.swift
//  TransformersApp
//
//  Created by Alonso on 12/5/20.
//

import UIKit

class SplashView: UIView {

    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private

    private func setupUI() {
        addSubview(logoImageView)
        NSLayoutConstraint.activate(
            [
                logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
                logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
                logoImageView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor),
                logoImageView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
                logoImageView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
                logoImageView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor)
            ]
        )
        logoImageView.image = UIImage(named: Constants.logoImageName)
    }

}

extension SplashView {

    struct Constants {
        static let logoImageName = "TransformersSplashLogo"
    }

}
