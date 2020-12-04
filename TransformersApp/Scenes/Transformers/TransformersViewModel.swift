//
//  TransformersViewModel.swift
//  TransformersApp
//
//  Created by Alonso on 12/3/20.
//

import Foundation

struct TransformersViewModel: TransformersViewModelProtocol {

    private let interactor: TransformersInteractorProtocol

    init(interactor: TransformersInteractorProtocol) {
        self.interactor = interactor
    }

    func getTransformers() {
        interactor.getToken { result in
            switch result {
            case .success(let token):
                print(token)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
