//
//  UITableView +  register.swift
//  LXToolKit
//
//  Created by LXThyme Jason on 2020/11/17.
//

// MARK: - 👀
public extension Swifty where Base: UITableView {
    func registerCell<T: UITableViewCell>(with nibName: T.Type, isNib: Bool = false) {
        if isNib {
            base.register(UINib(nibName: T.XL.typeNameString, bundle: Bundle.main), forCellReuseIdentifier: T.XL.reuseIdentifier)
        } else {
            base.register(T.self, forCellReuseIdentifier: T.XL.reuseIdentifier)
        }
    }
    func registerHeaderOrFooter<T: UITableViewHeaderFooterView>(_ clsName: T.Type, isNib: Bool = false) {
        if isNib {
            base.register(UINib(nibName: T.XL.typeNameString, bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: T.XL.reuseIdentifier)
        } else {
            base.register(T.self, forHeaderFooterViewReuseIdentifier: T.XL.reuseIdentifier)
        }
    }
}
