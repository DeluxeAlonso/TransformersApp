//
//  TransformerAddViewModel.swift
//  TransformersApp
//
//  Created by Alonso on 12/6/20.
//

import Foundation

class AddTransformerViewModel: TransformerDetailViewModelProtocol {

    var formSections: [TransformerFormSection] = []

    func textInputForm(at index: Int) -> [TransformerFormCellViewModelProtocol] {
        return []
    }

    func valueInputForm(at index: Int) -> [TransformerFormCellViewModelProtocol] {
        return []
    }

    func typeInputForm(at index: Int) -> [TransformerFormCellViewModelProtocol] {
        return []
    }

    func shouldAllowEditing() -> Bool {
        return false
    }

}
