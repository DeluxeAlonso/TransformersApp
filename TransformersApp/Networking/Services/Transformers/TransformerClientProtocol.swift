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
    
}
