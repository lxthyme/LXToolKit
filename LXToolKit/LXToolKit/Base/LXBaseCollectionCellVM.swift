//
//  LXBaseCollectionCellVM.swift
//  LXToolKit
//
//  Created by lxthyme on 2023/12/12.
//

import Foundation

open class LXBaseCollectionCellVM: NSObject {
    deinit {
        LogKit.traceLifeCycle(.CollectionViewCellVM, typeName: xl.typeNameString, type: .deinit)
        LogKit.resourcesCount()
    }
    // MARK: 📌UI
    // MARK: 🔗Vaiables
}

// MARK: 👀Public Actions
extension LXBaseCollectionCellVM {}

// MARK: 🔐Private Actions
private extension LXBaseCollectionCellVM {}
