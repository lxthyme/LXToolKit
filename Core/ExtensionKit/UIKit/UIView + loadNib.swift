//
//  UITableviewCell + loadNib.swift
//  Alamofire
//
//  Created by LXThyme Jason on 2020/8/11.
//

import Foundation

// MARK: - <#Title...#>
extension UIView {
    static func nib() -> UINib {
        return UINib(nibName: NSStringFromClass(self), bundle: Bundle.main)
    }
}

extension UIViewController {
    static func nib() -> UINib {
        return UINib(nibName: NSStringFromClass(self), bundle: Bundle.main)
    }
}
