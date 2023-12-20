//
//  Bundle+ex.swift
//  LXToolKit
//
//  Created by lxthyme on 2023/11/24.
//

import Foundation

private class LXBundleFinder {}

extension Swifty where Base == Bundle {
    public static var lxToolKitsBundle: Bundle? {
    let assetPath = Bundle(for: LXBundleFinder.self).bundlePath
    return Bundle(path: NSString(string: assetPath).appendingPathComponent("LXToolKit.bundle"))
  }
    public static func bundle(for cls: AnyClass, bundleName: String) -> Bundle? {
        let assetPath = Bundle(for: cls.self).bundlePath
        return Bundle(path: NSString(string: assetPath).appendingPathComponent(bundleName))
    }
}
