//
//  Refreshable.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import MJRefresh

protocol XLRefreshable {}

// MARK: - 👀
extension XLRefreshable where Self: UIViewController {
    func setupRefreshHeader(_ scrollView: UIScrollView, action: @escaping () -> Void) -> MJRefreshHeader? {
        scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            action()
        })
        return scrollView.mj_header
    }
}
