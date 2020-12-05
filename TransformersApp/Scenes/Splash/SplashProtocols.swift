//
//  SplashProtocols.swift
//  TransformersApp
//
//  Created by Alonso on 12/4/20.
//

import UIKit

protocol SplashViewModelProtocol {

    var accessTokenUpdated: (() -> Void)? { get set }

    func updateAccessToken()

}

protocol SplashInteractorProtocol {

    func updateTokenIfNeeded(completion: @escaping (Error?) -> Void)

}

protocol SplashCoordinatorProtocol {

    func showTransformersList(from viewController: UIViewController?)
}
