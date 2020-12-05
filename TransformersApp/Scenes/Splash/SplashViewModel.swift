//
//  SplashViewModel.swift
//  TransformersApp
//
//  Created by Alonso on 12/4/20.
//

import Foundation

class SplashViewModel: SplashViewModelProtocol {

    private let interactor: SplashInteractorProtocol

    var accessTokenUpdated: (() -> Void)?

    // MARK: - Initializers

    init(interactor: SplashInteractorProtocol) {
        self.interactor = interactor
    }

    // MARK: - SplashViewModelProtocol

    func updateAccessToken() {
        interactor.updateTokenIfNeeded { _ in
            self.accessTokenUpdated?()
        }
    }

}
