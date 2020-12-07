//
//  TransformerDetailViewController.swift
//  TransformersApp
//
//  Created by Alonso on 12/6/20.
//

import UIKit

class TransformerDetailViewController: UIViewController, Alertable {

    lazy var saveBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self,
                                            action: #selector(saveButtonAction))
        return barButtonItem
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.allowsSelection = false
        tableView.keyboardDismissMode = .onDrag
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private var viewModel: TransformerDetailViewModelProtocol
    weak var coordinator: TransformerDetailCoordinatorProtocol?

    var showCloseButton: Bool = false

    // MARK: - Initializers

    init(viewModel: TransformerDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }

    // MARK: - Private

    private func setupUI() {
        title = LocalizedStrings.transformersTitle.localized
        view.backgroundColor = ColorPalette.defaulBackgroundColor
        
        setupNavigationBar()
        setupTableView()
    }

    private func setupNavigationBar() {
        let allowEditing = viewModel.shouldAllowEditing()
        navigationItem.rightBarButtonItems = allowEditing ? [saveBarButtonItem, editButtonItem] : [saveBarButtonItem]

        if showCloseButton {
            let closeBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self,
                                                     action: #selector(closeButtonAction))
            navigationItem.leftBarButtonItem = closeBarButtonItem
        }
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.fillSuperview()

        tableView.register(cellType: TransformerTextInputTableViewCell.self)
        tableView.register(cellType: TransformerValueInputTableViewCell.self)
        tableView.register(cellType: TransformerTypeInputTableViewCell.self)

        tableView.dataSource = self
        tableView.delegate = self

        tableView.setEditing(viewModel.shouldStartOnEditMode(), animated: false)
    }

    private func showActivityIndicator() {
        let indicator: UIActivityIndicatorView
        if #available(iOS 13.0, *) {
            indicator = UIActivityIndicatorView(style: .medium)
        } else {
            indicator = UIActivityIndicatorView(style: .gray)
        }
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: indicator)
    }

    private func hideActivityIndicator() {
        navigationItem.rightBarButtonItem = saveBarButtonItem
    }

    // MARK: - Reactive Behavior

    private func setupBindings() {
        viewModel.savedTransformer.bind { [weak self] savedTransformer in
            guard let strongSelf = self, let savedTransformer = savedTransformer else { return }
            strongSelf.coordinator?.close(with: savedTransformer)
        }

        viewModel.startLoading.bind { [weak self] loading in
            guard let strongSelf = self else { return }
            loading ? strongSelf.showActivityIndicator() : strongSelf.hideActivityIndicator()
        }

        viewModel.receivedErrorMessage.bind { [weak self] errorMessage in
            guard let strongSelf = self, let errorMessage = errorMessage else { return }
            strongSelf.showAlert(title: LocalizedStrings.errorAlertTitle.localized,
                                 message: errorMessage)
        }
    }

    // MARK: - Actions

    @objc func saveButtonAction() {
        viewModel.saveTransformer()
    }

    @objc func closeButtonAction() {
        coordinator?.close()
    }

}

// MARK: - UITableViewDataSource

extension TransformerDetailViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.formSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = viewModel.formSections[section]
        switch section {
        case .name(let inputs):
            return inputs.count
        case .value(let inputs):
            return inputs.count
        case .type(let inputs):
            return inputs.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let inputs = viewModel.input(for: indexPath.section, at: indexPath.row)
        switch inputs.type {
        case .text:
            let cell = tableView.dequeueReusableCell(with: TransformerTextInputTableViewCell.self, for: indexPath)
            cell.viewModel = viewModel.textInputModel(for: inputs.identifier)
            return cell
        case .value:
            let cell = tableView.dequeueReusableCell(with: TransformerValueInputTableViewCell.self, for: indexPath)
            cell.viewModel = viewModel.valueInputModel(for: inputs.identifier)
            return cell
        case .type:
            let cell = tableView.dequeueReusableCell(with: TransformerTypeInputTableViewCell.self, for: indexPath)
            cell.viewModel = viewModel.typeInputModel(for: inputs.identifier)
            return cell
        }
    }

}

// MARK: - UITableViewDelegate

extension TransformerDetailViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .none
    }

    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        false
    }

}
