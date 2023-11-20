//
//  CaseIterable+ex.swift
//  LXToolKit
//
//  Created by lxthyme on 2023/11/20.
//

import Foundation

// MARK: - 👀
public extension CaseIterable {
    static func randomCaseIterableElement(using generator: inout some RandomNumberGenerator) -> Self? {
        allCases.randomElement(using: &generator)
    }
    static func randomCaseIterableElement() -> Self? {
        var generator = SystemRandomNumberGenerator()
        return randomCaseIterableElement(using: &generator)
    }
}
