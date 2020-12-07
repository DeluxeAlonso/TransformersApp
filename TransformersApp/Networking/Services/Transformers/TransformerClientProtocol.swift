//
//  TransformerClientProtocol.swift
//  TransformersApp
//
//  Created by Alonso on 12/4/20.
//

import Foundation

protocol TransformerClientProtocol {

    func getTransformers(accessToken: String,
                         completion: @escaping (Result<TransformersResult, APIError>) -> Void)

    func deleteTransformer(with id: String, accessToken: String,
                           completion: @escaping (Result<EmptyResult, APIError>) -> Void)

    func updateTransformer(with params: [String: Any], accessToken: String,
                           completion: @escaping (Result<TransformerResult, APIError>) -> Void)
    
}
