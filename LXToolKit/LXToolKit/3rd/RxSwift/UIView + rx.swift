//
//  UIView + rx.swift
//  LXToolKit
//
//  Created by LXThyme Jason on 2021/3/23.
//

import Foundation
import RxSwift
import RxCocoa

public extension Swifty where Base: UIView {
    /// Bindable sink for `tintColor` property
    var tintColor: Binder<UIColor?> {
        return Binder(self.base) { view, attr in
            view.tintColor = attr
        }
    }
}
