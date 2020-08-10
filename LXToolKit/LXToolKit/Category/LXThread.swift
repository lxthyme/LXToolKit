//
//  LXThread.swift
//  Vaffle_demo
//
//  Created by DamonJow on 2018/10/26.
//  Copyright © 2018 DamonJow. All rights reserved.
//

import Foundation

public extension DispatchQueue {
    // This method will dispatch the `block` to self.
    // If `self` is the main queue, and current thread is main thread, the block
    // will be invoked immediately instead of being dispatched.
    func safeAsync(_ block: @escaping ()->Void) {
        if self === DispatchQueue.main && Thread.isMainThread {
            block()
        } else {
            async { block() }
        }
    }
}
