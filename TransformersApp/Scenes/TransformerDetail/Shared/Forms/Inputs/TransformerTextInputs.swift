//
//  TransformerTextInputs.swift
//  TransformersApp
//
//  Created by Alonso on 12/6/20.
//

import Foundation

struct NameTextInput: TransformerInputProtocol {

    var identifier: TransformerInputIdentifier = .name

    var type: TransformerInputType = .text(placeholder: "Name")

}
