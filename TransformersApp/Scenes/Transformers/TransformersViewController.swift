//
//  TransformersViewController.swift
//  TransformersApp
//
//  Created by Alonso on 12/3/20.
//

import UIKit

class TransformersViewController: UIViewController {

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private let viewModel: TransformersViewModelProtocol

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

    // MARK: - Private

    private func setupUI() {
        setupTableView()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.fillSuperview()

        tableView.register(cellType: TransformerTableViewCell.self)

        tableView.dataSource = self
        tableView.delegate = self
    }

    private func configureView(with state: TransformersViewState) {
        switch state {
        case .empty:
            tableView.tableFooterView = TitledFooterView(title: "Empty")
        case .populated:
            tableView.tableFooterView = UIView()
        case .initial, .loading:
            tableView.tableFooterView = LoadingFooterView()
        case .error(let error):
            tableView.tableFooterView = TitledFooterView(title: error.description)
        }
    }

    // MARK: - Reactive Behavior

    private func setupBindings() {
        viewModel.viewState.bindAndFire { [weak self] state in
            guard let strongSelf = self else { return }
            strongSelf.configureView(with: state)
            strongSelf.tableView.reloadData()
        }
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

}

// MARK: - UITableViewDelegate

extension TransformersViewController: UITableViewDelegate {

}
