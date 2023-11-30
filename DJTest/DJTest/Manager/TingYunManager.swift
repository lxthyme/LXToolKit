//
//  TingYunManager.swift
//  DJTest
//
//  Created by lxthyme on 2023/11/29.
//

import Foundation

struct TingYunManager {}

// MARK: - 👀
extension TingYunManager {
    static func reportEvent(name: String, properties: [String: String] = [:]) {
        NBSAppAgent.reportEvent(name, properties: properties)
    }
}
