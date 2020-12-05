//
//  SplashCoordinator.swift
//  TransformersApp
//
//  Created by Alonso on 12/5/20.
//

import UIKit

final class SplashCoordinator: SplashCoordinatorProtocol {

    func showTransformersList(from viewController: UIViewController?) {
        guard let window = viewController?.view.window else { return }
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        UIView.transition(with: window,
                          duration: 0.5,
                          options: [UIView.AnimationOptions.curveEaseOut,
                                    UIView.AnimationOptions.transitionCrossDissolve],
                          animations: {},
                          completion: { _ in
                            let coordinator = TransformersCoordinator(navigationController: UINavigationController())
                            coordinator.start()
                            appDelegate.mainCoordinators.append(coordinator)

                            window.rootViewController = coordinator.navigationController
        })
    }

}
