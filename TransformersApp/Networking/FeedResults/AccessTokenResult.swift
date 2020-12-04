//
//  AccessTokenResult.swift
//  TransformersApp
//
//  Created by Alonso on 12/3/20.
//

import Foundation

struct AccessTokenResult: Decodable {

    let token: String

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.token = try container.decode(String.self)
    }

}
