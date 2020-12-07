//
//  TransformerTableViewCell.swift
//  TransformersApp
//
//  Created by Alonso on 12/4/20.
//

import UIKit

class TransformerTableViewCell: UITableViewCell {

    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView: UIActivityIndicatorView
        if #available(iOS 13.0, *) {
            activityIndicatorView = UIActivityIndicatorView(style: .medium)
        } else {
            activityIndicatorView = UIActivityIndicatorView(style: .gray)
        }
        activityIndicatorView.color = .darkGray
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }()

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = FontHelper.Default.mediumLight
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var ratingLabel: UILabel = {
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
        let iconHeight: CGFloat

        if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular {
            iconHeight = Constants.RegularWidthRegularHeightIconHeight
        } else {
            iconHeight = Constants.CompactIconHeight
        }
        contentView.addSubview(iconImageView)
        NSLayoutConstraint.activate(
            [
                iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                iconImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 16),
                iconImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: 16),
                iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor),
                iconImageView.heightAnchor.constraint(equalToConstant: iconHeight)
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

    private func configureUI(with state: TransformerCellState) {
        switch state {
        case .regular:
            accessoryView = nil
            editingAccessoryView = nil

            accessoryType = .disclosureIndicator
            editingAccessoryType = .disclosureIndicator
        case .loading:
            accessoryView = activityIndicatorView
            editingAccessoryView = activityIndicatorView
        }
    }

    // MARK: - Reactive Behavior

    private func setupBindings() {
        guard let viewModel = viewModel else { return }
        
        nameLabel.text = viewModel.name
        ratingLabel.text = viewModel.rating
        iconImageView.image = UIImage(named: viewModel.iconName)

        viewModel.state.bindAndFire { [weak self] state in
            guard let strongSelf = self else { return }
            strongSelf.configureUI(with: state)
        }
    }

}

extension TransformerTableViewCell {

    struct Constants {
        static let RegularWidthRegularHeightIconHeight: CGFloat = 64
        static let CompactIconHeight: CGFloat = 36
    }

}
