//
//  TransformerAddCoordinator.swift
//  TransformersApp
//
//  Created by Alonso on 12/6/20.
//

import UIKit

class TransformerAddCoordinator: Coordinator, TransformerDetailCoordinatorProtocol {

    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController

    var presentingViewController: UIViewController!

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = TransformerAddViewModel()
        let viewController = TransformerDetailViewController(viewModel: viewModel)

        viewController.coordinator = self

        navigationController.pushViewController(viewController, animated: false)
        navigationController.modalPresentationStyle = .fullScreen

        presentingViewController.present(navigationController, animated: true, completion: nil)
    }

    func close() {
        let presentedViewController = navigationController.topViewController
        presentedViewController?.dismiss(animated: true) { [weak self] in
            self?.parentCoordinator?.childDidFinish()
        }
    }

}
