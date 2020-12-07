//
//  TransformerEditCoordinator.swift
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

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = EditTransformerViewModel()
        let viewController = TransformerDetailViewController(viewModel: viewModel)

        viewController.coordinator = self

        navigationController.pushViewController(viewController, animated: true)
    }

    func close() {}

}
