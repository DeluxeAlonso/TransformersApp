//
//  AddTransformerCoordinator.swift
//  TransformersApp
//
//  Created by Alonso on 12/6/20.
//

import UIKit

final class AddTransformerCoordinator: Coordinator, TransformerDetailCoordinatorProtocol {

    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController

    var presentingViewController: UIViewController!
    weak var updateDelegate: TransformersUpdateDelegate?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let interactor = TransformerDetailInteractor(secureStorage: SecureStorage.shared, transformerClient: TransformerClient())
        let factory = TransformerDetailFactory()
        let viewModel = AddTransformerViewModel(interactor: interactor, factory: factory)

        let viewController = TransformerDetailViewController(viewModel: viewModel)
        viewController.showCloseButton = true

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

    func close(with resultingTransformer: Transformer) {
        updateDelegate?.didCreateOrUpdateNewTransformer(transformer: resultingTransformer)
        close()
    }

}
