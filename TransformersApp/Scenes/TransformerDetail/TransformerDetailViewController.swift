//
//  TransformerDetailViewController.swift
//  TransformersApp
//
//  Created by Alonso on 12/6/20.
//

import UIKit

class TransformerDetailViewController: UIViewController {

    private var viewModel: TransformerDetailViewModelProtocol
    weak var coordinator: TransformerDetailCoordinatorProtocol?

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
        view.backgroundColor = .red
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
