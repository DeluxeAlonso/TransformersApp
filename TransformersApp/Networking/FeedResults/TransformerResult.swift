//
//  TransformerResult.swift
//  TransformersApp
//
//  Created by Alonso on 12/6/20.
//

import Foundation

struct TransformerResult: Decodable {

    let transformer: Transformer

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.transformer = try container.decode(Transformer.self)
    }

}
