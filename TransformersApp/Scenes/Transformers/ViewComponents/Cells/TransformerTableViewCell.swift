//
//  TransformerTableViewCell.swift
//  TransformersApp
//
//  Created by Alonso on 12/4/20.
//

import UIKit

class TransformerTableViewCell: UITableViewCell {

    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = FontHelper.Default.mediumLight
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = FontHelper.Default.mediumBold
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    var viewModel: TransformerCellViewModelProtocol? {
        didSet {
            setupBindings()
        }
    }

    // MARK: - Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        ratingLabel.text = nil
        iconImageView.image = nil
    }

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private

    private func setupUI() {
        accessoryType = .disclosureIndicator

        contentView.addSubview(iconImageView)
        NSLayoutConstraint.activate(
            [
                iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                iconImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 16),
                iconImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: 16),
                iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor),
                iconImageView.heightAnchor.constraint(equalToConstant: 36.0)
            ]
        )

        contentView.addSubview(ratingLabel)
        NSLayoutConstraint.activate(
            [
                ratingLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                ratingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                ratingLabel.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 16),
                ratingLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: 16),
                ratingLabel.widthAnchor.constraint(equalToConstant: 36.0)
            ]
        )

        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate(
            [
                nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 24),
                nameLabel.trailingAnchor.constraint(equalTo: ratingLabel.leadingAnchor, constant: -24),
                nameLabel.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 16),
                nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: 16)
            ]
        )
    }

    // MARK: - Reactive Behavior

    private func setupBindings() {
        guard let viewModel = viewModel else { return }
        
        nameLabel.text = viewModel.name
        ratingLabel.text = viewModel.rating
        iconImageView.image = UIImage(named: viewModel.iconName)
    }

}
