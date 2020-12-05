//
//  TransformerTableViewCell.swift
//  TransformersApp
//
//  Created by Alonso on 12/4/20.
//

import UIKit

class TransformerTableViewCell: UITableViewCell {

    var viewModel: TransformerCellViewModelProtocol? {
        didSet {
            setupBindings()
        }
    }

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Reactive Behavior

    private func setupBindings() {
        guard let viewModel = viewModel else { return }
        
        textLabel?.text = viewModel.rating
        detailTextLabel?.text = viewModel.rating
        imageView?.image = UIImage(named: viewModel.iconName)
    }

}
