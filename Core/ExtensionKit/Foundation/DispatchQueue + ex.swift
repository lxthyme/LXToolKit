//
//  LXDispatchQueueEx.swift
//  Vaffle_demo
//
//  Created by LXThyme on 2018/11/16.
//  Copyright © 2018 DamonJow. All rights reserved.
//

import Foundation

private var _onceTracker: [String] = []
extension Swifty where Base: DispatchQueue {
    public static var `default`: DispatchQueue { return DispatchQueue.global(qos: .`default`) }
    public static var userInteractive: DispatchQueue { return DispatchQueue.global(qos: .userInteractive) }
    public static var userInitiated: DispatchQueue { return DispatchQueue.global(qos: .userInitiated) }
    public static var utility: DispatchQueue { return DispatchQueue.global(qos: .utility) }
    public static var background: DispatchQueue { return DispatchQueue.global(qos: .background) }

    public func after(_ delay: TimeInterval, execute closure: @escaping () -> Void) {
        base.asyncAfter(deadline: .now() + delay, execute: closure)
    }

    public func once(_ token: String, block:() -> Void) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }

        if _onceTracker.contains(token) {
            return
        }
        _onceTracker.append(token)
        block()
    }
}

//public extension TypeWrapperProtocol where BaseType == DispatchQueue {
public extension Swifty where Base: DispatchQueue {
    // This method will dispatch the `block` to self.
    // If `self` is the main queue, and current thread is main thread, the block
    // will be invoked immediately instead of being dispatched.
    func safeAsync(_ block: @escaping ()->Void) {
        if base === DispatchQueue.main && Thread.isMainThread {
            block()
        } else {
            base.async { block() }
        }
    }
}
