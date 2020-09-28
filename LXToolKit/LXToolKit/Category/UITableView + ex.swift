//
//  UITableView + ex.swift
//  Alamofire
//
//  Created by LXThyme Jason on 2020/9/27.
//

import Foundation

public extension UITableView {
    func hideEmptyCells() {
        self.tableFooterView = UIView(frame: .zero)
    }
}
