//
//  AuthProvider.swift
//  TransformersApp
//
//  Created by Alonso on 12/3/20.
//

import Foundation

enum AuthProvider {

    case getToken

}

extension AuthProvider: Endpoint {
    var base: String {
        return "https://transformers-api.firebaseapp.com"
    }

    var path: String {
        switch self {
        case .getToken:
            return "/allspark"
        }
    }

    var headers: [String : String]? {
        switch self {
        case .getToken:
            return nil
        }

    }

    var params: [String : Any]? {
        switch self {
        case .getToken:
            return nil
        }
    }

    var parameterEncoding: ParameterEnconding {
        switch self {
        case .getToken:
            return .defaultEncoding
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getToken:
            return .get
        }
    }

}
