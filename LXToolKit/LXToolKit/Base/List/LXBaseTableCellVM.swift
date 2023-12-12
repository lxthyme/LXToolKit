//
//  LXBaseTableCellVM.swift
//  test
//
//  Created by lxthyme on 2023/3/27.
//
import UIKit

open class LXBaseTableCellVM: NSObject {
    deinit {
        LogKit.traceLifeCycle(.TableViewCellVM, typeName: xl.typeNameString, type: .deinit)
        LogKit.resourcesCount()
    }
    // MARK: 📌UI
    // MARK: 🔗Vaiables
}

// MARK: 👀Public Actions
extension LXBaseTableCellVM {}

// MARK: 🔐Private Actions
private extension LXBaseTableCellVM {}
