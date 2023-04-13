//
//  DJSwiftTestVC.swift
//  DJObjcModule
//
//  Created by lxthyme on 2023/3/31.
//
import UIKit
import DJBusinessModuleSwift

open class DJSwiftTestVC: NSObject {
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
}

// MARK: 👀Public Actions
public extension DJSwiftTestVC {
    @objc func testVC() -> LXTestVC {
        let testVC = LXTestVC()
        return testVC
    }
}

// MARK: 🔐Private Actions
private extension DJSwiftTestVC {}
