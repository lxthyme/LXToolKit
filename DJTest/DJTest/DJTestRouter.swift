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
import Hover

public struct DJTestRouter {
    static let expandedSectionList: [LXOutlineItem] = [
        DJTestRouter.routerDJTest,
        DJTestRouter.routerFlutter,
    ]
    static let routerItemCustom: (_ title: String) -> LXOutlineItem = { title in LXOutlineItem(opt: .subitem(.section(title: "Item Custom \(title)"))) }
    static let routerItem: LXOutlineItem = LXOutlineItem(opt: .subitem(.section(title: "Item 1: - 1")))
    static let router233: LXOutlineItem = LXOutlineItem(opt: .outline(.section(title: "Section 1")), subitems: [
        LXOutlineItem(opt: .subitem(.section(title: "Item 1 - 1"))),
        LXOutlineItem(opt: .outline(.section(title: "Section 2")), subitems: [
            LXOutlineItem(opt: .subitem(.section(title: "Item 2 - 1"))),
            LXOutlineItem(opt: .outline(.section(title: "Section 3")), subitems: [
                LXOutlineItem(opt: .subitem(.section(title: "Item 3 - 1"))),
                LXOutlineItem(opt: .outline(.section(title: "Section 4")), subitems: [
                    LXOutlineItem(opt: .subitem(.section(title: "Item 4 - 1"))),
                    LXOutlineItem(opt: .subitem(.section(title: "Item 4 - 2"))),
                ]),
                LXOutlineItem(opt: .subitem(.section(title: "Item 3 - 2"))),
            ]),
            LXOutlineItem(opt: .subitem(.section(title: "Item 2 - 2"))),
            LXOutlineItem(opt: .outline(.section(title: "Section 3.2")), subitems: [
                LXOutlineItem(opt: .subitem(.section(title: "Item 3.2 - 1"))),
                LXOutlineItem(opt: .outline(.section(title: "Section 4.2")), subitems: [
                    LXOutlineItem(opt: .subitem(.section(title: "Item 4.2 - 1"))),
                    LXOutlineItem(opt: .subitem(.section(title: "Item 4.2 - 2"))),
                ]),
                LXOutlineItem(opt: .subitem(.section(title: "Item 3.2 - 2"))),
            ]),
            LXOutlineItem(opt: .subitem(.section(title: "Item 2 - 3"))),
        ]),
        LXOutlineItem(opt: .subitem(.section(title: "Item 1 - 2"))),
    ])
    static let routerDebug: () -> LXOutlineItem = {
        let autoPinned = DaoJiaConfig.LocalKey.autoPinnedDaoJiaSection
        let local = autoPinned.getValue()
        let title: (_ v: String?) -> String = { v in "Auto Pinned DaoJia Section[\(v == "1")]" }
        return LXOutlineItem(opt: .outline(.section(title: "Debug")), subitems: [
            LXOutlineItem(opt: .subitem(.section(title: title(local))), scene: .vc(provider: {
                let local = autoPinned.getValue()
                let tmp = local == "1" ? "0" : "1"
                autoPinned.setValue(tmp)
                UIViewController.getTopVC()?.view.makeToast(title(tmp))
                return nil
            })),
            LXOutlineItem(opt: .subitem(.section(title: "ViewController")), scene: .vc(provider: { UINavigationController(rootViewController: ViewController()) }, transition: .root(in: UIApplication.XL.keyWindow! ))),
            LXOutlineItem(opt: .subitem(.section(title: "LXFirstVC")), scene: .vc(provider: { UINavigationController(rootViewController: LXFirstVC()) }, transition: .root(in: UIApplication.XL.keyWindow! )))
        ])
    }

