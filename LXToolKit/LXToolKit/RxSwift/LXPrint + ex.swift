//
//  LXPrint + ex.swift
//  LXToolKit
//
//  Created by lxthyme on 2022/2/9.
//

import Foundation
import RxSwift
import RxCocoa

public struct LXPrint {
    public static func resourcesCount() {
        #if DEBUG && TRACE_RESOURCES
        dlog("RxSwift resources count: \(RxSwift.Resources.total)")
        #endif
    }
}
