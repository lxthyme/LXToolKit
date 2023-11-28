//
//  UICollectionView + register.swift
//  LXToolKit
//
//  Created by LXThyme Jason on 2020/11/17.
//

// MARK: - 👀
public extension Swifty where Base: UICollectionView {
    func registerCell<T: UICollectionViewCell>(with nibName: T.Type, isNib: Bool = false) {
        if isNib {
            base.register(UINib(nibName: T.XL.typeNameString, bundle: Bundle.main), forCellWithReuseIdentifier: T.XL.reuseIdentifier)
        } else {
            base.register(T.self, forCellWithReuseIdentifier: T.XL.reuseIdentifier)
        }
    }
    func registerSupplementaryView<T: UICollectionReusableView>(with clsName: T.Type, kind: String, isNib: Bool = false) {
        if isNib {
            base.register(UINib(nibName: T.XL.typeNameString, bundle: Bundle.main),
                          forSupplementaryViewOfKind: kind,
                          withReuseIdentifier: T.XL.reuseIdentifier)
        } else {
            base.register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.XL.reuseIdentifier)
        }
    }
}
