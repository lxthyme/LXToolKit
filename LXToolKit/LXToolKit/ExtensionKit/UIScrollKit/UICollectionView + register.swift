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
            base.register(UINib(nibName: T.XL.xl_typeName, bundle: Bundle.main), forCellWithReuseIdentifier: T.XL.xl_identifier)
        } else {
            base.register(T.self, forCellWithReuseIdentifier: T.XL.xl_identifier)
        }
    }
    func registerSupplementaryView<T: UICollectionReusableView>(with clsName: T.Type, kind: String, isNib: Bool = false) {
        if isNib {
            base.register(UINib(nibName: T.XL.xl_typeName, bundle: Bundle.main),
                          forSupplementaryViewOfKind: kind,
                          withReuseIdentifier: T.XL.xl_identifier)
        } else {
            base.register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.XL.xl_identifier)
        }
    }
}
