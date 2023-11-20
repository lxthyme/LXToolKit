//
//  LXNavigatable.swift
//  LXToolKit_Exam
//
//  Created by lxthyme on 2022/2/10.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import Hero
import SafariServices
import LXToolKit
import DJTestKit

extension Navigator {
    
    // func get(segue: Scene) -> (vc: UIViewController?, transition: Transition) {
    //     switch segue {
    //     case .openURL(let url, let inWebView, _):
    //         guard let url else { return nil }
    //
    //         if inWebView {
    //             let vc = SFSafariViewController(url: url)
    //             return vc
    //         }
    //         UIApplication.shared.open(url, options: [:], completionHandler: nil)
    //         return nil
    //     case .vc(_, let vcProvider, _): return vcProvider()
    //     case .vcString(let vcString, _):
    //         guard let VCCls = NSClassFromString(vcString) as? UIViewController.Type else { return nil }
    //         return VCCls.init()
    //     case .tabs(let vm, _):
    //         let rootVC = DJHomeTabBarVC(vm: vm, navigator: self)
    //         let detailVC = DJHomeTabBarVC(vm: vm, navigator: self)
    //         let splitVC = UISplitViewController()
    //         splitVC.viewControllers = [rootVC , detailVC]
    //         return splitVC
    //     }
    // }
}

// MARK: - 👀
extension Navigator.Scene {
    var info: (title: String, desc: String) {
        var tmp: (title: String, desc: String)
        switch self {
        case .openURL(let url, let inWebView, _, _):
            tmp = (title: "safari[\(inWebView)]", desc: "\(url?.absoluteString ?? "")")
        case .vc(let identifier, _, _, _): tmp = (title: "vc: \(identifier)", desc: "---")
        case .vcString(let vcString, _, _): tmp = (title: vcString, desc: "---")
        case .tabs:
            tmp = (title: "DJHomeTabBarVC", desc: "---")
        }
        return tmp
    }
}
