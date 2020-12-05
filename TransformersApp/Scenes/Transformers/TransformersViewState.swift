//
//  TransformersViewState.swift
//  TransformersApp
//
//  Created by Alonso on 12/4/20.
//

import Foundation

enum TransformersViewState {

    case initial
    case loading
    case empty
    case populated([Transformer])
    case error(ErrorDescriptable)

    var currentTransformers: [Transformer] {
        switch self {
        case .populated(let transformers):
            return transformers
        case .empty, .error, .initial, .loading:
            return []
        }
    }

}
