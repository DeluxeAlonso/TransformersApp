//
//  AppDelegate.swift
//  TransformersApp
//
//  Created by Alonso on 12/3/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?

    /// We need to keep a strong reference of all of our initial coordinators.
    /// This is an array to support multiple scenes.
    var mainCoordinators: [Coordinator] = []

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 13, *) {
        } else {
            self.window = UIWindow()
            self.window?.rootViewController = SplashBuilder.buildViewController()
            self.window?.makeKeyAndVisible()
        }

        return true
    }

}
