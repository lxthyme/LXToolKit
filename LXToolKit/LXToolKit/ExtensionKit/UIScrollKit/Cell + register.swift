//
//  Cell + register.swift
//  LXToolKit
//
//  Created by LXThyme Jason on 2021/1/16.
//

import Foundation

public extension Swifty where Base: UICollectionViewCell {
    static func register(_ collectionView: UICollectionView) {
        collectionView.register(Base.self, forCellWithReuseIdentifier: Base.xl.xl_identifier)
    }
}

public extension Swifty where Base: UITableViewCell {
    static func register(_ tableView: UITableView) {
        tableView.register(Base.self, forCellReuseIdentifier: Base.xl.xl_identifier)
    }
}

// MARK: - 👀
public extension Swifty where Base == [UICollectionViewCell.Type] {
    func register(_ collectionView: UICollectionView) {
        base.forEach { $0.xl.register(collectionView) }
    }
}

// MARK: - 👀
public extension Swifty where Base == [UITableViewCell.Type] {
    func register(_ tableView: UITableView) {
        base.forEach { $0.xl.register(tableView) }
    }
}
