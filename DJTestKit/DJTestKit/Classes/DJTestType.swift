//
//  DJTestType.swift
//  DJTestKit
//
//  Created by lxthyme on 2023/11/1.
//

import Foundation
import LXToolKit

public enum DJTestTypeError: Error {
    case autoJumpRouter1Failure
    case autoJumpRouter2Failure
}

public enum DJTestTypeRouterLevel: String {
    case router1 = "level router1"
    case router2 = "level router2"

    public func getDefaultsValue() -> String? {
        return UserDefaults.standard.string(forKey: rawValue)
    }
}

public enum DJTestType {
    public static let AutoJumpRoute = "autoJumpRoute.route"

    // case LXToolKit
    case LXToolKit_Example
    // case LXToolKitObjC
    case LXToolKitObjC_Example
    case DJSwiftModule
    /// 灵动岛
    // @available(iOS 16.2, *)
    case dynamicIsland
    // case DJRSwiftResource
    case djTest
    case t3rd
    case flutter
}

// MARK: - ✈️Hashable
extension DJTestType: Hashable {
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .LXToolKit_Example:
            hasher.combine("LXToolKit_Example")
        case .LXToolKitObjC_Example:
            hasher.combine("LXToolKitObjC_Example")
        case .DJSwiftModule:
            hasher.combine("DJSwiftModule")
        case .dynamicIsland:
            hasher.combine("dynamicIsland")
        case .djTest:
            hasher.combine("DJTest")
        case .t3rd:
            hasher.combine("3rd")
        case .flutter:
            hasher.combine("flutter")
        }
    }
    public static func == (lhs: DJTestType, rhs: DJTestType) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

// MARK: - ✈️CustomStringConvertible
extension DJTestType: CustomStringConvertible {
    public var description: String {
        switch self {
            // case .LXToolKit:
            //     return "LXToolKit"
        case .LXToolKit_Example:
            return ".LXToolKit_Example"
            // case .LXToolKitObjC:
            //     return "LXToolKitObjC"
        case .LXToolKitObjC_Example:
            return ".LXToolKitObjC_Example"
        case .DJSwiftModule:
            return ".DJSwiftModule"
        case .dynamicIsland:
            return ".dynamicIsland"
        case .djTest:
            return ".DJTest"
        case .t3rd:
            return ".3rd"
        case .flutter:
            return ".Flutter"
        }
    }
}
// MARK: - 👀
public extension DJTestType {
    var title: String {
        return self.description.removingPrefix(".")
    }
    func intValue() -> Int {
        switch self {
        case .LXToolKit_Example: return 1
        case .LXToolKitObjC_Example: return 2
        case .DJSwiftModule: return 3
        case .dynamicIsland: return 4
        case .djTest: return 5
        case .t3rd: return 6
        case .flutter: return 7
        }
    }
    static func fromInt(idx: Int) -> Self? {
        switch idx {
        case 1: return .LXToolKit_Example
        case 2: return .LXToolKitObjC_Example
        case 3: return .DJSwiftModule
        case 4: return .dynamicIsland
        case 5:
            // guard let vcName = UserDefaults.standard.string(forKey: "autoJumpRoute.route.\(idx)"),
            //       let Cls = vcName.xl.getVCCls() else {
            //     return nil
            // }
            return .djTest// (title: "", provider: {
            //     Cls.init()
            // })
        case 6: return .t3rd
        case 7: return .flutter
        default: return nil
        }
    }
}
// MARK: - 👀
public extension DJTestType {
    // static func updateAutoJumpRoute(_ type: DJTestType) {
    //     UserDefaults.standard.set(type.intValue(), forKey: DJTestType.AutoJumpRoute)
    // }
    static func updateRouter(level: DJTestTypeRouterLevel, section: LXSection) {
        UserDefaults.standard.set(section.title, forKey: level.rawValue)
    }
    public func updateRouter(section: LXSection) {
        guard section.title != "LXToolKitTestVC",
              section.title != "LXToolKitObjCTestVC",
              section.title != "LXToolKitObjCTestSwiftVC" else {
            return
        }
        UserDefaults.standard.set(self.intValue(), forKey: DJTestType.AutoJumpRoute)
        UserDefaults.standard.set(section.title, forKey: userDefaultsKey)
    }
    public static var AutoJumpRouteRouter: Int {
        return UserDefaults.standard.integer(forKey: DJTestType.AutoJumpRoute)
    }
    public var userRouter: String {
        return UserDefaults.standard.string(forKey: userDefaultsKey) ?? ""
    }
    var userDefaultsKey: String {
        let idx = intValue()
        return "\(DJTestType.AutoJumpRoute).\(idx)"
    }
}

// MARK: - 👀
public extension DJTestType {
    static func clearAllData() {
        let defaults = UserDefaults.standard
        defaults.setValue("", forKey: DJTestType.AutoJumpRoute)
        defaults.setValue("", forKey: DJTestType.LXToolKit_Example.userDefaultsKey)
        defaults.setValue("", forKey: DJTestType.LXToolKitObjC_Example.userDefaultsKey)
        defaults.setValue("", forKey: DJTestType.DJSwiftModule.userDefaultsKey)
        defaults.setValue("", forKey: DJTestType.dynamicIsland.userDefaultsKey)
        defaults.setValue("", forKey: DJTestType.djTest.userDefaultsKey)
        defaults.setValue("", forKey: DJTestType.t3rd.userDefaultsKey)
        defaults.setValue("", forKey: DJTestType.flutter.userDefaultsKey)
    }
}

open class DJTestTypeObjc: NSObject {}

// MARK: - 👀
public extension DJTestTypeObjc {
    @objc public static func updateObjcDefaults(vcName: String) {
        // DJTestType.LXToolKitObjC_Example.updateRouter(section: .section(title: vcName))
        DJTestType.updateRouter(level: .router2, section: .section(title: vcName))
    }
}
