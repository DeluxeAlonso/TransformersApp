//
//  UIRefreshControl+EndRefreshing.swift
//  TransformersApp
//
//  Created by Alonso on 12/7/20.
//

import UIKit

extension UIRefreshControl {

    func endRefreshing(with delay: TimeInterval = 0.5) {
        if isRefreshing {
            perform(#selector(UIRefreshControl.endRefreshing), with: nil, afterDelay: delay)
        }
    }

}
