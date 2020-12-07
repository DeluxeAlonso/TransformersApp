//
//  ColorPalette.swift
//  TransformersApp
//
//  Created by Alonso on 12/7/20.
//

import UIKit

extension UIColor {

    convenience init(withIntRed red: Int, green: Int, blue: Int, alpha: CGFloat) {

        let floatRed = CGFloat(red)/255
        let floatGreen = CGFloat(green)/255
        let floatBlue = CGFloat(blue)/255

        self.init(red: floatRed, green: floatGreen, blue: floatBlue, alpha: alpha)
    }

}

struct ColorPalette {

    static var defaulBackgroundColor: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemBackground
        } else {
            return .white
        }
    }

    struct Label {
        static var defaultColor: UIColor {
            if #available(iOS 13.0, *) {
                return UIColor.label
            } else {
                return .black
            }
        }
    }

}
