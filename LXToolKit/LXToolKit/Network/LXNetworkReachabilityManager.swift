//
//  LXNetworkReachabilityManager.swift
//  Vaffle_demo
//
//  Created by DamonJow on 2018/11/1.
//  Copyright © 2018 DamonJow. All rights reserved.
//

import UIKit
import Alamofire

public extension Notification.Name {
    /// 网络状态发生改变
    static let networkReachabilityDidChanged = Notification.Name("LXDownloaderNotification.networkReachabilityDidChanged")
}

public class LXNetworkReachabilityManager: NSObject {
    lazy var networkReachabilityStatus: NetworkReachabilityManager.NetworkReachabilityStatus = {
        return .unknown
    }()
    static let instance = LXNetworkReachabilityManager()
    private override init() { }
}

public extension LXNetworkReachabilityManager {
    /// 监听网络状态
//    func monitorNetworkStatus() {
//        let manager = NetworkReachabilityManager(host: "http://baidu.com")
//        manager?.listener = {[weak self] status in
//            guard let `self` = self else { return }
//            switch status {
//            case .unknown:
//                logger.debug("当前网络：未知")
//            case .notReachable:
//                logger.debug("当前网络：无网络")
//            case .reachable(.wwan):
//                logger.debug("当前网络：蜂窝网络")
//            case .reachable(.ethernetOrWiFi):
//                logger.debug("当前网络：无线网络")
//            }
//
//            if self.networkReachabilityStatus != status {
//                self.networkReachabilityStatus = status
//                /// 网络改变通知
//                NotificationCenter.default.post(name: .networkReachabilityDidChanged, object: status)
//            }
//        }
//
//        manager?.startListening()
//    }
}
