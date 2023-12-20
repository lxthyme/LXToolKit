//
//  DJTestRouter.swift
//  DJTest
//
//  Created by lxthyme on 2023/12/15.
//

import SwiftUI
import Foundation
import DJTestKit
import LXToolKit
import LXToolKit_Example
import FloatingPanel_Maps
import FloatingPanel_Maps_SwiftUI
import FloatingPanel_Samples
import FloatingPanel_SamplesObjC
import FloatingPanel_Stocks

public struct DJTestRouter {
    static let expandedSectionList: [LXOutlineOpt] = [
        DJTestRouter.routerDJTest,
    ]
    static let routerItem: LXOutlineOpt = .subitem(.section(title: "Item 1 - 1"))
    static let router233: LXOutlineOpt = .outline(.section(title: "Section 1"), subitems: [
        .subitem(.section(title: "Item 1 - 1")),
        .outline(.section(title: "Section 2"), subitems: [
            .subitem(.section(title: "Item 2 - 1")),
            .outline(.section(title: "Section 3"), subitems: [
                .subitem(.section(title: "Item 3 - 1")),
                .outline(.section(title: "Section 4"), subitems: [
                    .subitem(.section(title: "Item 4 - 1")),
                    .subitem(.section(title: "Item 4 - 2")),
                ]),
                .subitem(.section(title: "Item 3 - 2")),
            ]),
            .subitem(.section(title: "Item 2 - 2")),
        ]),
        .subitem(.section(title: "Item 1 - 2")),
    ])
    static let routerDJSwiftModule: LXOutlineOpt = .subitem(.section(title: "DJSwiftModule"), scene: .vc(provider: {
        DJTestType.DJSwiftModule.updateRouter(vcName: "")
        let window = UIApplication.XL.keyWindow
        Application.shared.presentInitialScreen(in: window)
        return nil
    }))
    static let routerDynamicIsland: LXOutlineOpt = .subitem(.section(title: "dynamicIsland"), scene: .vc(provider: {
        if #available(iOS 16.2, *) {
            return UIHostingController(rootView: EmojiRangersView())
        } else {
            // Fallback on earlier versions
            let vc = LXSampleTextViewVC()
            vc.dataFillUnSupport(content: "当前设备不支持灵动岛!")
            return vc
        }
    }))
    static let routerDJTest: LXOutlineOpt = .outline(.section(title: "DJTest"), subitems: [
        .subitem(.section(title: "LXAMapTestVC"), scene: .vc(provider: { LXAMapTestVC() })),
        .subitem(.section(title: "LXOutlineVC"), scene: .vc(provider: { LXOutlineVC() })),
        .subitem(.section(title: "UIListContentConfiguration.Ex.allCases"), scene: .vc(provider: {
            let exContent = UIListContentConfiguration.Ex.allCases
            dlog("UIListContentConfiguration.Ex: \(exContent)")
            let vc = LXSampleTextViewVC()
            vc.dataFill(content: "\(exContent)")
            return vc
        })),
        .subitem(.section(title: "UIBackgroundConfiguration.Ex.allCases"), scene: .vc(provider: {
            let exBg = UIBackgroundConfiguration.Ex.allCases
            dlog("UIBackgroundConfiguration.Ex: \(exBg)")
            let vc = LXSampleTextViewVC()
            vc.dataFill(content: "\(exBg)")
            return vc
        })),
    ])
    static let router3rd: LXOutlineOpt = .outline(.section(title: "FloatingPanel"), subitems: [
        .subitem(.section(title: "Maps"), scene: .vc(provider: {
            /// @objc(MainMapsVC)
            let bundle = Bundle.XL.bundle(for: FloatingPanel_Maps.MainViewController.self, bundleName: "FloatingPanel_Maps.bundle")
            let sb = UIStoryboard(name: "Main", bundle: bundle)
            var vc = sb.instantiateInitialViewController()
            if let nav = vc as? UINavigationController {
                vc = nav.topViewController
            }
            return vc
        })),
        .subitem(.section(title: "Maps-SwiftUI"), scene: .vc(provider: {
            let vc = UIHostingController(rootView: MapsEx(), ignoresKeyboard: true)
            return vc
        })),
        .subitem(.section(title: "Samples"), scene: .vc(provider: {
            /// @objc(MainSamplesVC)
            let bundle = Bundle.XL.bundle(for: FloatingPanel_Samples.MainViewController.self, bundleName: "FloatingPanel_Samples.bundle")
            let sb = UIStoryboard(name: "Main", bundle: bundle)
            // let vc = sb.instantiateViewController(withClass: MainViewController.self)
            // let vc2 = sb.instantiateViewController(identifier: "MainViewController")
            // return sb.instantiateInitialViewController()
            var vc = sb.instantiateInitialViewController()
            if let nav = vc as? UINavigationController {
                vc = nav.topViewController
            }
            return vc
        })),
        .subitem(.section(title: "SamplesObjC"), scene: .vc(provider: {
            /// NS_SWIFT_NAME(MainSamplesObjCVC)
            let bundle = Bundle.XL.bundle(for: FloatingPanel_SamplesObjC.MainViewController.self, bundleName: "FloatingPanel_SamplesObjC.bundle")
            let sb = UIStoryboard(name: "Main", bundle: bundle)
            var vc = sb.instantiateInitialViewController()
            if let nav = vc as? UINavigationController {
                vc = nav.topViewController
            }
            return vc
        })),
        .subitem(.section(title: "Stocks"), scene: .vc(provider: {
            /// @objc(MainStocksVC)
            let bundle = Bundle.XL.bundle(for: FloatingPanel_Stocks.MainViewController.self, bundleName: "FloatingPanel_Stocks.bundle")
            let sb = UIStoryboard(name: "Main", bundle: bundle)
            var vc = sb.instantiateInitialViewController()
            if let nav = vc as? UINavigationController {
                vc = nav.topViewController
            }
            return vc
        })),
    ])
}
