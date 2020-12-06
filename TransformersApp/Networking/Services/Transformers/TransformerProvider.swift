//
//  TransformerProvider.swift
//  TransformersApp
//
//  Created by Alonso on 12/4/20.
//

import Foundation

enum TransformerProvider {

    case getTransformers(accessToken: String)
    case deleteTransformer(accessToken: String, transformerId: String)

}

extension TransformerProvider: Endpoint {
    var base: String {
        return "https://transformers-api.firebaseapp.com"
    }

    var path: String {
        switch self {
        case .getTransformers:
            return "/transformers"
        case .deleteTransformer(_, let id):
            return "/transformers/\(id)"
        }
    }

    var headers: [String : String]? {
        switch self {
        case .getTransformers(let accessToken), .deleteTransformer(let accessToken, _):
            return ["Authorization": "Bearer \(accessToken)"]
        }
    }

    var params: [String : Any]? {
        switch self {
        case .getTransformers, .deleteTransformer:
            return nil
        }
    }

    var parameterEncoding: ParameterEnconding {
        switch self {
        case .getTransformers, .deleteTransformer:
            return .defaultEncoding
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getTransformers:
            return .get
        case .deleteTransformer:
            return .delete
        }
    }

}
