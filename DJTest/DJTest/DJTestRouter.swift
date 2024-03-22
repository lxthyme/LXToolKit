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
    static let routerDynamicIsland: LXOutlineOpt = .outline(.section(title: "Dynamic Island"), subitems: [
        .subitem(.section(title: "dynamicIsland"), scene: .vc(provider: {
        if #available(iOS 16.2, *) {
            return UIHostingController(rootView: EmojiRangersView())
        } else {
            // Fallback on earlier versions
            let vc = LXSampleTextViewVC()
            vc.dataFillUnSupport(content: "当前设备不支持灵动岛!")
            return vc
        }
    })),
        .subitem(.section(title: "LXDynamicLandVC"), scene: .vc(provider: {
            guard #available(iOS 16.2, *) else {
                let vc = LXSampleTextViewVC()
                vc.dataFillUnSupport(content: "iOS 14.0 Dynamic Land Extension Demo VC")
                return vc
            }
            return LXDynamicLandVC()
        })),
    ])
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
                    .map { LXSampleItem(title: $0.title, attributedContent: LXSampleItem.makeAttribute(from: $0.description)) }
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
                    .map { LXSampleItem(title: $0.title, attributedContent: LXSampleItem.makeAttribute(from: $0.description)) }
                dlog("UIBackgroundConfiguration.Ex: \(exBg)")
                // let vc = LXSampleTextViewVC()
                // vc.dataFill(content: "\(exBg)")
                vc.dataFill(list: exBg)
            }
            return vc
        })),
        .subitem(.section(title: "CharacterSet.Ex.allCases"), scene: .vc(provider: {
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
    ])
    static let routerDJ: () -> LXOutlineOpt = {
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
        return .outline(.section(title: "DJBusinessModule(\(DJRouter.getCurrentEnv().title))"), subitems: [
            .subitem(.section(title: "Toggle Env"), scene: .vc(provider: {
                DJRouter.toggleEnv();
                return nil
            })),
            .subitem(.section(title: "DJTabbarViewController"), scene: .vc(provider: {
                let vc = DJRouter.getMain()!
                return DJTestRouter.createNav(rootVC: vc) {
                    DJSavedData.saveGStore()
                    DJSavedData.saveLoginInfo()
                }
            }, transition: .alert)),
            .subitem(.section(title: "\(DJRouterPath.getMain.title):\(shopList)")),
            .outline(.section(title: "Page List"), subitems: [
            .subitem(.section(title: "DJQuickHomeVC"), scene: .vc(provider: {
                let vc = DJRouterObjc.getQuickHome()
                return DJTestRouter.createNav(rootVC: vc) {
                    DJSavedData.saveGStore()
                    DJSavedData.saveLoginInfo()
                }
            }, transition: .alert)),
            .subitem(.section(title: "\(DJRouterPath.goodsDetail.title):\(goodDetailList)")),
            ]),
            .subitem(.section(title: "save login & gStore info to local"), scene: .vc(provider: {
                DJSavedData.saveGStore()
                DJSavedData.saveLoginInfo()
                return nil
            })),
            .subitem(.section(title: "backup login & gStore info from local"), scene: .vc(provider: {
                DJSavedData.backupGStore()
                DJSavedData.backupLogInfo()
                return nil
            })),
            .subitem(.section(title: "backup login & gStore info from string"), scene: .vc(provider: {
                let json: String? = "{\"sit\":{\"gStore\":{\"djModuleType\":1,\"locationAdress\":\"友谊大厦\",\"inStoreStyle\":0,\"latitude\":\"0\",\"headType\":100,\"orderSourceCode\":\"1\",\"headerBgColorStr\":\"#FF774F\",\"isFirstShowClassify\":false,\"developerLatitude\":\"\",\"shopingCarCount\":\"0\",\"addressRawDic\":{},\"sourceValue\":\"1\",\"djHomeSearchStr\":\"\",\"sendType\":0,\"homeSelectTabType\":1,\"isChangeNet\":false,\"head4FCActiveColor\":\"#EA1616\",\"nearShopListArr\":[],\"longtitude\":\"0\",\"isDeveloper\":false,\"head4FCDefColor\":\"#221D1D\",\"isDaoJiaApp\":false,\"currentAddress\":\"\",\"leaveDJTimeStr\":0,\"djClassifyHeaderType\":1,\"developerLongtitude\":\"\",\"sceneId\":\"11000\",\"bl_ad\":\"\",\"classifyShowIndex\":0,\"labelColor\":\"#000000\",\"djHomeStyle\":0},\"userInfo\":{\"memberLevelCode\":\"40\",\"realNameLevel\":\"0\",\"pwdStrength\":\"1\",\"doudoulevel\":\"109\",\"rawDict\":{\"obj\":\"yB/uE8JBmqZn+yFZ10MU7weSHd8JT8xAGmzpJF87emdSXDsCICMykMpR47gTEWCgiLGjn7Y+UQrMXxa8UCRR8UL8C2Um6/J6BpWXUrYtH+rRTNsqDzUoJc7MX/uf/6gLj1/BAjAWEmcpW0MOJ5ot5cTEJ9rFvBow7q36z0Ld/YKq4Gk19IcAgaqsYxpmVPmMDVRBsTMkhfe7AumOre8009ZQleMSIPvevEHHxfEHPvLTPT1oFCe1MMa5m7+U5XhEEfIuKkeubyUX6Ibb9aPoFTzNtnxSaURAyzVPQkgJX7ZlPr/mV1nMCCeVaxq+x+gge39InDUDhGAP4MBKPFqGbCZ931gOaaPWYIzzKpZJikjeJJjcGZxw5ZtQSgKYlaE+09shLVrf2sAg++7V3XKWof9UKNWks6lWr//xnT8+NotEesSpn2Z1hjTKEGTiso/0Y0SWr/Or4PhrK7UFVHvlKSBgE17g7PoypnnjVClYNuiYy+IpxUzeSkOM43CZgPxFf5+ims4kkEcoFvZTDDHdNuDOF+rpPXJdK5Zhbl8TVaBxY2h49o96kPlQ06LEXO7rIMQOwVGFen+NIUl2FddkoSB8I6kd7J0t6qJzSmPqjyfYwmcCTc1K+XGeaXHPwJd1WqYvOEkWYIi7JD0RTdi0VxnnD3AXDh8GAeGSKHC8d9jNQ4DdMfh2mWWYNR2rRoVpiYGqjRPgu84z2mhXghQ+JaE1rU6Mlg4SBoaVYbgEC6Gh6Cr6uvAIcgrKU1h9CbuOdVeSSFlScSXhaEddXZKVgKfEGS1Qse0gp56N/HbLgGH0pOX8OyzSg/4ObaUt+XFg\",\"resCode\":\"00100000\"},\"memberLevel\":\"40\",\"registerTime\":1629094690237,\"member_id\":\"4a23420613f2a2b4f4fb2d12a6feabdd\",\"expire_in\":\"2592000\",\"encode_mobile\":\"ENC.1(ljEbTJFSKR9E01tP1oIT5Q==)\",\"remain_times\":\"3\",\"mobile\":\"18521006314\",\"newRegFlag\":false,\"usable_stat\":\"0\",\"black_account\":false,\"need_complete\":false,\"idFlag\":\"0\",\"high_risk\":false,\"orgId\":\"3000\",\"encode_memberId\":\"4a23420613f2a2b4f4fb2d12a6feabdd\",\"member_name\":\"185****6314\",\"error_times\":\"0\",\"member_token\":\"4acf40fa4a3f2a41c70c388b750379cdb9f97ea6250cbbaf56683da51e0a88d3\",\"isSalesman\":\"1\"}},\"prd\":{\"gStore\":{\"storeDictionary\":{\"provinceName\":\"上海市\",\"shopBeginTime\":\"08:30\",\"logo\":\"https://img20.iblimg.com/site-2/images/store/2019/07/939951626.jpg\",\"beginTime\":\"08:00\",\"storeId\":\"43f123a4f62647879b9c0af982ff7972\",\"sceneId\":\"11000\",\"orderTypes\":\"25,46,1\",\"state\":\"1\",\"cityCode\":\"867\",\"shopCode\":\"20100045171\",\"comSid\":\"2000\",\"longtitude\":\"121.384011\",\"districtCode\":\"873\",\"deliveryTip\":\"\",\"storeType\":\"2010\",\"orderAlias\":\"\",\"addr\":\"真光路1288号\",\"storeName\":\"世纪联华中环百联店\",\"showDistributeDesc\":\"可配送\",\"provinceCode\":\"866\",\"showSinceSupport\":\"1\",\"distanceDesc\":\"\",\"endTime\":\"21:00\",\"merchantId\":\"20100045171\",\"distance\":\"\",\"showNewDelTimeDesc\":\"最快半小时达\",\"shopType\":\"大卖场\",\"isDistributeSupport\":\"\",\"longitude\":\"\",\"fastHomeMap\":{\"OvernightAfterMessage\":\"欢迎光临，您的订单将在门店营业后即刻配送，由此给您造成的不便，敬请谅解！\",\"DailyStartTime\":\"0:00\",\"OvernightBeforeMessage\":\"欢迎光临，您的订单将在次日门店营业后即刻配送，由此给您造成的不便，敬请谅解！\",\"FreeLimit\":\"58\",\"LogisticsStartTime\":\"8:00\",\"DelTime\":\"1\",\"DailyEndTime\":\"23:59\",\"LogisticsEndTime\":\"22:30\"},\"cityName\":\"市辖区\",\"shopName\":\"世纪联华中环百联店\",\"storeCode\":\"004517\",\"showInvoice\":\"0\",\"districtName\":\"普陀区\",\"showFreeLimitDesc\":\"58免首重\",\"shopEndTime\":\"21:00\",\"showDistributeSupport\":\"1\",\"shopId\":\"004517\",\"isSelf\":\"1\",\"showSinceDesc\":\"可自提\",\"buttonDesc\":\"即时达·最快30分钟\",\"phone\":\"02161392180\",\"latitude\":\"31.246005\"},\"djClassifyHeaderType\":1,\"djModuleType\":1,\"isDeveloper\":false,\"developerLatitude\":\"\",\"head4FCActiveColor\":\"#FFFFFF\",\"addressRawDic\":{},\"tdStoreModel\":{\"bdStore\":\"\",\"bdStatus\":\"\"},\"headerBgColorStr\":\"#FFFFFF\",\"currentAddress\":\"真光路1288号\",\"sendType\":0,\"leaveDJTimeStr\":0,\"developerLongtitude\":\"\",\"isFirstShowClassify\":false,\"inStoreStyle\":0,\"shopingCarCount\":\"0\",\"headType\":5,\"bl_ad\":\"\",\"classifyShowIndex\":0,\"storeModel\":{\"storeType\":\"2010\",\"longtitude\":\"121.384011\",\"showDelTimeDesc\":\"\",\"orderTypes\":\"25,46,1\",\"showSinceDesc\":\"可自提\",\"storeCode\":\"004517\",\"sceneId\":\"11000\",\"f_cellWidth\":0,\"showInvoice\":0,\"shopCode\":\"20100045171\",\"provinceCode\":\"866\",\"deliveryTip\":\"\",\"distanceDesc\":\"\",\"comSid\":\"2000\",\"latitude\":\"31.246005\",\"showDistributeSupport\":\"1\",\"shopName\":\"世纪联华中环百联店\",\"showIndexDelTimeDesc\":\"\",\"showDistributeDesc\":\"可配送\",\"showSinceSupport\":\"1\",\"f_skuCount\":0,\"storeId\":\"43f123a4f62647879b9c0af982ff7972\",\"distance\":\"\",\"cityCode\":\"867\",\"districtCode\":\"873\",\"logo\":\"https://img20.iblimg.com/site-2/images/store/2019/07/939951626.jpg\",\"shopType\":\"大卖场\",\"addr\":\"真光路1288号\",\"showFreeLimitDesc\":\"58免首重\",\"showNewDelTimeDesc\":\"最快半小时达\",\"orderAlias\":\"\"},\"head4FCDefColor\":\"#881407\",\"orderSourceCode\":\"1\",\"locationAdress\":\"友谊大厦\",\"djHomeStyle\":2,\"isChangeNet\":false,\"isDaoJiaApp\":false,\"sceneId\":\"11000\",\"latitude\":\"31.246005\",\"labelColor\":\"#000000\",\"longtitude\":\"121.384011\",\"homeSelectTabType\":1,\"nearShopListArr\":[],\"djHomeSearchStr\":\"\",\"sourceValue\":\"1\"}}}"
                if let json {
                    DJSavedData.backupToLocalStorage(localInfo: json)
                    dlog("--->json: \(json)")
                } else {
                    dlog("--> 请先手动设置 json")
                }
                return nil
            })),
            .subitem(.section(title: "[All Env]show gStore info"), scene: .vc(provider: {
                DJSavedData.showCurrentLocalInfo()
                return nil
            })),
            .subitem(.section(title: "show current context"), scene: .vc(provider: {
                DJSavedData.showCurrentContextInfo()
                return nil
            })),
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
            return DJTestRouter.createNav(rootVC: vc)
        }, transition: .alert)),
        .subitem(.section(title: "Gallery App"), scene: .vc(provider: {
            let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .galleryApp, channelName: .default)
            return DJTestRouter.createNav(rootVC: vc)
        }, transition: .alert)),
        .subitem(.section(title: "GSY App"), scene: .vc(provider: {
            let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .gsyDefault, channelName: .default)
            return DJTestRouter.createNav(rootVC: vc)
        }, transition: .alert)),
        .subitem(.section(title: "entry point switch"), scene: .vc(provider: {
            let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .switch, channelName: .default)
            return DJTestRouter.createNav(rootVC: vc)
        }, transition: .alert)),
        .subitem(.section(title: "FlutterUnit"), scene: .vc(provider: {
            let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .flutterUnit, channelName: .default)
            return DJTestRouter.createNav(rootVC: vc)
        }, transition: .alert)),
        .outline(.section(title: "GSY Pages"), subitems: [
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
        .outline(.section(title: "Gallery Pages"), subitems: [
            .outline(.section(title: "Daily"), subitems: [
                .subitem(.section(title: "MyScaffold"), scene: .vc(provider: {
                    let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .daily_MyScaffold, channelName: .default)
                    return DJTestRouter.createNav(rootVC: vc)
                }, transition: .alert)),
                .subitem(.section(title: "TutorialHome"), scene: .vc(provider: {
                    let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .daily_TutorialHome, channelName: .default)
                    return DJTestRouter.createNav(rootVC: vc)
                }, transition: .alert)),
                .subitem(.section(title: "MyButton"), scene: .vc(provider: {
                    let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .daily_MyButton, channelName: .default)
                    return DJTestRouter.createNav(rootVC: vc)
                }, transition: .alert)),
                .subitem(.section(title: "Counter"), scene: .vc(provider: {
                    let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .daily_Counter, channelName: .default)
                    return DJTestRouter.createNav(rootVC: vc)
                }, transition: .alert)),
                .subitem(.section(title: "Multi Counter"), scene: .vc(provider: {
                    let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .daily_MultiCounter, channelName: .multiCounter)
                    return DJTestRouter.createNav(rootVC: vc)
                }, transition: .alert)),
            ]),
            .outline(.section(title: "Material"), subitems: [
                .subitem(.section(title: "应用栏"), scene: .vc(provider: {
                    let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .demo_app_bar, channelName: .default)
                    return DJTestRouter.createNav(rootVC: vc)
                }, transition: .alert)),
            ]),
            .outline(.section(title: "Cupertino"), subitems: [
                .subitem(.section(title: "活动指示器"), scene: .vc(provider: {
                    let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .demo_cupertino_activity_indicator, channelName: .default)
                    return DJTestRouter.createNav(rootVC: vc)
                }, transition: .alert)),
                .subitem(.section(title: "提醒"), scene: .vc(provider: {
                    let vc: LXFlutterSampleVC = .vcFrom(entrypoint: .demo_cupertino_alert, channelName: .default)
                    return DJTestRouter.createNav(rootVC: vc)
                }, transition: .alert)),
            ]),
            .outline(.section(title: "样式演示和其他演示"), subitems: [
                .subitem(.section(title: "TwoPane"), scene: .vc(provider: {
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
        let btn = UIButton()
        btn.backgroundColor = .XL.randomGolden
        btn.layerCornerRadius = 8
        btn.setTitle("Closed", for: .normal)
        btn.setTitleColor(.XL.randomLight, for: .normal)
        btn.frame = CGRect(x: 150, y: UIApplication.XL.keyWindow?.safeAreaInsets.top ?? 0, width: 80, height: 44)
        // btn.frame = CGRect(x: 150, y: iPhoneX.safeareaInsets.top, width: 80, height: 44)
        if #available(iOS 14.0, *) {
            btn.addAction(UIAction(handler: { _ in
                dismiss?()
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
