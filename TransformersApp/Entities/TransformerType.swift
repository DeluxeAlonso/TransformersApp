//
//  TransformerType.swift
//  TransformersApp
//
//  Created by Alonso on 12/4/20.
//

enum TransformerType: String, Codable {

    case autobot = "A"
    case decepticon = "D"

    var iconName: String {
        switch self {
        case .autobot:
            return "Autobot"
        case .decepticon:
            return "Decepticon"
        }
    }

}
