//
//  TransformerTextInputForm.swift
//  TransformersApp
//
//  Created by Alonso on 12/6/20.
//

import Foundation

struct NameTextInputForm: TransformerFormProtocol {

    var identifier: TransformerInputIdentifier = .name

    var type: TransformerFormType = .text(placeholder: "Name")

}
