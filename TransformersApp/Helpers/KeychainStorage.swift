//
//  KeychainStorage.swift
//  TransformersApp
//
//  Created by Alonso on 12/4/20.
//

import KeychainSwift

@propertyWrapper
struct KeychainStorage {

    private let key: String
    private lazy var keychain = KeychainSwift()

    init(key: String) {
        self.key = key
    }

    var wrappedValue: String? {
        mutating get {
            return keychain.get(key)
        }
        set {
            if let newValue = newValue {
                keychain.set(newValue, forKey: key)
            } else {
                keychain.delete(key)
            }
        }
    }

}
