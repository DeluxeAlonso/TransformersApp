//
//  TransformersViewController.swift
//  TransformersApp
//
//  Created by Alonso on 12/3/20.
//

import UIKit

class TransformersViewController: UIViewController, Alertable {

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private let viewModel: TransformersViewModelProtocol
    weak var coordinator: TransformersCoordinatorProtocol?

    // MARK: - Initializers

    init(viewModel: TransformersViewModelProtocol) {
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

        viewModel.getTransformers()
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
        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self,
                                               action: #selector(addButtonAction))
        addBarButtonItem.accessibilityIdentifier = Accesibility.addBarButtonId

        let warBarButtonItem =  UIBarButtonItem(barButtonSystemItem: .compose, target: self,
                                                action: #selector(warButtonAction))
        warBarButtonItem.accessibilityIdentifier = Accesibility.warBarButtonId

        navigationItem.rightBarButtonItems = [addBarButtonItem, warBarButtonItem]
        navigationItem.leftBarButtonItem = editButtonItem
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.fillSuperview()

        tableView.register(cellType: TransformerTableViewCell.self)

        tableView.dataSource = self
        tableView.delegate = self

        tableView.tableFooterView = LoadingFooterView()

        setupRefreshControl()
    }

    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    private func configureView(with state: TransformersViewState) {
        switch state {
        case .empty:
            tableView.tableFooterView = TitledFooterView(title: LocalizedStrings.emptyTransformersTitle.localized)
        case .populated:
            tableView.tableFooterView = UIView()
        case .loading:
            tableView.tableFooterView = LoadingFooterView()
        case .error(let error):
            tableView.tableFooterView = TitledFooterView(title: error.localizedDescription)
        }
    }

    // MARK: - Reactive Behavior

    private func setupBindings() {
        viewModel.viewState.bind { [weak self] state in
            guard let strongSelf = self else { return }
            strongSelf.configureView(with: state)
            strongSelf.tableView.reloadSections([.zero], with: .fade)
            strongSelf.tableView.refreshControl?.endRefreshing()
        }

        viewModel.receivedWarResultMessage.bind { [weak self] errorMessage in
            guard let strongSelf = self, let errorMessage = errorMessage else { return }
            strongSelf.showAlert(title: LocalizedStrings.warResultTItle.localized,
                                 message: errorMessage)
        }

        viewModel.receivedErrorMessage.bind { [weak self] errorMessage in
            guard let strongSelf = self, let errorMessage = errorMessage else { return }
            strongSelf.tableView.refreshControl?.endRefreshing()
            strongSelf.showAlert(title: LocalizedStrings.errorAlertTitle.localized,
                                 message: errorMessage)
        }
    }

    // MARK: - Actions

    @objc func addButtonAction() {
        coordinator?.showTransformerAddForm()
    }

    @objc func warButtonAction() {
        viewModel.startWar()
    }

    @objc func refreshControlAction() {
        viewModel.getTransformers()
    }

}

// MARK: - UITableViewDataSource

extension TransformersViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.transformerCells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: TransformerTableViewCell.self, for: indexPath)
        cell.viewModel = viewModel.transformerCells[indexPath.row]

        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeTransformer(at: indexPath.row)
        }
    }

}

// MARK: - UITableViewDelegate

extension TransformersViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let transformerToEdit = viewModel.transformer(at: indexPath.row)
        coordinator?.showTransformerEditForm(for: transformerToEdit)
    }

}

// MARK: - TransformersUpdateDelegate

extension TransformersViewController: TransformersUpdateDelegate {

    func didCreateOrUpdateNewTransformer(transformer: Transformer) {
        viewModel.updateTransformerList(with: transformer)
    }

}

extension TransformersViewController{
    struct Accesibility {
        static let addBarButtonId = "addBarButtonItem"
        static let warBarButtonId = "warBarButtonItem"
    }
}
