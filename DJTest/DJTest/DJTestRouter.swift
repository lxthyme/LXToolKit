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
import RxNetworks_Ex
import LXFlutterKit

public struct DJTestRouter {
    static let expandedSectionList: [LXOutlineOpt] = [
        DJTestRouter.routerDJTest,
        DJTestRouter.routerFlutter,
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
        DJAutoRouter.router1.updateRouter(section: .section(title: "DJSwiftModule"))
        DJAutoRouter.router2.clearRouter()
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
        .subitem(.section(title: "LXOutlineVC"), scene: .vc(provider: {
            if #available(iOS 14.0, *) {
                LXOutlineVC()
            } else {
                // Fallback on earlier versions
                nil
            }
        })),
        .subitem(.section(title: "UIListContentConfiguration.Ex.allCases"), scene: .vc(provider: {
            let vc = LXSampleListVC()
            if #available(iOS 14.0, *) {
                let exContent = UIListContentConfiguration.Ex.allCases
                    .map { LXSampleItem(title: $0.title, content: $0.description) }
                dlog("UIListContentConfiguration.Ex: \(exContent)")
                // let vc = LXSampleTextViewVC()
                // vc.dataFill(content: "\(exContent)")
                vc.dataFill(list: exContent)
            }
            return vc
        })),
        .subitem(.section(title: "UIBackgroundConfiguration.Ex.allCases"), scene: .vc(provider: {
            let vc = LXSampleListVC()
            if #available(iOS 14.0, *) {
                let exBg = UIBackgroundConfiguration.Ex.allCases
                    .map { LXSampleItem(title: $0.title, content: $0.description) }
                dlog("UIBackgroundConfiguration.Ex: \(exBg)")
                // let vc = LXSampleTextViewVC()
                // vc.dataFill(content: "\(exBg)")
                vc.dataFill(list: exBg)
            }
            return vc
        })),
    ])
    static let routerDJ: () -> LXOutlineOpt = {
        return .outline(.section(title: "DJBusinessModule(\(DJEnv.getCurrentEnv()))"), subitems: [
            .subitem(.section(title: "Toggle Env"), scene: .vc(provider: {
                DJRouter.toggleEnv();
                return nil
            })),
            .subitem(.section(title: "DJTabbarViewController"), scene: .vc(provider: {
                let vc = DJRouter.getMain("", storeType: "")
                return DJTestRouter.createNav(rootVC: vc)
            }, transition: .alert)),
            .subitem(.section(title: "\(DJRouterPath.getMain.title):storeCode,storeType://, sit/007780/2020, prd/004517/2010, prd/003754/2010")),
        ])
    }
    static let router3rd: LXOutlineOpt = .outline(.section(title: "3rd"), subitems: [
        .subitem(.section(title: "Fatal Error Test"), scene: .vc(provider: {
            fatalError("test")
        })),
        .subitem(.section(title: "FloatingPanel Maps"), scene: .vc(provider: {
            return MapsEntry.entryVC()
        })),
        .subitem(.section(title: "FloatingPanel Maps-SwiftUI"), scene: .vc(provider: {
            if #available(iOS 14.0, *) {
            let vc = UIHostingController(rootView: MapsSwiftUIEntry(), ignoresKeyboard: true)
            return vc
            } else {
                let vc = LXSampleTextViewVC()
                vc.dataFill(content: "FloatingPanel Maps-SwiftUI")
                return vc
            }
        })),
        .subitem(.section(title: "FloatingPanel Samples"), scene: .vc(provider: {
            return SamplesEntry.entryVC()
        })),
        .subitem(.section(title: "FloatingPanel SamplesObjC"), scene: .vc(provider: {
            return SamplesObjCEntry.entryVC()
        })),
        .subitem(.section(title: "FloatingPanel Stocks"), scene: .vc(provider: {
            return StocksEntry.entryVC()
        })),
        .subitem(.section(title: "RxNetworks"), scene: .vc(provider: {
            return RxNetworksEntry.entryVC()
        })),
    ])
    static let routerFlutter: LXOutlineOpt = .outline(.section(title: "Flutter"), subitems: [
        // .subitem(.section(title: "Cookbook"), scene: .vc(provider: {
        //     // guard let flutterEngine = FlutterManager.shared.flutterEngine else { return nil }
        //     // CrashlyticsManager.setCustomKeysAndValues([
        //     //     "tips": "flutter 异常: \(flutterEngine)",
        //     // ])
        //     // CrashlyticsManager.log(msg: "flutter 异常: \(flutterEngine)")
        //     // let flutterVC = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        //     // CrashlyticsManager.setCustomKeysAndValues([
        //     //     "tips": "flutterVC 异常",
        //     //     "appDelegate": "\(flutterVC)",
        //     // ])
        //     // CrashlyticsManager.log(msg: "flutterVC 异常: \(flutterVC)")
        //     // vc.modalPresentationStyle = .fullScreen
        //     // return vc
        // // })),
        // //     let nav = UINavigationController(rootViewController: flutterVC)
        // //     nav.modalPresentationStyle = .fullScreen
        // //     nav.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", primaryAction: UIAction(handler: { _ in
        // //         nav.dismiss(animated: true)
        // //     }))
        // //     nav.navigationItem.rightBarButtonItems = [
        // //         UIBarButtonItem(title: "返回", primaryAction: UIAction(handler: { _ in
        // //             nav.dismiss(animated: true)
        // //         }))
        // //     ]
        // //     return nav
        // }, transition: .alert)),
        .subitem(.section(title: "default entrypoint"), scene: .vc(provider: {
            let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .default, channelName: .default)
            return vc
        }, transition: .alert)),
        .subitem(.section(title: "Gallery App"), scene: .vc(provider: {
            let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .galleryApp, channelName: .default)
            return vc
        }, transition: .alert)),
        .subitem(.section(title: "GSY App"), scene: .vc(provider: {
            let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .gsyDefault, channelName: .default)
            return DJTestRouter.createNav(rootVC: vc)
        }, transition: .alert)),
        .outline(.section(title: "GSY"), subitems: [
            .subitem(.section(title: "home"), scene: .vc(provider: {
                let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .gsyHome, channelName: .default)
                return DJTestRouter.createNav(rootVC: vc)
            }, transition: .alert)),
            .subitem(.section(title: "login"), scene: .vc(provider: {
                let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .gsyLogin, channelName: .default)
                return DJTestRouter.createNav(rootVC: vc)
            }, transition: .alert)),
            .subitem(.section(title: "asset test"), scene: .vc(provider: {
                let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .gsyAssetTest, channelName: .default)
                return DJTestRouter.createNav(rootVC: vc)
            }, transition: .alert)),
        ]),
        .outline(.section(title: "Pages"), subitems: [
            .outline(.section(title: "Daily"), subitems: [
                .subitem(.section(title: "MyScaffold"), scene: .vc(provider: {
                    let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .daily_MyScaffold, channelName: .default)
                    return vc
                })),
                .subitem(.section(title: "TutorialHome"), scene: .vc(provider: {
                    let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .daily_TutorialHome, channelName: .default)
                    return vc
                })),
                .subitem(.section(title: "MyButton"), scene: .vc(provider: {
                    let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .daily_MyButton, channelName: .default)
                    return vc
                })),
                .subitem(.section(title: "Counter"), scene: .vc(provider: {
                    let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .daily_Counter, channelName: .default)
                    return vc
                })),
                .subitem(.section(title: "Multi Counter"), scene: .vc(provider: {
                    let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .daily_MultiCounter, channelName: .multiCounter)
                    return vc
                })),
            ]),
            .outline(.section(title: "Material"), subitems: [
                .subitem(.section(title: "应用栏"), scene: .vc(provider: {
                    let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .demo_app_bar, channelName: .default)
                    return vc
                })),
            ]),
            .outline(.section(title: "Cupertino"), subitems: [
                .subitem(.section(title: "活动指示器"), scene: .vc(provider: {
                    let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .demo_cupertino_activity_indicator, channelName: .default)
                    return vc
                })),
                .subitem(.section(title: "提醒"), scene: .vc(provider: {
                    let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .demo_cupertino_alert, channelName: .default)
                    return vc
                })),
            ]),
            .outline(.section(title: "样式演示和其他演示"), subitems: [
                .subitem(.section(title: " TwoPane"), scene: .vc(provider: {
                    let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .demo_two_pane, channelName: .default)
                    return vc
                })),
            ]),
        ]),
    ])
}

