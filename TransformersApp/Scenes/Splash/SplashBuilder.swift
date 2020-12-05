//
//  SplashBuilder.swift
//  TransformersApp
//
//  Created by Alonso on 12/5/20.
//

import UIKit

final class SplashBuilder {

    class func buildViewController() -> UIViewController {
        let interactor =  SplashInteractor(secureStorage: SecureStorage.shared,
                                           authClient: AuthClient())
        let viewModel = SplashViewModel(interactor: interactor)

        let viewController = SplashViewController(viewModel: viewModel,
                                                  coordinator: SplashCoordinator())

        return viewController
    }

}
