//
//  TransformersViewModel.swift
//  TransformersApp
//
//  Created by Alonso on 12/3/20.
//

import Foundation

struct TransformersViewModel: TransformersViewModelProtocol {

    private let authClient: AuthClient

    init(authClient: AuthClient) {
        self.authClient = authClient
    }

    func getTransformers() {
        authClient.getAccessToken { result in
            switch result {
            case .success(let token):
                print(token)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
