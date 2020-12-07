//
//  EditTransformerCoordinator.swift
//  TransformersApp
//
//  Created by Alonso on 12/6/20.
//

import UIKit

class EditTransformerCoordinator: Coordinator, TransformerDetailCoordinatorProtocol {

    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController

    var transformer: Transformer!
    weak var updateDelegate: TransformersUpdateDelegate?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let interactor = TransformerDetailInteractor(secureStorage: SecureStorage.shared, transformerClient: TransformerClient())
        let factory = TransformerDetailFactory()
        let viewModel = EditTransformerViewModel(transformer, interactor: interactor, factory: factory)

        let viewController = TransformerDetailViewController(viewModel: viewModel)

        viewController.coordinator = self

        navigationController.pushViewController(viewController, animated: true)
    }

    func close() {
        navigationController.popViewController(animated: true)
    }

    func close(with resultingTransformer: Transformer) {
        updateDelegate?.didCreateOrUpdateNewTransformer(transformer: resultingTransformer)
        close()
    }

}
