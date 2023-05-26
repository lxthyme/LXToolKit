//
//  Base + disposeBag.swift
//  LXToolKit
//
//  Created by LXThyme Jason on 2021/1/27.
//

import Foundation
import RxSwift

// public protocol DisposeBagProperty {
//     var disposeBag: DisposeBag { get set }
// }
// // MARK: - 👀BaseDisposeBag
// extension DisposeBagProperty {
//     public var disposeBag: DisposeBag {
//         get {
//             return objc_getAssociatedObject(self, &LXAssociateKeys.disposeBag) as? DisposeBag ?? DisposeBag()
//         }
//         set {
//             objc_setAssociatedObject(self, &LXAssociateKeys.disposeBag, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//         }
//     }
// }

// MARK: - 👀
// extension LXBaseVC: DisposeBagProperty {}

// MARK: - 👀
// extension LXBaseVMCollectionCell: DisposeBagProperty {}

// MARK: - 👀
// extension LXBaseVMTableViewCell: DisposeBagProperty {}
