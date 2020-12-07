//
//  SecureStorageProtocol.swift
//  TransformersApp
//
//  Created by Alonso on 12/4/20.
//

import Foundation

protocol SecureStorageProtocol {

    /**
     Retrieves the current access token.

     - Returns: Securely stored access token.
     */
    func getAccessToken() -> String?
    
    /**
     Securely save a new access token.

     - Parameter token: Access token to be securely saved.
     */
    func setAccessToken(_ token: String)

    /**
     Deletes a securely stored access token.
     */
    func deleteAccessToken()

}
