//
//  findCommonSuperview.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/8/5.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
import UIKit
import Foundation
import LXToolKit

// MARK: - <#Title...#>
extension UIView {
    func findSuperView() ->[UIView] {
        var arr: [UIView] = []
        var sv = self.superview
        while let tmp = sv {
            arr.append(tmp)
            sv = sv?.superview
        }
        return arr
    }
    func findCommonSuperView(view1: UIView, view2: UIView) ->[UIView] {
        let v1Superviews = view1.findSuperView()
        let v2Superviews = view2.findSuperView()
        var commonSuperview: [UIView] = []
        for i in 0...min(v1Superviews.count, v2Superviews.count) {
            let tmp1 = v1Superviews[i]
            let tmp2 = v2Superviews[i]
            if tmp1 == tmp2 {
                commonSuperview.append(tmp1)
            }
        }
        dlog("commonSuperview: ", commonSuperview)
        return commonSuperview
    }
}
