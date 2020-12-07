//
//  TransformerDetailProtocols.swift
//  TransformersApp
//
//  Created by Alonso on 12/6/20.
//

import Foundation

protocol TransformerDetailViewModelProtocol {

    var formSections: [TransformerFormSection] { get }

    func textInputModel(for form: TransformerFormProtocol) -> TransformerTextCellViewModelProtocol
    func valueInputModel(for form: TransformerFormProtocol) -> TransformerValueCellViewModelProtocol
    func typeInputFormModel(for form: TransformerFormProtocol) -> TransformerTypeCellViewModelProtocol

    func form(for section: Int, at index: Int) -> TransformerFormProtocol

    func shouldAllowEditing() -> Bool


}

protocol TransformerDetailCoordinatorProtocol: class {
    
}
