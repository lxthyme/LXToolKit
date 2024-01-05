//
//  DJAutoRouter.swift
//  DJTestKit
//
//  Created by lxthyme on 2023/11/1.
//

import Foundation
import LXToolKit

public enum DJAutoRouterError: Error {
    case autoJumpRouter1Failure
    case autoJumpRouter2Failure
}

public enum DJAutoRouter: String {
    case router1 = "level router1"
    case router2 = "level router2"
}

// MARK: - 👀
public extension DJAutoRouter {
    public func getDefaultsValue() -> String? {
        return UserDefaults.standard.string(forKey: rawValue)
    }
    func clearRouter() {
        UserDefaults.standard.set("", forKey: self.rawValue)
    }
    func updateRouter(section: LXSection) {
        UserDefaults.standard.set(section.title, forKey: self.rawValue)
    }
    static func clearAllData() {
        DJAutoRouter.router1.clearRouter()
        DJAutoRouter.router2.clearRouter()
    }
}

open class DJTestTypeObjc: NSObject {}

// MARK: - 👀
public extension DJTestTypeObjc {
    @objc public static func clearRouter1() {
        DJAutoRouter.router1.clearRouter()
    }
    @objc public static func clearRouter2() {
        DJAutoRouter.router2.clearRouter()
    }
    @objc public static func updateObjcRouter1Defaults(vcName: String) {
        DJAutoRouter.router1.updateRouter(section: .section(title: vcName))
    }
    @objc public static func updateObjcRouter2Defaults(vcName: String) {
        DJAutoRouter.router2.updateRouter(section: .section(title: vcName))
    }
}
