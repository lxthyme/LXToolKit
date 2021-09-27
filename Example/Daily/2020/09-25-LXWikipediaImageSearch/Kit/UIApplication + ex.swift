//
//  UIApplication + ex.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/9/27.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

extension UIApplication {
    static var isInUITest: Bool {
        return ProcessInfo.processInfo.environment["isUITest"] != nil;
    }
}
