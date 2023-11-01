//
//  DJTestType.swift
//  DJTestKit
//
//  Created by lxthyme on 2023/11/1.
//

import Foundation
import LXToolKit



public enum DJTestType: Hashable {
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
    case djTest(vc: UIViewController)
}

// MARK: - 👀
public extension DJTestType {
    var title: String {
        switch self {
            // case .LXToolKit:
            //     return "LXToolKit"
        case .LXToolKit_Example:
            return "LXToolKit_Example"
            // case .LXToolKitObjC:
            //     return "LXToolKitObjC"
        case .LXToolKitObjC_Example:
            return "LXToolKitObjC_Example"
        case .DJSwiftModule:
            return "DJSwiftModule"
        case .dynamicIsland:
            return "dynamicIsland"
        case .djTest(let vc):
            return "DJTest - \(vc.xl.xl_typeName)"
        }
    }
    func intValue() -> Int {
        switch self {
        case .LXToolKit_Example: return 1
        case .LXToolKitObjC_Example: return 2
        case .DJSwiftModule: return 3
        case .dynamicIsland: return 4
        case .djTest: return 5
        }
    }
    static func fromInt(idx: Int) -> Self? {
        switch idx {
        case 1: return .LXToolKit_Example
        case 2: return .LXToolKitObjC_Example
        case 3: return .DJSwiftModule
        case 4: return .dynamicIsland
        case 5:
            guard let vcName = UserDefaults.standard.string(forKey: "autoJumpRoute.route.5"),
                  let Cls = vcName.xl.getVCCls(expect: UIViewController.self) else {
                return nil
            }
            return .djTest(vc: Cls.init())
        default: return nil
        }
    }
    func userDefaultsKey() -> String {
        let idx = intValue()
        return "\(DJTestType.AutoJumpRoute).\(idx)"
    }
}
