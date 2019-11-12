//
//  LXDispatchQueueEx.swift
//  Vaffle_demo
//
//  Created by LXThyme on 2018/11/16.
//  Copyright © 2018 DamonJow. All rights reserved.
//

import Foundation

//extension DispatchQueue {
//    static var `default`: DispatchQueue { return DispatchQueue.global(qos: .`default`) }
//    static var userInteractive: DispatchQueue { return DispatchQueue.global(qos: .userInteractive) }
//    static var userInitiated: DispatchQueue { return DispatchQueue.global(qos: .userInitiated) }
//    static var utility: DispatchQueue { return DispatchQueue.global(qos: .utility) }
//    static var background: DispatchQueue { return DispatchQueue.global(qos: .background) }
//    
//    func after(_ delay: TimeInterval, execute closure: @escaping () -> Void) {
//        asyncAfter(deadline: .now() + delay, execute: closure)
//    }
//    
//    private static var _onceTracker = [String]()
//    public class func once(_ token: String, block:()->Void) {
//        objc_sync_enter(self)
//        defer { objc_sync_exit(self) }
//        
//        if _onceTracker.contains(token) {
//            return
//        }
//        _onceTracker.append(token)
//        block()
//    }
//}
