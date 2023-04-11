//
//  DJSwiftTest.swift
//  DJObjcModule
//
//  Created by lxthyme on 2023/3/31.
//
import UIKit
import DJBusinessModuleSwift

open class DJSwiftTest: NSObject {
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
}

// MARK: 👀Public Actions
public extension DJSwiftTest {
    @objc func testVC() -> LXTestVC {
        let testVC = LXTestVC()
        return testVC
    }
}

// MARK: 🔐Private Actions
private extension DJSwiftTest {}
