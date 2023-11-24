//
//  Bundle+ex.swift
//  LXToolKit
//
//  Created by lxthyme on 2023/11/24.
//

import Foundation

private class LXBundleFinder {}

public extension Swifty where Base: Bundle {
    static var lxToolKitsBundle: Bundle? {
    let assetPath = Bundle(for: LXBundleFinder.self).bundlePath
    return Bundle(path: NSString(string: assetPath).appendingPathComponent("LXToolKit.bundle"))
  }
}
