//
//  AuthClientProtocol.swift
//  TransformersApp
//
//  Created by Alonso on 12/4/20.
//

import Foundation

protocol AuthClientProtocol {

    func getAccessToken(completion: @escaping (Result<AccessTokenResult, APIError>) -> Void)

}
