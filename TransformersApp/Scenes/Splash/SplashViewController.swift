//
//  SplashViewController.swift
//  TransformersApp
//
//  Created by Alonso on 12/4/20.
//

import UIKit

class SplashViewController: UIViewController {

    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    var viewModel: SplashViewModelProtocol

    // MARK: - Initializers

    init(viewModel: SplashViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupBindings()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewModel.updateAccessToken()
    }

    // MARK: - Private

    private func setupUI() {
        view.addSubview(logoImageView)
        NSLayoutConstraint.activate([logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
                                     logoImageView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor),
                                     logoImageView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor),
                                     logoImageView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor),
                                     logoImageView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor)])
        logoImageView.image = UIImage(named: "TransformersSplashLogo")
    }

    // MARK: - Reactive Behavior

    private func setupBindings() {
        viewModel.accessTokenUpdated = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.initialTransition(from: strongSelf.view.window)
        }
    }

    func initialTransition(from window: UIWindow?) {
        guard let window = window else { return }
        UIView.transition(with: window,
                          duration: 0.5,
                          options: [UIView.AnimationOptions.curveEaseOut,
                                    UIView.AnimationOptions.transitionCrossDissolve],
                          animations: {},
                          completion: { _ in

                            let interactor = TransformersInteractor(secureStorage: SecureStorage.shared, transformerClient: TransformerClient())
                            let viewModel = TransformersViewModel(interactor: interactor)
                            let viewController = TransformersViewController(viewModel: viewModel)

                            window.rootViewController = UINavigationController(rootViewController: viewController)
        })
    }

}
