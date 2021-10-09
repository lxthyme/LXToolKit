//
//  LXNestedTableView.swift
//  LXToolKit_Exam
//
//  Created by lxthyme on 2021/9/27.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import LXToolKit

class LXNestedTableView: UITableView {}

// MARK: - ✈️UIGestureRecognizerDelegatwe
// extension LXNestedTableView: UIGestureRecognizerDelegate {
//     override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//         if gestureRecognizer == self.panGestureRecognizer,
//            let point = (gestureRecognizer as? UIPanGestureRecognizer)?.translation(in: self),
//            abs(point.y) / abs(point.x) < 1 {
//             dlog("不能滑动")
//             return false
//         }
//         return super.gestureRecognizerShouldBegin(gestureRecognizer)
//     }
//     func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//         return true
//     }
// }
