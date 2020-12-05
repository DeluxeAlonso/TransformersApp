//
//  SecureStorage.swift
//  TransformersApp
//
//  Created by Alonso on 12/4/20.
//

import Foundation

class SecureStorage: SecureStorageProtocol {

    static let shared = SecureStorage()

    @KeychainStorage(key: Constants.accessTokenKey)
    private var token: String?

    init() {}

    // MARK: - SecureStorageProtocol

    func getAccessToken() -> String? {
        print(token)
        return token
    }

    func setAccessToken(_ token: String) {
        self.token = token
    }

    func deleteAccessToken() {
        token = nil
    }

}

extension SecureStorage {

    struct Constants {
        static let accessTokenKey = "TransformerAppAccessToken"
    }

}
