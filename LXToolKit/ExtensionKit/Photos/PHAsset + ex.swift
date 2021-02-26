//
//  PHAsset + ex.swift
//  LXToolKit
//
//  Created by LXThyme Jason on 2021/1/16.
//

import Foundation
import Photos

// MARK: - 👀
public extension Swifty where Base: PHAsset {
    var isInCloud: Bool {
        guard let resource = PHAssetResource.assetResources(for: base).first,
              let tmp = resource.value(forKey: "locallyAvailable") as? Bool else {
            return false
        }
        return tmp
    }
}
