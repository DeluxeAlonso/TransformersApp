//
//  TransformerValueInputTableViewCell.swift
//  TransformersApp
//
//  Created by Alonso on 12/6/20.
//

import UIKit

class TransformerValueInputTableViewCell: UITableViewCell {

    lazy var stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.addTarget(self, action: #selector(stepperValueDidChange),
                          for: .valueChanged)
        stepper.autorepeat = false
        stepper.minimumValue = 1
        stepper.maximumValue = 10
        return stepper
    }()

    var viewModel: TransformerValueInputCellViewModelProtocol? {
        didSet {
            setupBindings()
        }
    }

    // MARK: - Initilializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        editingAccessoryView = stepper
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Reactive Behavior

    private func setupBindings() {
        guard let viewModel = viewModel else { return }
        textLabel?.text = viewModel.inputTitle
        detailTextLabel?.text = "\(viewModel.value)"
        stepper.value = Double(viewModel.value)
    }

    // MARK: - Actions

    @objc func stepperValueDidChange() {
        let value = Int(stepper.value)
        viewModel?.value = value
        detailTextLabel?.text = "\(value)"
    }

}
