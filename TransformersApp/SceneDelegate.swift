//
//  SceneDelegate.swift
//  TransformersApp
//
//  Created by Alonso on 12/3/20.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        self.window = UIWindow(windowScene: windowScene)

        let interactor =  SplashInteractor(secureStorage: SecureStorage.shared, authClient: AuthClient())
        let viewModel = SplashViewModel(interactor: interactor)
        let viewController = SplashViewController(viewModel: viewModel)

        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()
    }

}

