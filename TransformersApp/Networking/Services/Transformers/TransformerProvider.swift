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
    case updateTransformer(accessToken: String, params: [String: Any])

}

extension TransformerProvider: Endpoint {
    var base: String {
        return "https://transformers-api.firebaseapp.com"
    }

    var path: String {
        switch self {
        case .getTransformers, .updateTransformer:
            return "/transformers"
        case .deleteTransformer(_, let id):
            return "/transformers/\(id)"
        }
    }

    var headers: [String : String]? {
        switch self {
        case .getTransformers(let accessToken),
             .deleteTransformer(let accessToken, _),
             .updateTransformer(let accessToken, _):
            return ["Authorization": "Bearer \(accessToken)"]
        }
    }

    var params: [String : Any]? {
        switch self {
        case .getTransformers, .deleteTransformer:
            return nil
        case .updateTransformer(_, let params):
            return params
        }
    }

    var parameterEncoding: ParameterEnconding {
        switch self {
        case .getTransformers, .deleteTransformer:
            return .defaultEncoding
        case .updateTransformer:
            return .jsonEncoding
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getTransformers:
            return .get
        case .deleteTransformer:
            return .delete
        case .updateTransformer:
            return .put
        }
    }

}
