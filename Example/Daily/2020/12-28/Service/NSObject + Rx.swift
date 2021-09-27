//
//  NSObject + Rx.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/1/9.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import ObjectiveC

fileprivate var disposeBagContext: UInt8 = 0

// MARK: - 👀<#Public Actions#>
extension Reactive where Base: AnyObject {
    var disposeBag: DisposeBag {
        get {
            return synchronizedBag {
                if let disposeObj = objc_getAssociatedObject(base, &disposeBagContext) as? DisposeBag {
                    return disposeObj
                }
                let disposeObj = DisposeBag()
                objc_setAssociatedObject(base, &disposeBagContext, disposeObj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return disposeObj
            }
        }
        set {
            synchronizedBag {
                objc_setAssociatedObject(base, &disposeBagContext, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    func synchronizedBag<T>(_ action: () ->T) ->T {
        objc_sync_enter(self.base)
        let result = action()
        objc_sync_exit(self.base)
        return result
    }
}
