//
//  TransformersProtocols.swift
//  TransformersApp
//
//  Created by Alonso on 12/3/20.
//

import Foundation

protocol TransformersViewModelProtocol {

    func getTransformers()
    
}

protocol TransformersInteractorProtocol {

    func getToken(completion: @escaping (Result<String, Error>) -> Void)

}
