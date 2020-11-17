//
//  UITableView +  register.swift
//  LXToolKit
//
//  Created by LXThyme Jason on 2020/11/17.
//

extension UITableView {
    func registerCell<T: UITableViewCell>(with nibName: T.Type, isNib: Bool = false) {
        if isNib {
            self.register(UINib(nibName: T.xl_typeName, bundle: Bundle.main), forCellReuseIdentifier: T.xl_identifier)
        } else {
            self.register(T.self, forCellReuseIdentifier: T.xl_identifier)
        }
    }
    func registerHeaderFooter<T: UITableViewHeaderFooterView>(_ clsName: T.Type, isNib: Bool = false) {
        if isNib {
            self.register(UINib(nibName: T.xl_typeName, bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: T.xl_identifier)
        } else {
            self.register(T.self, forHeaderFooterViewReuseIdentifier: T.xl_identifier)
        }
    }
}
