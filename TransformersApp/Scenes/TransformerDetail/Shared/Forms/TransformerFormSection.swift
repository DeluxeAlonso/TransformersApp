//
//  TransformerFormSection.swift
//  TransformersApp
//
//  Created by Alonso on 12/6/20.
//

import Foundation

enum TransformerFormSection {
    
    case name(inputs: [TransformerInputProtocol])
    case type(inputs: [TransformerInputProtocol])
    case value(inputs: [TransformerInputProtocol])

}
