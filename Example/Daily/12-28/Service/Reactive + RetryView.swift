//
//  Reactive + RetryView.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/1/9.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: - 👀
//extension Reactive where Base: UIScrollView {
//    var retry: Observable<Void> {
//        return base.retryView.btnRetryTap
//    }
//    var isShowRetryView: Binder<LXEmptyType> {
//        return Binder(base) { (target, value) in
//            target.retryView.retryType = value
//            if value == .success {
//                target.retryView.removeFromSuperview()
//            } else {
//                target.show
//            }
//        }
//    }
//}

// MARK: - 👀RetryView
//extension UIView {
//    private static var retryViewAssociatedKey = "retryViewAssociatedKey"
//    var retryView: RetryView {
//        set {
//            objc_setAssociatedObject(self,
//                                     &UIView.retryViewAssociatedKey,
//                                     newValue,
//                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//        get {
//            guard let view = objc_getAssociatedObject(self, &UIView.retryViewAssociatedKey) as? RetryView else {
//                let view = RetryView()
//                view.backgroundColor = .clear
//                self.retryView = view
//                return view
//            }
//            return view
//        }
//    }
//}
