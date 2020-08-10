//
//  LXDispatchQueueEx.swift
//  Vaffle_demo
//
//  Created by LXThyme on 2018/11/16.
//  Copyright © 2018 DamonJow. All rights reserved.
//

import Foundation

extension DispatchQueue {
    static var lx_default: DispatchQueue { return DispatchQueue.global(qos: .`default`) }
    static var lx_userInteractive: DispatchQueue { return DispatchQueue.global(qos: .userInteractive) }
    static var lx_userInitiated: DispatchQueue { return DispatchQueue.global(qos: .userInitiated) }
    static var lx_utility: DispatchQueue { return DispatchQueue.global(qos: .utility) }
    static var lx_background: DispatchQueue { return DispatchQueue.global(qos: .background) }

    func lx_after(_ delay: TimeInterval, execute closure: @escaping () -> Void) {
        asyncAfter(deadline: .now() + delay, execute: closure)
    }

    private static var _onceTracker = [String]()
    public class func lx_once(_ token: String, block:() -> Void) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }

        if _onceTracker.contains(token) {
            return
        }
        _onceTracker.append(token)
        block()
    }
}
