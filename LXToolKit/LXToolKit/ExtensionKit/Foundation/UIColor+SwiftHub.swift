//
//  UIColor+SwiftHub.swift
//  SwiftHub
//
//  Created by Khoren Markosyan on 1/4/17.
//  Copyright © 2017 Khoren Markosyan. All rights reserved.
//

import UIKit

// MARK: Colors

public extension UIColor {

    static func primary() -> UIColor {
        // return themeService.type.associatedObject.primary
        return UIColor.random
    }

    static func primaryDark() -> UIColor {
        // return themeService.type.associatedObject.primaryDark
        return UIColor.random
    }

    static func secondary() -> UIColor {
        // return themeService.type.associatedObject.secondary
        return UIColor.random
    }

    static func secondaryDark() -> UIColor {
        // return themeService.type.associatedObject.secondaryDark
        return UIColor.random
    }

    static func separator() -> UIColor {
        // return themeService.type.associatedObject.separator
        return UIColor.random
    }

    static func text() -> UIColor {
        // return themeService.type.associatedObject.text
        return UIColor.random
    }
}

extension UIColor {

    var brightnessAdjustedColor: UIColor {
        var components = self.cgColor.components
        let alpha = components?.last
        components?.removeLast()
        let color = CGFloat(1-(components?.max())! >= 0.5 ? 1.0 : 0.0)
        return UIColor(red: color, green: color, blue: color, alpha: alpha!)
    }
}
