//
//  Dequeuable.swift
//  TransformersApp
//
//  Created by Alonso on 12/4/20.
//

import UIKit

protocol Dequeuable {

    static var dequeuIdentifier: String { get }

}

extension Dequeuable where Self: UIView {

    static var dequeuIdentifier: String {
        return String(describing: self)
    }

}

extension UITableViewCell: Dequeuable { }
