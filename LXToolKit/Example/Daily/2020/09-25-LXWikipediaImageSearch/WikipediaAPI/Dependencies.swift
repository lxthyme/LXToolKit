//
//  Dependencies.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/9/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import RxSwift

class Dependencies {
    static let shared = Dependencies()
    let URLSession = Foundation.URLSession.shared
    let backgroundWorkScheduler: ImmediateSchedulerType
    let mainScheduler: SerialDispatchQueueScheduler
    let wireframe: Wireframe
    let reachabilityService: ReachabilityService

    private init() {
        wireframe = DefaultWireframe()

        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 2
        operationQueue.qualityOfService = .userInitiated
        backgroundWorkScheduler = OperationQueueScheduler(operationQueue: operationQueue)

        mainScheduler = MainScheduler.instance
        do {
            reachabilityService = try DefaultReachabilityService()
        } catch {
            fatalError("")
        }
    }
}
