//
//  TransformerTextInputTableViewCell.swift
//  TransformersApp
//
//  Created by Alonso on 12/6/20.
//

import UIKit

class TransformerTextInputTableViewCell: UITableViewCell {

    lazy var textfield: UITextField = {
        let textField = UITextField()

        return textField
    }()

    var viewModel: TransformerTextCellViewModelProtocol? {
        didSet {
            setupBindings()
        }
    }

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(textfield)
        textfield.fillSuperview(padding: .init(top: 8, left: 16, bottom: 8, right: 16))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        textfield.isUserInteractionEnabled = editing
        textfield.resignFirstResponder()
    }

    private func setupBindings() {
        textfield.text = viewModel?.value
        textfield.placeholder = viewModel?.placeholderTitle
    }

}
