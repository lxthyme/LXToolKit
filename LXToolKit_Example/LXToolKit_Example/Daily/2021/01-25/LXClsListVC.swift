//
//  LXClsListVC.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/1/25.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class LXClsListVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
    }

}

// MARK: 🌎LoadData
extension LXClsListVC {}

// MARK: 👀Public Actions
extension LXClsListVC {}

// MARK: 🔐Private Actions
private extension LXClsListVC {
    func getClsList() {
//        let clsList = class_
        let name = "Apple"
        let vcMirror = Mirror(reflecting: LXClsListVC.self)
        let nameMirror = Mirror(reflecting: name)

        dlog("vcMirror: \(vcMirror)")
        dlog("nameMirror: \(nameMirror)")
    }
//    func printMethodNamesForClass(cls: AnyClass) {
//        var methodCount: UInt32 = 0
//        let methodList = class_copyMethodList(cls, &methodCount)
//        if methodList != nil && methodCount > 0 {
//            enumerateCArray(methodList, methodCount) { i, m in
//                let name = methodName(m) ?? "unknown"
//                println("#\(i): \(name)")
//            }
//
//            free(methodList)
//        }
//    }
//    func enumerateCArray<T>(array: UnsafePointer<T>, count: UInt32, f: (UInt32, T) -> ()) {
//        var ptr = array
//        for i in 0..<count {
//            f(i, ptr.memory)
//            ptr = ptr.successor()
//        }
//    }
//    func methodName(m: Method) -> String? {
//        let sel = method_getName(m)
//        let nameCString = sel_getName(sel)
//        return String.fromCString(nameCString)
//    }
//    func printMethodNamesForClassNamed(classname: String) {
//        // NSClassFromString() is declared to return AnyClass!, but should be AnyClass?
//        let maybeClass: AnyClass? = NSClassFromString(classname)
//        if let cls: AnyClass = maybeClass {
//            printMethodNamesForClass(cls)
//        }
//        else {
//            println("\(classname): no such class")
//        }
//    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXClsListVC {
    func prepareUI() {
        self.view.backgroundColor = UIColor.white
        // self.title = "<#title#>"

        // [<#table#>].forEach(self.view.addSubview)
        masonry()
    }

    func masonry() {}
}
