//
//  KeychainManager.swift
//  TransformersApp
//
//  Created by Alonso on 12/4/20.
//

import Foundation

class KeychainManager {

    static let shared = KeychainManager()

    @KeychainStorage(key: Constants.accessTokenKey)
    var token: String?

    // MARK: - Initializers

    init() {}

}

extension KeychainManager {

    struct Constants {
        static let accessTokenKey = "TransformerAppAccessToken"
    }

}
