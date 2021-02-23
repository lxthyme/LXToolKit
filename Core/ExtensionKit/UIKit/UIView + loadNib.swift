//
//  UITableviewCell + loadNib.swift
//  Alamofire
//
//  Created by LXThyme Jason on 2020/8/11.
//

import Foundation

// MARK: - 👀
public extension Swifty where Base: UIView {
    static func nib() -> UINib {
        return UINib(nibName: NSStringFromClass(Base.self), bundle: Bundle.main)
    }
}

// MARK: - 👀
public extension Swifty where Base: UIViewController {
    static func nib() -> UINib {
        return UINib(nibName: NSStringFromClass(Base.self), bundle: Bundle.main)
    }
}
