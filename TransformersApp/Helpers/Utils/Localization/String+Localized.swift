//
//  String+Localized.swift
//  TransformersApp
//
//  Created by Alonso on 12/5/20.
//

import Foundation

extension String {

    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self,
                                 tableName: tableName,
                                 value: self,
                                 comment: "")
    }

}
