//
//  SecureStorageProtocol.swift
//  TransformersApp
//
//  Created by Alonso on 12/4/20.
//

import Foundation

protocol SecureStorageProtocol {

    func getAccessToken() -> String?
    func setAccessToken(_ token: String)
    func deleteAccessToken()

}
