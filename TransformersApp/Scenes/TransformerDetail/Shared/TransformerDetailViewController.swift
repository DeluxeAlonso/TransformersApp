//
//  TransformerDetailViewController.swift
//  TransformersApp
//
//  Created by Alonso on 12/6/20.
//

import UIKit

class TransformerDetailViewController: UIViewController, Alertable {

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
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        title = LocalizedStrings.transformersTitle.localized
        setupNavigationBar()
        setupTableView()
    }

    private func setupNavigationBar() {
        let saveBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self,
                                               action: #selector(saveButtonAction))
        if viewModel.shouldAllowEditing() {
            navigationItem.rightBarButtonItems = [saveBarButtonItem, editButtonItem]
        } else {
            navigationItem.rightBarButtonItems = [saveBarButtonItem]
        }

        tableView.setEditing(viewModel.shouldStartOnEditMode(), animated: false)

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

        tableView.dataSource = self
        tableView.delegate = self
    }

    // MARK: - Reactive Behavior

    private func setupBindings() {
        viewModel.savedTransformer.bind { [weak self] savedTransformer in
            guard let strongSelf = self else { return }
            strongSelf.coordinator?.close()
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
        case .name(let forms):
            return forms.count
        case .value(let forms):
            return forms.count
        case .type(let forms):
            return forms.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let form = viewModel.form(for: indexPath.section, at: indexPath.row)
        switch form.type {
        case .text:
            let cell = tableView.dequeueReusableCell(with: TransformerTextInputTableViewCell.self, for: indexPath)
            cell.viewModel = viewModel.textInputModel(for: form)
            return cell
        case .value:
            let cell = tableView.dequeueReusableCell(with: TransformerValueInputTableViewCell.self, for: indexPath)
            cell.viewModel = viewModel.valueInputModel(for: form)
            return cell
        case .type:
            fatalError()
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
