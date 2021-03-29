//
//  Reachability.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/24.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
import Moya

// An observable that completes when the app gets online (possibly completes immediately).
func connectedToInternet() -> BehaviorRelay<Bool> {
    return XLReachabilityManager.shared.reach
}

private class XLReachabilityManager: NSObject {

    static let shared = XLReachabilityManager()

    let reachSubject = BehaviorRelay<Bool>(value: true)
    var reach: BehaviorRelay<Bool> {
        return reachSubject
    }

    override init() {
        super.init()

        NetworkReachabilityManager.default?.startListening(onUpdatePerforming: { (status) in
            Logger.warn("🛠: network status changed: \(status)")
            switch status {
            case .notReachable:
                self.reachSubject.accept(false)
            case .reachable:
                self.reachSubject.accept(true)
            case .unknown:
                self.reachSubject.accept(false)
            }
        })
    }
}
