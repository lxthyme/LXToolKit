//
//  UITableView + ex.swift
//  Alamofire
//
//  Created by LXThyme Jason on 2020/9/27.
//

import Foundation

public extension Swifty where Base: UITableView {
    func hideEmptyCells() {
        base.tableFooterView = UIView(frame: .zero)
    }
}

// MARK: - 👀版本适配
public extension Swifty where Base: UITableView {
    /// tableView 各系统版本适配
    /// - Parameter parentVC: tableView 所在的 VC
    func adapter(withParentVC parentVC: UIViewController?) {
        if #available(iOS 11.0, *) {
            base.contentInsetAdjustmentBehavior = .never
        } else {
            parentVC?.automaticallyAdjustsScrollViewInsets = false
        }
        if #available(iOS 15.0, *) {
            base.sectionHeaderTopPadding = 0
        }
    }
}

