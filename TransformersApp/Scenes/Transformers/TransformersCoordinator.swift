//
//  TransformersCoordinator.swift
//  TransformersApp
//
//  Created by Alonso on 12/5/20.
//

import UIKit

final class TransformersCoordinator: NSObject, TransformersCoordinatorProtocol, Coordinator {

    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let interactor = TransformersInteractor(secureStorage: SecureStorage.shared, transformerClient: TransformerClient())
        let viewModel = TransformersViewModel(interactor: interactor)

        let viewController = TransformersViewController(viewModel: viewModel)
        viewController.coordinator = self

        navigationController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }

    func showTransformerAddForm() {
        let navigationController = UINavigationController()
        let coordinator = AddTransformerCoordinator(navigationController: navigationController)

        coordinator.presentingViewController = self.navigationController.topViewController
        coordinator.parentCoordinator = unwrappedParentCoordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }

    func showTransformerEditForm(for transformer: Transformer) {
        let coordinator = EditTransformerCoordinator(navigationController: navigationController)

        coordinator.transformer = transformer
        coordinator.parentCoordinator = unwrappedParentCoordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }

}

// MARK: - UINavigationControllerDelegate

extension TransformersCoordinator: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        // Check whether our view controller array already contains that view controller.
        // If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        unwrappedParentCoordinator.childDidFinish()
    }

}