    static let routerDJSwiftModule: LXOutlineItem = LXOutlineItem(opt: .subitem(.section(title: "DJSwiftModule")), scene: .vc(provider: {
        DJAutoRouter.router1.updateRouter(section: .section(title: "DJSwiftModule"))
        DJAutoRouter.router2.clearRouter()
        let window = UIApplication.XL.keyWindow
        Application.shared.presentInitialScreen(in: window)
        return nil
    }))
    static let routerDynamicIsland: LXOutlineItem = LXOutlineItem(opt: .outline(.section(title: "Dynamic Island")), subitems: [
        LXOutlineItem(opt: .subitem(.section(title: "dynamicIsland")), scene: .vc(provider: {
        if #available(iOS 16.2, *) {
            return UIHostingController(rootView: EmojiRangersView())
        } else {
            // Fallback on earlier versions
            let vc = LXSampleTextViewVC()
            vc.dataFillUnSupport(content: "当前设备不支持灵动岛!")
            return vc
        }
    })),
        LXOutlineItem(opt: .subitem(.section(title: "LXDynamicLandVC")), scene: .vc(provider: {
            guard #available(iOS 16.2, *) else {
                let vc = LXSampleTextViewVC()
                vc.dataFillUnSupport(content: "iOS 14.0 Dynamic Land Extension Demo VC")
                return vc
            }
            return LXDynamicLandVC()
        })),
    ])
    static let routerDJTest: LXOutlineItem = LXOutlineItem(opt: .outline(.section(title: "DJTest")), subitems: [
        LXOutlineItem(opt: .subitem(.section(title: "LXAMapTestVC")), scene: .vc(provider: { LXAMapTestVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXOutlineVC")), scene: .vc(provider: {
            if #available(iOS 14.0, *) {
                LXOutlineVC()
            } else {
                // Fallback on earlier versions
                nil
            }
        })),
        LXOutlineItem(opt: .subitem(.section(title: "UIListContentConfiguration.Ex.allCases")), scene: .vc(provider: {
            let vc = LXSampleListVC()
            if #available(iOS 14.0, *) {
                let exContent = UIListContentConfiguration.Ex.allCases
                    .map { LXSampleItem(title: $0.title, attributedContent: LXSampleItem.makeAttribute(from: $0.description)) }
                dlog("UIListContentConfiguration.Ex: \(exContent)")
                // let vc = LXSampleTextViewVC()
                // vc.dataFill(content: "\(exContent)")
                vc.dataFill(list: exContent)
            }
            return vc
        })),
        LXOutlineItem(opt: .subitem(.section(title: "UIBackgroundConfiguration.Ex.allCases")), scene: .vc(provider: {
            let vc = LXSampleListVC()
            if #available(iOS 14.0, *) {
                let exBg = UIBackgroundConfiguration.Ex.allCases
                    .map { LXSampleItem(title: $0.title, attributedContent: LXSampleItem.makeAttribute(from: $0.description)) }
                dlog("UIBackgroundConfiguration.Ex: \(exBg)")
                // let vc = LXSampleTextViewVC()
                // vc.dataFill(content: "\(exBg)")
                vc.dataFill(list: exBg)
            }
            return vc
        })),
        LXOutlineItem(opt: .subitem(.section(title: "CharacterSet.Ex.allCases")), scene: .vc(provider: {
            let exContent = CharacterSet.Ex
                .allCases
                // .urlSet
                .flatMap { item in
                    var idx = 0
                    let list = item.format()
                    let count = list.count
                    return list
                        .map { item2 in
                            idx += 1
                            return LXSampleItem(title: "\(item.title) - \(idx)/\(count)", content: "\(item2)")
                        }
                }
            dlog("CharacterSet.Ex: \(exContent)")
            let vc = LXSampleListVC()
            vc.dataFill(list: exContent)
            return vc
        })),
        // LXOutlineItem(opt: .subitem(.section(title: "LXTableTest202403VC")), scene: .vc(provider: {
        //     if #available(iOS 14.0, *) {
        //         return LXTableTest202403VC()
        //     } else {
        //         // Fallback on earlier versions
        //         let vc = LXSampleTextViewVC()
        //         vc.dataFillUnSupport(content: "UnSupport Diffable DataSource")
        //         return vc
        //     }
        // })),
    ])
    static let routerDJ: () -> LXOutlineItem = {
        let shopList = [
        "env, storeCode, storeType:",
        "///",
        "sit/007780/2020",
        "prd/004517/2010",
        "prd/003754/2010",
        ].joined(separator:", ")
        let goodDetailList = [
            "env, 特征, storeCode, goodsId, tdType:",
            "sit/单菜谱/007780/1365613/0",
            "sit/多菜谱/007780/168251/0",
            "sit/搭配购/007780/68171/0",
            "sit/单菜谱/007780/3364200/2",
            "prd/test/007780/3364200/2",
        ].joined(separator:", ")
        return LXOutlineItem(opt: .outline(.section(title: "DJBusinessModule(\(DJRouter.getCurrentEnv().title))")), subitems: [
            LXOutlineItem(opt: .subitem(.section(title: "Toggle Env")), scene: .vc(provider: {
                DJRouter.toggleEnv();
                return nil
            })),
            LXOutlineItem(opt: .subitem(.section(title: "DJTabbarViewController")), scene: .vc(provider: {
                let vc = DJRouter.getMain()!
                return DJTestRouter.createNav(rootVC: vc) {
                    DJSavedData.saveGStore()
                    DJSavedData.saveLoginInfo()
                }
            }, transition: .alert)),
            LXOutlineItem(opt: .subitem(.section(title: "\(DJRouterPath.getMain.title):\(shopList)"))),
            LXOutlineItem(opt: .outline(.section(title: "Page List")), subitems: [
            LXOutlineItem(opt: .subitem(.section(title: "DJQuickHomeVC")), scene: .vc(provider: {
                let vc = DJRouterObjc.getQuickHome()
                return DJTestRouter.createNav(rootVC: vc) {
                    DJSavedData.saveGStore()
                    DJSavedData.saveLoginInfo()
                }
            }, transition: .alert)),
            LXOutlineItem(opt: .subitem(.section(title: "\(DJRouterPath.goodsDetail.title):\(goodDetailList)"))),
            ]),
            LXOutlineItem(opt: .subitem(.section(title: "save login & gStore info to local")), scene: .vc(provider: {
                DJSavedData.saveGStore()
                DJSavedData.saveLoginInfo()
                return nil
            })),
            LXOutlineItem(opt: .subitem(.section(title: "backup login & gStore info from local")), scene: .vc(provider: {
                DJSavedData.backupGStore()
                DJSavedData.backupLogInfo()
                return nil
            })),
            LXOutlineItem(opt: .subitem(.section(title: "backup login & gStore info from string")), scene: .vc(provider: {
                let json = ""
                if json.isNotEmpty {
                    DJSavedData.backupToLocalStorage(localInfo: json)
                    dlog("--->json: \(json)")
                } else {
                    dlog("--> 请先手动设置 json")
                }
                return nil
            })),
            LXOutlineItem(opt: .subitem(.section(title: "[All Env]show gStore info")), scene: .vc(provider: {
                let obj = DJSavedData.showCurrentLocalInfo()
                let sit: CTServiceAPIEnviroment = .develop
                let prd: CTServiceAPIEnviroment = .release
                let sitObj = obj[.develop]
                let prdObj = obj[.release]
                let sitUserInfoItem = LXSampleItem(title: "\(sit.title).userInfo", content: sitObj?.userInfo?.jsonString(prettify: true))
                let sitPlusInfoItem = LXSampleItem(title: "\(sit.title).plusInfo", content: sitObj?.plusInfo?.jsonString(prettify: true))
                let sitStoreInfoItem = LXSampleItem(title: "\(sit.title).storeInfo", content: sitObj?.storeInfo?.jsonString(prettify: true))
                let prdUserInfoItem = LXSampleItem(title: "\(prd.title).userInfo", content: prdObj?.userInfo?.jsonString(prettify: true))
                let prdPlusInfoItem = LXSampleItem(title: "\(prd.title).plusInfo", content: prdObj?.plusInfo?.jsonString(prettify: true))
                let prdStoreInfoItem = LXSampleItem(title: "\(prd.title).storeInfo", content: prdObj?.storeInfo?.jsonString(prettify: true))
                let vc = LXSampleListVC()
                vc.dataFill(list: [
                    sitUserInfoItem, sitPlusInfoItem, sitStoreInfoItem,
                    prdUserInfoItem, prdPlusInfoItem, prdStoreInfoItem,
                ])
                return vc
            })),
            LXOutlineItem(opt: .subitem(.section(title: "show current login context")), scene: .vc(provider: {
                let obj = DJSavedData.showCurrentContextInfo()
                let sitItem = LXSampleItem(title: "sit", content: obj.sit.jsonString(prettify: true))
                let prdItem = LXSampleItem(title: "prd", content: obj.prd.jsonString(prettify: true))
                let vc = LXSampleListVC()
                vc.dataFill(list: [sitItem, prdItem])
                return vc
            })),
        ])
    }
    static let router3rd: LXOutlineItem = LXOutlineItem(opt: .outline(.section(title: "3rd")), subitems: [
        LXOutlineItem(opt: .subitem(.section(title: "Fatal Error Test")), scene: .vc(provider: {
            fatalError("test")
        })),
        LXOutlineItem(opt: .subitem(.section(title: "FloatingPanel Maps")), scene: .vc(provider: {
            return MapsEntry.entryVC()
        })),
        LXOutlineItem(opt: .subitem(.section(title: "FloatingPanel Maps-SwiftUI")), scene: .vc(provider: {
            if #available(iOS 14.0, *) {
            let vc = UIHostingController(rootView: MapsSwiftUIEntry(), ignoresKeyboard: true)
            return vc
            } else {
                let vc = LXSampleTextViewVC()
                vc.dataFill(content: "FloatingPanel Maps-SwiftUI")
                return vc
            }
        })),
        LXOutlineItem(opt: .subitem(.section(title: "FloatingPanel Samples")), scene: .vc(provider: {
            return SamplesEntry.entryVC()
        })),
        LXOutlineItem(opt: .subitem(.section(title: "FloatingPanel SamplesObjC")), scene: .vc(provider: {
            return SamplesObjCEntry.entryVC()
        })),
        LXOutlineItem(opt: .subitem(.section(title: "FloatingPanel Stocks")), scene: .vc(provider: {
            return StocksEntry.entryVC()
        })),
        LXOutlineItem(opt: .subitem(.section(title: "RxNetworks")), scene: .vc(provider: {
            return RxNetworksEntry.entryVC()
        })),
    ])
    static let routerFlutter: LXOutlineItem = LXOutlineItem(opt: .outline(.section(title: "Flutter")), subitems: [
        // LXOutlineItem(opt: .subitem(.section(title: "Cookbook")), scene: .vc(provider: {
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
        LXOutlineItem(opt: .subitem(.section(title: "default entrypoint")), scene: .vc(provider: {
            let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .default, channelName: .default)
            return DJTestRouter.createNav(rootVC: vc)
        }, transition: .alert)),
        LXOutlineItem(opt: .subitem(.section(title: "Gallery App")), scene: .vc(provider: {
            let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .galleryApp, channelName: .default)
            return DJTestRouter.createNav(rootVC: vc)
        }, transition: .alert)),
        LXOutlineItem(opt: .subitem(.section(title: "GSY App")), scene: .vc(provider: {
            let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .gsyDefault, channelName: .default)
            return DJTestRouter.createNav(rootVC: vc)
        }, transition: .alert)),
        LXOutlineItem(opt: .subitem(.section(title: "entry point switch")), scene: .vc(provider: {
            let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .switch, channelName: .default)
            return DJTestRouter.createNav(rootVC: vc)
        }, transition: .alert)),
        LXOutlineItem(opt: .subitem(.section(title: "FlutterUnit")), scene: .vc(provider: {
            let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .flutterUnit, channelName: .default)
            return DJTestRouter.createNav(rootVC: vc)
        }, transition: .alert)),
        LXOutlineItem(opt: .outline(.section(title: "GSY Pages")), subitems: [
            LXOutlineItem(opt: .subitem(.section(title: "home")), scene: .vc(provider: {
                let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .gsyHome, channelName: .default)
                return DJTestRouter.createNav(rootVC: vc)
            }, transition: .alert)),
            LXOutlineItem(opt: .subitem(.section(title: "login")), scene: .vc(provider: {
                let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .gsyLogin, channelName: .default)
                return DJTestRouter.createNav(rootVC: vc)
            }, transition: .alert)),
            LXOutlineItem(opt: .subitem(.section(title: "asset test")), scene: .vc(provider: {
                let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .gsyAssetTest, channelName: .default)
                return DJTestRouter.createNav(rootVC: vc)
            }, transition: .alert)),
        ]),
        LXOutlineItem(opt: .outline(.section(title: "Gallery Pages")), subitems: [
            LXOutlineItem(opt: .outline(.section(title: "Daily")), subitems: [
                LXOutlineItem(opt: .subitem(.section(title: "MyScaffold")), scene: .vc(provider: {
                    let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .daily_MyScaffold, channelName: .default)
                    return DJTestRouter.createNav(rootVC: vc)
                }, transition: .alert)),
                LXOutlineItem(opt: .subitem(.section(title: "TutorialHome")), scene: .vc(provider: {
                    let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .daily_TutorialHome, channelName: .default)
                    return DJTestRouter.createNav(rootVC: vc)
                }, transition: .alert)),
                LXOutlineItem(opt: .subitem(.section(title: "MyButton")), scene: .vc(provider: {
                    let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .daily_MyButton, channelName: .default)
                    return DJTestRouter.createNav(rootVC: vc)
                }, transition: .alert)),
                LXOutlineItem(opt: .subitem(.section(title: "Counter")), scene: .vc(provider: {
                    let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .daily_Counter, channelName: .default)
                    return DJTestRouter.createNav(rootVC: vc)
                }, transition: .alert)),
                LXOutlineItem(opt: .subitem(.section(title: "Multi Counter")), scene: .vc(provider: {
                    let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .daily_MultiCounter, channelName: .multiCounter)
                    return DJTestRouter.createNav(rootVC: vc)
                }, transition: .alert)),
            ]),
            LXOutlineItem(opt: .outline(.section(title: "Material")), subitems: [
                LXOutlineItem(opt: .subitem(.section(title: "应用栏")), scene: .vc(provider: {
                    let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .demo_app_bar, channelName: .default)
                    return DJTestRouter.createNav(rootVC: vc)
                }, transition: .alert)),
            ]),
            LXOutlineItem(opt: .outline(.section(title: "Cupertino")), subitems: [
                LXOutlineItem(opt: .subitem(.section(title: "活动指示器")), scene: .vc(provider: {
                    let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .demo_cupertino_activity_indicator, channelName: .default)
                    return DJTestRouter.createNav(rootVC: vc)
                }, transition: .alert)),
                LXOutlineItem(opt: .subitem(.section(title: "提醒")), scene: .vc(provider: {
                    let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .demo_cupertino_alert, channelName: .default)
                    return DJTestRouter.createNav(rootVC: vc)
                }, transition: .alert)),
            ]),
            LXOutlineItem(opt: .outline(.section(title: "样式演示和其他演示")), subitems: [
                LXOutlineItem(opt: .subitem(.section(title: "TwoPane")), scene: .vc(provider: {
                    let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .demo_two_pane, channelName: .default)
                    return DJTestRouter.createNav(rootVC: vc)
                }, transition: .alert)),
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
    static func createNav(rootVC: UIViewController, dismiss:(() -> Void)? = nil) -> UINavigationController {
        let config = HoverConfiguration(image: UIImage(named: "Hover"), color: .gradient(top: .blue, bottom: .cyan))
        let menuList: [HoverItem] = [
            HoverItem(image: UIImage(systemName: "xmark"), onTap: {
                dismiss?()
                let topVC = UIViewController.topViewController()
                topVC?.dismiss(animated: true)
            })
        ]
        let hoverView = HoverView(with: config, items: menuList)
        let nav = UINavigationController(rootViewController: rootVC)
        nav.modalPresentationStyle = .fullScreen
        nav.isNavigationBarHidden = true
        nav.interactivePopGestureRecognizer?.isEnabled = true
        nav.view.addSubview(hoverView)
        hoverView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        return nav
    }
}
