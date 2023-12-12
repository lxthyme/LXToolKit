//
//  LXBaseTableViewCellVM.swift
//  test
//
//  Created by lxthyme on 2023/3/27.
//
import UIKit

open class LXBaseTableViewCellVM: NSObject {
    deinit {
        LogKit.traceLifeCycle(.TableViewCellVM, typeName: xl.typeNameString, type: .deinit)
        LogKit.resourcesCount()
    }
    // MARK: 📌UI
    // MARK: 🔗Vaiables
}

// MARK: 👀Public Actions
extension LXBaseTableViewCellVM {}

// MARK: 🔐Private Actions
private extension LXBaseTableViewCellVM {}
