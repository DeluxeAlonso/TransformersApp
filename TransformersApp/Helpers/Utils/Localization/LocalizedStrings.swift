//
//  LocalizedStrings.swift
//  TransformersApp
//
//  Created by Alonso on 12/5/20.
//

import Foundation

enum LocalizedStrings: String, Localizable {

    case name
    case strength
    case intelligence
    case speed
    case endurance
    case rank
    case courage
    case firepower
    case skill
    case team

    case transformersTitle
    case emptyTransformersTitle

    case emptyInputsTitle

    case errorAlertTitle

    case warResultTItle

    var tableName: String {
        return "Localizable"
    }

}
