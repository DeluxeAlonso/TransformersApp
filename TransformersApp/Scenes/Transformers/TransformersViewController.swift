//
//  TransformersViewController.swift
//  TransformersApp
//
//  Created by Alonso on 12/3/20.
//

import UIKit

class TransformersViewController: UIViewController {

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

        viewModel.getTransformers()
    }

    // MARK: - Private



}
