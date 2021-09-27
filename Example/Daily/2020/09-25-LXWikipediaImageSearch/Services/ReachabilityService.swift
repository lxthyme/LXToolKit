//
//  ReachabilityService.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/9/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import RxSwift

enum ReachabilityStatus {
    case reachable(viaWifi: Bool)
    case unreachable
}

// MARK: - 👀
extension ReachabilityStatus {
    var reachable: Bool {
        switch self {
            case .reachable: return true
            case .unreachable: return false
        }
    }
}

protocol ReachabilityService {
    var reachability: Observable<ReachabilityStatus> { get }
}

enum ReachabilityServiceError: Error {
    case failedToCreate
}

class DefaultReachabilityService: ReachabilityService {
    private let _reachabilitySubject: BehaviorSubject<ReachabilityStatus>

    var reachability: Observable<ReachabilityStatus> {
        return _reachabilitySubject.asObservable()
    }

    let _reachability: Reachability

    init() throws {
        guard let reachabilityRef = Reachability() else { throw ReachabilityServiceError.failedToCreate }

        let reachabilitySubject = BehaviorSubject<ReachabilityStatus>(value: .unreachable)

        /// so main thread isn't blocked when reachability via WiFi is checked
        let backgroundQueue = DispatchQueue(label: "com.lx.reachability.wifiCheck")

        reachabilityRef.whenReachable = { reachability in
            backgroundQueue.async {
                reachabilitySubject.on(.next(.reachable(viaWifi: reachabilityRef.isReachableViaWifi)))
            }
        }

        reachabilityRef.whenUnreachable = { reachability in
            backgroundQueue.async {
                reachabilitySubject.on(.next(.unreachable))
            }
        }

        try reachabilityRef.startNotifier()
        _reachability = reachabilityRef
        _reachabilitySubject = reachabilitySubject
    }

    deinit {
        try? _reachability.stopNotifier()
    }
}

// MARK: - 👀
extension ObservableConvertibleType {
    func retryOnBecomesReachable(_ valueOnFailure: Element, reachabilityService: ReachabilityService) ->Observable<Element> {
        return self
            .asObservable()
            .catchError { e -> Observable<Element> in
                reachabilityService.reachability
                    .skip(1)
                    .filter { $0.reachable }
                    .flatMap { _ in Observable.error(e) }
                    .startWith(valueOnFailure)
        }
        .retry()
    }
}
