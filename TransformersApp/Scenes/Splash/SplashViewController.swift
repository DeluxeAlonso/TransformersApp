//
//  SplashViewController.swift
//  TransformersApp
//
//  Created by Alonso on 12/4/20.
//

import UIKit

class SplashViewController: UIViewController {

    private var splashView: SplashView!

    private var viewModel: SplashViewModelProtocol
    private var coordinator: SplashCoordinatorProtocol

    // MARK: - Initializers

    init(viewModel: SplashViewModelProtocol, coordinator: SplashCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        splashView = SplashView()
        view = splashView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // We can get the window and scene of this view controller
        // only after it has been added to the window hierarchy.
        viewModel.updateAccessToken()
    }

    // MARK: - Reactive Behavior

    private func setupBindings() {
        viewModel.accessTokenUpdated = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.coordinator.showTransformersList(from: self)
        }
    }

}
