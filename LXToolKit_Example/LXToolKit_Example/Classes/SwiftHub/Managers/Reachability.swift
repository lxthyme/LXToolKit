//
//  Reachability.swift
//  test
//
//  Created by lxthyme on 2023/3/23.
//

import Foundation
import Alamofire

// An observable that completes when the app gets online (possibly completes immediately).
func connectedToInternet() -> Observable<Bool> {
    return ReachabilityManager.shared.reach
}

private class ReachabilityManager: NSObject {
    static let shared = ReachabilityManager()

    let reachSubject = ReplaySubject<Bool>.create(bufferSize: 1)
    var reach: Observable<Bool> {
        return reachSubject.asObservable()
    }

    override init() {
        super.init()

        NetworkReachabilityManager.default?
            .startListening(onUpdatePerforming: { status in
                switch status {
                case .notReachable:
                    self.reachSubject.onNext(false)
                case .reachable:
                    self.reachSubject.onNext(true)
                case .unknown:
                    self.reachSubject.onNext(false)
                }
            })
    }
}
