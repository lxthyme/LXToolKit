//
//  CGRect + ex.swift
//  SwiftPro
//
//  Created by DamonJow on 2018/10/19.
//  Copyright © 2018 DamonJow. All rights reserved.
//
import UIKit
import Foundation

// MARK: - 👀
public extension Swifty where Base == CGRect {
    var minX: CGFloat {
        get { return base.minX }
        set { base.origin.x = newValue }
    }
    var midX: CGFloat {
        get { return base.midX }
        set { base.origin.x += (newValue - base.midX) }
    }
    var maxX: CGFloat {
        get { return base.maxX }
        set { base.origin.x += (newValue - base.maxX) }
    }
    var minY: CGFloat {
        get { return base.minY }
        set { base.origin.y = newValue }
    }
    var midY: CGFloat {
        get { return base.midY }
        set { base.origin.y += (newValue - base.midY) }
    }
    var maxY: CGFloat {
        get { return base.maxY }
        set { base.origin.y += (newValue - base.maxY) }
    }
    var width: CGFloat {
        get { return base.width }
        set { base.size.width = newValue }
    }
    var height: CGFloat {
        get { return base.height }
        set { base.size.height = newValue }
    }
    var center: CGPoint {
        get { return CGPoint(x: (base.maxX - base.minX) / 2.0, y: (base.maxY - base.minY) / 2.0) }
        set {
            base.origin.x = newValue.x - base.width / 2
            base.origin.y = newValue.y - base.height / 2
        }
    }
    var centerX: CGFloat {
        get { return (base.maxX - base.minX) / 2.0 }
        set {
            base.origin.x = newValue - base.width / 2
        }
    }
    var centerY: CGFloat {
        get { return (base.maxY - base.minY) / 2.0 }
        set {
            base.origin.y = newValue - base.height / 2
        }
    }
}