// MARK: - 🔐
extension DJTestRouter {
    // func delayA(_ dueTime: RxTimeInterval = .milliseconds(1500), block:() -> Void) -> Disposable {
    //     return Observable.just(1)
    //         .delay(dueTime, scheduler: MainScheduler.instance)
    //         .subscribe { result in
    //             dlog("-->result: \(result)")
    //             block()
    //         }
    //         // .disposed(by: rx.disposeBag)
    // }
    static func createNav(rootVC: UIViewController) -> UINavigationController {
        let btn = UIButton()
        btn.backgroundColor = .XL.randomGolden
        btn.layerCornerRadius = 8
        btn.setTitle("Closed", for: .normal)
        btn.setTitleColor(.XL.randomLight, for: .normal)
        btn.frame = CGRect(x: 150, y: UIApplication.XL.keyWindow?.safeAreaInsets.top ?? 0, width: 80, height: 44)
        // btn.frame = CGRect(x: 150, y: iPhoneX.safeareaInsets.top, width: 80, height: 44)
        if #available(iOS 14.0, *) {
            btn.addAction(UIAction(handler: { _ in
                let topVC = UIViewController.topViewController()
                topVC?.dismiss(animated: true)
            }), for: .touchUpInside)
        }
        let nav = UINavigationController(rootViewController: rootVC)
        nav.modalPresentationStyle = .fullScreen
        nav.isNavigationBarHidden = true
        nav.interactivePopGestureRecognizer?.isEnabled = true
        nav.view.addSubview(btn)
        return nav
    }
}
