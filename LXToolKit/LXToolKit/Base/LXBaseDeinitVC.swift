//
//  LXBaseDeinitVC.swift
//  LXToolKit
//
//  Created by lxthyme on 2023/12/10.
//
import UIKit

open class LXBaseDeinitVC: UIViewController {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    deinit {
        LogKit.traceLifeCycle(.vc, typeName: xl.typeNameString, type: .deinit)
        LogKit.resourcesCount()
    }
}
