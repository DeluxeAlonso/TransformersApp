//
//  Localizable.swift
//  TransformersApp
//
//  Created by Alonso on 12/5/20.
//

protocol Localizable {

    var tableName: String { get }
    var localized: String { get }

}

extension Localizable where Self: RawRepresentable, Self.RawValue == String {

    var localized: String {
        return rawValue.localized(tableName: tableName)
    }

}
