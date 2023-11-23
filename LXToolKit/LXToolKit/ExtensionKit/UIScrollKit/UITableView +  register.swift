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
            base.register(UINib(nibName: T.XL.xl_typeName, bundle: Bundle.main), forCellReuseIdentifier: T.XL.xl_identifier)
        } else {
            base.register(T.self, forCellReuseIdentifier: T.XL.xl_identifier)
        }
    }
    func registerHeaderOrFooter<T: UITableViewHeaderFooterView>(_ clsName: T.Type, isNib: Bool = false) {
        if isNib {
            base.register(UINib(nibName: T.XL.xl_typeName, bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: T.XL.xl_identifier)
        } else {
            base.register(T.self, forHeaderFooterViewReuseIdentifier: T.XL.xl_identifier)
        }
    }
}
