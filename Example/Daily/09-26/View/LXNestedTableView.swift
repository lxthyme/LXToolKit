//
//  LXNestedTableView.swift
//  LXToolKit_Exam
//
//  Created by lxthyme on 2021/9/27.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class LXNestedTableView: UITableView {}

// MARK: - ✈️UIGestureRecognizerDelegatwe
extension LXNestedTableView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
