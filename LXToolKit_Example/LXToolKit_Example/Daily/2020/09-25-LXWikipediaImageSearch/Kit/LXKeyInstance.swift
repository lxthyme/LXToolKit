
//
//  LXKeyInstance.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/9/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import LXToolKit

class LXKeyInstance: LXBaseObject {
    // MARK: 🔗Vaiables
    static let shared = LXKeyInstance()
    lazy var numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        return nf
    }()
    lazy var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        return df
    }()
    private override init() { super.init() }
}

// MARK: 👀Public Actions
extension LXKeyInstance {}

// MARK: 🔐Private Actions
private extension LXKeyInstance {}
