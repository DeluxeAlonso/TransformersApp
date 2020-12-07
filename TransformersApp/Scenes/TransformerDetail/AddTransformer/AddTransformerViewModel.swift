//
//  AddTransformerViewModel.swift
//  TransformersApp
//
//  Created by Alonso on 12/6/20.
//

import Foundation

class AddTransformerViewModel: TransformerDetailViewModelProtocol {

    func textInputModel(for form: TransformerFormProtocol) -> TransformerTextCellViewModelProtocol {
        fatalError()
    }

    func valueInputModel(for form: TransformerFormProtocol) -> TransformerValueCellViewModelProtocol {
        fatalError()
    }

    func typeInputFormModel(for form: TransformerFormProtocol) -> TransformerTypeCellViewModelProtocol {
        fatalError()
    }

    func form(for section: Int, at index: Int) -> TransformerFormProtocol {
        fatalError()
    }


    var formSections: [TransformerFormSection] = []



    func shouldAllowEditing() -> Bool {
        return false
    }

}
