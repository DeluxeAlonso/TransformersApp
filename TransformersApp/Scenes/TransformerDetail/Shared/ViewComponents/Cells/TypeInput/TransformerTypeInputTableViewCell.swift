//
//  TransformerTypeInputTableViewCell.swift
//  TransformersApp
//
//  Created by Alonso on 12/6/20.
//

import UIKit

class TransformerTypeInputTableViewCell: UITableViewCell {

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    lazy var autobotButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.gray.cgColor
        button.setImage(UIImage(named: "Autobot"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(autobotButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)

        return button
    }()

    lazy var decepticonButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.gray.cgColor
        button.setImage(UIImage(named: "Decepticon"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(decepticonButtonAction), for: .touchUpInside)
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)

        return button
    }()

    var viewModel: TransformerTypeInputCellViewModelProtocol? {
        didSet {
            setupBindings()
        }
    }

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        autobotButton.isUserInteractionEnabled = isEditing
        decepticonButton.isUserInteractionEnabled = isEditing

        guard let viewModel = viewModel, let team = viewModel.value else { return }
        handleEditingMode(for: team, editing: editing, animated: true)
    }

    // MARK: - Private

    private func setupUI() {
        contentView.addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 8, left: 8, bottom: 8, right: 8))

        let buttonHeight: CGFloat
        if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular {
            buttonHeight = Constants.RegularWidthRegularHeightButtonHeight
        } else {
            buttonHeight = Constants.CompactButtonHeight
        }

        let autobotButtonHeightConstraint = autobotButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        let decepticonButtonHeightConstraint = decepticonButton.heightAnchor.constraint(equalToConstant: buttonHeight)

        // Add a 999 priority to supress width constraint warning.
        autobotButtonHeightConstraint.priority = .init(999)
        decepticonButtonHeightConstraint.priority = .init(999)

        autobotButtonHeightConstraint.isActive = true
        decepticonButtonHeightConstraint.isActive = true

        stackView.addArrangedSubview(autobotButton)
        stackView.addArrangedSubview(decepticonButton)
    }

    private func showBothButtons() {
        autobotButton.isHidden = false
        decepticonButton.isHidden = false

        guard let viewModel = viewModel, let team = viewModel.value else {
            return
        }
        if team == .autobot {
            hightlightAutobotTeam()
        } else {
            hightlightDecepticonTeam()
        }
    }

    private func handleEditingMode(for selectedTeam: TransformerType,
                                   editing: Bool, animated: Bool) {
        let animationDuration = animated ? 0.35 : 0
        UIView.animate(withDuration: animationDuration) { [unowned self] in
            if editing {
                showBothButtons()
            } else {
                self.decepticonButton.isHidden = selectedTeam == .autobot
                self.autobotButton.isHidden = selectedTeam == .decepticon
                self.stopHighlight()
            }
            self.stackView.layoutIfNeeded()
        }
    }

    // MARK: - Buttons selection

    private func selectAutobotTeam() {
        hightlightAutobotTeam()
        viewModel?.value = .autobot
    }

    private func selectDecepticonTeam() {
        hightlightDecepticonTeam()
        viewModel?.value = .decepticon
    }

    // MARK: - Buttons Hightlight

    private func hightlightAutobotTeam() {
        autobotButton.layer.borderWidth = 1
        decepticonButton.layer.borderWidth = 0
    }

    private func hightlightDecepticonTeam() {
        decepticonButton.layer.borderWidth = 1
        autobotButton.layer.borderWidth = 0
    }

    private func stopHighlight() {
        decepticonButton.layer.borderWidth = 0
        autobotButton.layer.borderWidth = 0
    }

    // MARK: - Reactive Behavior

    private func setupBindings() {
        guard let viewModel = viewModel, let team = viewModel.value else {
            showBothButtons()
            return
        }
        handleEditingMode(for: team, editing: isEditing, animated: false)
    }

    // MARK: - Actions

    @objc func autobotButtonAction() {
        selectAutobotTeam()
    }

    @objc func decepticonButtonAction() {
        selectDecepticonTeam()
    }

}

extension TransformerTypeInputTableViewCell {

    struct Constants {
        static let RegularWidthRegularHeightButtonHeight: CGFloat = 80.0
        static let CompactButtonHeight: CGFloat = 64.0
    }

}
