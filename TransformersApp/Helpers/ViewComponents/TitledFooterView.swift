//
//  TitledFooterView.swift
//  TransformersApp
//
//  Created by Alonso on 12/4/20.
//

import UIKit

class TitledFooterView: UIView {

    static let recommendedFrame: CGRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100)

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = FontHelper.Default.mediumLight
        label.textAlignment = .center
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Public

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    // MARK: - Initializers

    init(title: String) {
        super.init(frame: TitledFooterView.recommendedFrame)
        setupUI()
        titleLabel.text = title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    // MARK: - Private

    fileprivate func setupUI() {
        addSubview(titleLabel)
        titleLabel.fillSuperview(padding: .init(top: 0, left: Constants.horizontalMargin,
                                                bottom: 0, right: Constants.horizontalMargin))
    }

    // MARK: - Constants

    struct Constants {
        static let horizontalMargin: CGFloat = 8.0
    }

}
