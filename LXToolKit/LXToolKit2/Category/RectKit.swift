//
//  RectKit.swift
//  SwiftPro
//
//  Created by DamonJow on 2018/10/19.
//  Copyright © 2018 DamonJow. All rights reserved.
//
import UIKit
import Foundation

public extension CGRect {
    var xl_minX: CGFloat {
        get { return self.minX }
        set { self.origin.x = newValue }
    }
    var xl_midX: CGFloat {
        get { return self.midX }
        set { self.origin.x += (newValue - self.midX) }
    }
    var xl_maxX: CGFloat {
        get { return self.maxX }
        set { self.origin.x += (newValue - self.maxX) }
    }
    var xl_minY: CGFloat {
        get { return self.minY }
        set { self.origin.y = newValue }
    }
    var xl_midY: CGFloat {
        get { return self.midY }
        set { self.origin.y += (newValue - self.midY) }
    }
    var xl_maxY: CGFloat {
        get { return self.maxY }
        set { self.origin.y += (newValue - self.maxY) }
    }
    var xl_width: CGFloat {
        get { return self.width }
        set { self.size.width = newValue }
    }
    var xl_height: CGFloat {
        get { return self.height }
        set { self.size.height = newValue }
    }
    var xl_center: CGPoint {
        get { return CGPoint(x: (self.maxX - self.minX) / 2.0, y: (self.maxY - self.minY) / 2.0) }
        set {
            self.origin.x = newValue.x - self.width / 2
            self.origin.y = newValue.y - self.height / 2
        }
    }
    var xl_centerX: CGFloat {
        get { return (self.maxX - self.minX) / 2.0 }
        set {
            self.origin.x = newValue - self.width / 2
        }
    }
    var xl_centerY: CGFloat {
        get { return (self.maxY - self.minY) / 2.0 }
        set {
            self.origin.y = newValue - self.height / 2
        }
    }
}
