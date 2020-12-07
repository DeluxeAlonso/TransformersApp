//
//  TransformersViewState.swift
//  TransformersApp
//
//  Created by Alonso on 12/4/20.
//

import Foundation

enum TransformersViewState: Equatable {

    case loading
    case empty
    case populated
    case error(Error)

    static func == (lhs: TransformersViewState, rhs: TransformersViewState) -> Bool {
            switch (lhs, rhs) {
            case (.populated, .populated):
                return true
            case (.loading, .loading):
                return true
            case (.empty, .empty):
                return true
            case (.error, .error):
                return true
            default:
                return false
            }
    }

}
