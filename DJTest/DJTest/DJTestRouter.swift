//
//  DJTestRouter.swift
//  LXTest
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
        let getInfoVC: (_ obj: [CTServiceAPIEnviroment: DJLocalInfo]) -> UIViewController = { obj in
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
        }
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
            LXOutlineItem(opt: .subitem(.section(title: "save login & gStore info to keychain & UserDefaults")), scene: .vc(provider: {
                DJSavedData.saveGStore()
                DJSavedData.saveLoginInfo()
                return nil
            })),
            LXOutlineItem(opt: .outline(.section(title: "info from **keychain**")), subitems: [
                LXOutlineItem(opt: .subitem(.section(title: "[keychain]backup login & gStore info")), scene: .vc(provider: {
                    DJSavedData.backupGStore(false)
                    DJSavedData.backupLogInfo(false)
                    return nil
                })),
                LXOutlineItem(opt: .subitem(.section(title: "[keychain][All Env]show login & gStore info")), scene: .vc(provider: {
                    let obj = DJSavedData.showCurrentLocalInfo(false)
                    return getInfoVC(obj)
                })),
            ]),
            LXOutlineItem(opt: .outline(.section(title: "info from **UserDefaults**")), subitems: [
                LXOutlineItem(opt: .subitem(.section(title: "[UserDefaults]backup login & gStore info")), scene: .vc(provider: {
                    DJSavedData.backupGStore(true)
                    DJSavedData.backupLogInfo(true)
                    return nil
                })),
                LXOutlineItem(opt: .subitem(.section(title: "[UserDefaults][All Env]show login & gStore info")), scene: .vc(provider: {
                    let obj = DJSavedData.showCurrentLocalInfo(true)
                    return getInfoVC(obj)
                })),
            ]),
            LXOutlineItem(opt: .subitem(.section(title: "backup login & gStore info from string")), scene: .vc(provider: {
                let json = "{\"sit\":{\"plusInfo\":null,\"userInfo\":{\"realNameLevel\":\"0\",\"isSalesman\":\"1\",\"loginCode\":\"\",\"registerTime\":1629094690237,\"expire_in\":\"2592000\",\"locked_reason\":\"\",\"mobile\":\"18521006314\",\"newRegFlag\":\"0\",\"encode_mobile\":\"ENC.1(ljEbTJFSKR9E01tP1oIT5Q==)\",\"groupIds\":\"\",\"avatarUrl\":\"\",\"member_id\":\"4a23420613f2a2b4f4fb2d12a6feabdd\",\"orgId\":\"3000\",\"idFlag\":\"0\",\"memberLevel\":\"40\",\"nickName\":\"\",\"black_account\":\"0\",\"error_times\":\"0\",\"pwdStrength\":\"1\",\"passportId\":\"\",\"remain_times\":\"3\",\"rawDict\":{\"obj\":\"xtKm69AqR5e3\\/io0s\\/trCEl+VUGc8OHSthk54ChUqEQWEN65kB0YOAJ4+VZB sFTr8t4tQMr9GVYyVYHo\\/okf0P9K51jNp\\/G9QJzlrS2O7aqfCZEGbE2kS6ah 6Z4kbPkaxlYDIubiGiLS4mPvXBLuN8p1SB8CJRZS\\/j0gl953H1N41dcmGHNU \\/vHJNCoY5kuF+PG6JZkjnBAvJaC+tucL1mUgSjZqnZqwWegSLu\\/j4NQ3ZMp5 mrziIqcSf+1xsajOllla2NDsbxwy+Z0zlk0OzOF1JP4xiQjQMmXA++7P2ZXK FcAjv+b2ekUawdwD+ohfk\\/T2lHesZ7ZfUsPgpnZbQe6HxpaFMpymPhUdnnps 2VAFBKbid9V7BFYZF388PrxXfOn75zRJ1Ul5Eg3sUe+htj1HGXw1Rd34ecOD WsiEDg\\/zzDowJxfRMh3B0XFUl3SulwgFlN1LQzL1UfjeeYXEGxIsuj7TrvHa 9NcR25MH0PwoQ42\\/YVUkigcZQSoPntfB5jv+KfSDR\\/HRTmeTH5MYbdFImYUx D3NZvi6UPUk2xfG1oQfz8gz7AU2bGIYCV0dAmDa0HMgHjB9K+RSEMjZXXMe5 ctjLE30lQVDEJXn8dfg6vqwe4+TpPCo7anxmuoLzDox\\/gdlYsNYIofmr9l9S 5qYQi0J+n6sJem0\\/Oenjh4EfssJR8oo+9JAykWCN7FazguSrbakvVczBQvP0 JPh4zBvHyuEDB6HciEQxwKVU08lqfvS+a+0UKcNX92\\/kChjZnVKGk+tYdgzR mvy3AXpa9SrNfYyidQGMkYWkeUTyYSJK6sI2AzYA\\/ER4rwZyX1yt\",\"mobile\":\"18521006314\",\"resCode\":\"00100000\"},\"doudoulevel\":\"109\",\"member_name\":\"185****6314\",\"usable_stat\":\"0\",\"high_risk\":\"0\",\"member_token\":\"4acf40fa4a3f2a41bdcc99db69dd8206f057655e54aeeba4d40c90ad836754f8\",\"shellId\":\"\",\"memberLevelCode\":\"40\",\"encode_memberId\":\"4a23420613f2a2b4f4fb2d12a6feabdd\",\"mediaCephUrl\":\"\",\"need_complete\":\"0\"},\"storeInfo\":{\"classifyShowIndex\":0,\"djHomeSearchStr\":\"\",\"labelColor\":\"#000000\",\"djHomeStyle\":2,\"headerBgColorStr\":\"#FFFFFF\",\"orderSourceCode\":\"1\",\"isChangeNet\":false,\"djModuleType\":1,\"longtitude\":\"121.489972\",\"locationCity\":\"\",\"shopCart_storeModel\":{\"provinceName\":\"\",\"shopBeginTime\":\"\",\"logo\":\"https:\\/\\/img21.st.iblimg.com\\/site-2\\/images\\/store\\/logo\\/2017\\/09\\/1601372813.png\",\"beginTime\":\"\",\"storeId\":\"a8dc67a568b64f4f8e43a767704c7999\",\"sceneId\":\"11000\",\"orderTypes\":\"25,46,1\",\"state\":\"\",\"cityCode\":\"867\",\"shopCode\":\"2020007780ENT23234\",\"districtCode\":\"868\",\"longtitude\":\"121.49\",\"comSid\":\"2000\",\"deliveryTip\":\"\",\"storeType\":\"2020\",\"orderAlias\":\"\",\"addr\":\"四川南路26号门店地址\",\"showDistributeDesc\":\"可配送\",\"merchantId\":\"2020007780ENT23234\",\"storeName\":\"\",\"provinceCode\":\"866\",\"distanceDesc\":\"\",\"showSinceSupport\":\"1\",\"endTime\":\"\",\"distance\":\"208\",\"showNewDelTimeDesc\":\"最快今日9:30送达\",\"longitude\":\"\",\"isDistributeSupport\":\"\",\"shopType\":\"2020\",\"cityName\":\"\",\"shopName\":\"联华超市武宁生活馆馆馆\",\"storeCode\":\"007780\",\"showInvoice\":\"1\",\"districtName\":\"\",\"showFreeLimitDesc\":\"58免首重\",\"shopEndTime\":\"\",\"showDistributeSupport\":\"1\",\"shopId\":\"007780\",\"isSelf\":\"\",\"showSinceDesc\":\"可自提\",\"buttonDesc\":\"\",\"phone\":\"\",\"latitude\":\"31.23\"},\"sendType\":0,\"storeDictionary\":{\"showIndexDelTimeDesc\":\"9:30送达\",\"logo\":\"https:\\/\\/img21.st.iblimg.com\\/site-2\\/images\\/store\\/logo\\/2017\\/09\\/1601372813.png\",\"storeId\":\"a8dc67a568b64f4f8e43a767704c7999\",\"sceneId\":\"11000\",\"shopLatitude\":\"31.23\",\"orderTypes\":\"25,46,1\",\"cityCode\":\"867\",\"f_cellWidth\":165,\"shopCode\":\"2020007780ENT23234\",\"comSid\":\"2000\",\"shopLongitude\":\"121.49\",\"longtitude\":\"121.49\",\"deliveryTip\":\"\",\"orderAlias\":\"\",\"storeType\":\"2020\",\"districtCode\":\"868\",\"addr\":\"四川南路26号门店地址\",\"showDistributeDesc\":\"可配送\",\"merchantId\":\"2020007780ENT23234\",\"provinceCode\":\"866\",\"distanceDesc\":\"\",\"showSinceSupport\":\"1\",\"distance\":\"208\",\"showNewDelTimeDesc\":\"最快今日9:30送达\",\"shopType\":\"2020\",\"shopName\":\"联华超市武宁生活馆馆馆\",\"storeCode\":\"007780\",\"showInvoice\":1,\"showDelTimeDesc\":\"最快今日9:30送达\",\"showFreeLimitDesc\":\"58免首重\",\"showDistributeSupport\":\"1\",\"f_skuCount\":17,\"shopId\":\"007780\",\"showSinceDesc\":\"可自提\",\"latitude\":\"31.23\"},\"isFirstShowClassify\":false,\"bl_ad\":\"\",\"head4FCDefColor\":\"#221D1D\",\"latitude\":\"31.23187\",\"djClassifyHeaderType\":1,\"storeModel\":{\"orderAlias\":\"\",\"longtitude\":\"121.49\",\"showFreeLimitDesc\":\"58免首重\",\"shopType\":\"2020\",\"showSinceDesc\":\"可自提\",\"storeCode\":\"007780\",\"sceneId\":\"11000\",\"showInvoice\":1,\"provinceCode\":\"866\",\"shopCode\":\"2020007780ENT23234\",\"f_cellWidth\":165,\"showSinceSupport\":\"1\",\"distanceDesc\":\"\",\"deliveryTip\":\"\",\"latitude\":\"31.23\",\"comSid\":\"2000\",\"shopName\":\"联华超市武宁生活馆馆馆\",\"showIndexDelTimeDesc\":\"9:30送达\",\"showDistributeDesc\":\"可配送\",\"showDistributeSupport\":\"1\",\"f_skuCount\":17,\"storeId\":\"a8dc67a568b64f4f8e43a767704c7999\",\"distance\":\"208\",\"cityCode\":\"867\",\"districtCode\":\"868\",\"logo\":\"https:\\/\\/img21.st.iblimg.com\\/site-2\\/images\\/store\\/logo\\/2017\\/09\\/1601372813.png\",\"addr\":\"四川南路26号门店地址\",\"showNewDelTimeDesc\":\"最快今日9:30送达\",\"storeType\":\"2020\",\"showDelTimeDesc\":\"最快今日9:30送达\",\"orderTypes\":\"25,46,1\"},\"nearShopListArr\":[],\"isDeveloper\":false,\"sceneId\":\"11000\",\"locationAdress\":\"\",\"sourceValue\":\"1\",\"developerLongtitude\":\"\",\"headType\":1,\"developerLatitude\":\"\",\"currentAddress\":\"友谊大厦涉外商务楼\",\"isDaoJiaApp\":false,\"inStoreStyle\":0,\"shopingCarCount\":\"0\",\"head4FCActiveColor\":\"#EA1616\",\"addressRawDic\":{},\"leaveDJTimeStr\":1712161573.3638291,\"homeSelectTabType\":1,\"shopCart_tdStoreModel\":{\"storeInfo\":{\"provinceName\":\"上海市\",\"shopBeginTime\":\"8:00\",\"logo\":\"\",\"beginTime\":\"\",\"storeId\":\"3e6635bdb03a4745a19aad786872c963\",\"sceneId\":\"\",\"orderTypes\":\"\",\"state\":\"1\",\"cityCode\":\"867\",\"shopCode\":\"20402000211\",\"districtCode\":\"873\",\"longtitude\":\"121.382686\",\"comSid\":\"2000\",\"deliveryTip\":\"\",\"storeType\":\"2040\",\"orderAlias\":\"\",\"addr\":\"真光路1258号\",\"showDistributeDesc\":\"仅支持配送\",\"merchantId\":\"20402000211\",\"storeName\":\"联华云超\",\"provinceCode\":\"866\",\"distanceDesc\":\"\",\"showSinceSupport\":\"0\",\"endTime\":\"\",\"distance\":\"\",\"showNewDelTimeDesc\":\"疫情发货待定现场联华\",\"longitude\":\"\",\"isDistributeSupport\":\"\",\"shopType\":\"\",\"fastHomeMap\":{\"OvernightBeforeMessage\":\"\",\"FreeLimit\":\"\",\"DailyStartTime\":\"\",\"OvernightAfterMessage\":\"\",\"DailyEndTime\":\"\",\"LogisticsStartTime\":\"\",\"DelTime\":\"\",\"LogisticsEndTime\":\"\"},\"cityName\":\"市辖区\",\"shopName\":\"联华云超\",\"storeCode\":\"200021\",\"showInvoice\":\"\",\"districtName\":\"普陀区\",\"showFreeLimitDesc\":\"\",\"shopEndTime\":\"23:00\",\"showDistributeSupport\":\"1\",\"shopId\":\"200021\",\"isSelf\":\"0\",\"showSinceDesc\":\"\",\"buttonDesc\":\"\",\"phone\":\"18516042869\",\"latitude\":\"31.245041\"},\"bdStatus\":\"1\",\"shopCustomField\":{\"searchTabO2oLabel\":\"即时达\",\"searchTabB2cLabel\":\"全城配\",\"searchTabO2oUncheckedIcon\":\"https:\\/\\/Img.iblimg.com\\/resh5-1\\/h5resource\\/xcx\\/images\\/black-tab.png\",\"searchTabO2oDesc\":\"最快30分钟\",\"searchTabB2cDesc\":\"48H内发货\",\"searchTabO2oCheckedIcon\":\"https:\\/\\/Img.iblimg.com\\/resh5-1\\/h5resource\\/xcx\\/images\\/orange-tab.png\"},\"bdStore\":\"0\"}}},\"prd\":{\"userInfo\":{\"groupIds\":\"\",\"locked_reason\":\"\",\"expire_in\":\"2592000\",\"member_name\":\"185****6314\",\"error_times\":\"0\",\"orgId\":\"3000\",\"avatarUrl\":\"\",\"nickName\":\"\",\"doudoulevel\":\"109\",\"member_id\":\"4a23420613f2a2b4f4fb2d12a6feabdd\",\"need_complete\":\"0\",\"realNameLevel\":\"0\",\"mobile\":\"18521006314\",\"black_account\":\"0\",\"encode_mobile\":\"ENC.1(ljEbTJFSKR9E01tP1oIT5Q==)\",\"rawDict\":{\"obj\":\"xtKm69AqR5e3\\/io0s\\/trCEl+VUGc8OHSthk54ChUqEQWEN65kB0YOAJ4+VZB sFTr8t4tQMr9GVYyVYHo\\/okf0P9K51jNp\\/G9QJzlrS2O7aqfCZEGbE2kS6ah 6Z4kbPkaxlYDIubiGiLS4mPvXBLuN8p1SB8CJRZS\\/j0gl953H1N41dcmGHNU \\/vHJNCoY5kuF+PG6JZkjnBAvJaC+tucL1mUgSjZqnZqwWegSLu\\/j4NQ3ZMp5 mrziIqcSf+1xsajOllla2NDsbxwy+Z0zlk0OzOF1JP4xiQjQMmXA++7P2ZXK FcAjv+b2ekUawdwD+ohfk\\/T2lHesZ7ZfUsPgpnZbQe6HxpaFMpymPhUdnnps 2VAFBKbid9V7BFYZF388PrxXfOn75zRJ1Ul5Eg3sUe+htj1HGXw1Rd34ecOD WsiEDg\\/zzDowJxfRMh3B0XFUl3SulwgFlN1LQzL1UfjeeYXEGxIsuj7TrvHa 9NcR25MH0PwoQ42\\/YVUkigcZQSoPntfB5jv+KfSDR\\/HRTmeTH5MYbdFImYUx D3NZvi6UPUk2xfG1oQfz8gz7AU2bGIYCV0dAmDa0HMgHjB9K+RSEMjZXXMe5 ctjLE30lQVDEJXn8dfg6vqwe4+TpPCo7anxmuoLzDox\\/gdlYsNYIofmr9l9S 5qYQi0J+n6sJem0\\/Oenjh4EfssJR8oo+9JAykWCN7FazguSrbakvVczBQvP0 JPh4zBvHyuEDB6HciEQxwKVU08lqfvS+a+0UKcNX92\\/kChjZnVKGk+tYdgzR mvy3AXpa9SrNfYyidQGMkYWkeUTyYSJK6sI2AzYA\\/ER4rwZyX1yt\",\"mobile\":\"18521006314\",\"resCode\":\"00100000\"},\"registerTime\":1629094690237,\"shellId\":\"\",\"passportId\":\"\",\"memberLevel\":\"40\",\"member_token\":\"4acf40fa4a3f2a41bdcc99db69dd8206f057655e54aeeba4d40c90ad836754f8\",\"remain_times\":\"3\",\"isSalesman\":\"1\",\"newRegFlag\":\"0\",\"high_risk\":\"0\",\"memberLevelCode\":\"40\",\"loginCode\":\"\",\"mediaCephUrl\":\"\",\"encode_memberId\":\"4a23420613f2a2b4f4fb2d12a6feabdd\",\"idFlag\":\"0\",\"pwdStrength\":\"1\",\"usable_stat\":\"0\"},\"plusInfo\":null,\"storeInfo\":{\"longtitude\":\"121.489972\",\"nearShopListArr\":[],\"head4FCActiveColor\":\"#EA1616\",\"shopCart_storeModel\":{\"provinceName\":\"\",\"shopBeginTime\":\"\",\"logo\":\"https:\\/\\/img21.st.iblimg.com\\/site-2\\/images\\/store\\/logo\\/2017\\/09\\/1601372813.png\",\"beginTime\":\"\",\"storeId\":\"a8dc67a568b64f4f8e43a767704c7999\",\"sceneId\":\"11000\",\"orderTypes\":\"25,46,1\",\"state\":\"\",\"cityCode\":\"867\",\"shopCode\":\"2020007780ENT23234\",\"districtCode\":\"868\",\"longtitude\":\"121.49\",\"comSid\":\"2000\",\"deliveryTip\":\"\",\"storeType\":\"2020\",\"orderAlias\":\"\",\"addr\":\"四川南路26号门店地址\",\"showDistributeDesc\":\"可配送\",\"merchantId\":\"2020007780ENT23234\",\"storeName\":\"\",\"provinceCode\":\"866\",\"distanceDesc\":\"\",\"showSinceSupport\":\"1\",\"endTime\":\"\",\"distance\":\"208\",\"showNewDelTimeDesc\":\"最快今日9:30送达\",\"longitude\":\"\",\"isDistributeSupport\":\"\",\"shopType\":\"2020\",\"cityName\":\"\",\"shopName\":\"联华超市武宁生活馆馆馆\",\"storeCode\":\"007780\",\"showInvoice\":\"1\",\"districtName\":\"\",\"showFreeLimitDesc\":\"58免首重\",\"shopEndTime\":\"\",\"showDistributeSupport\":\"1\",\"shopId\":\"007780\",\"isSelf\":\"\",\"showSinceDesc\":\"可自提\",\"buttonDesc\":\"\",\"phone\":\"\",\"latitude\":\"31.23\"},\"djHomeSearchStr\":\"\",\"currentAddress\":\"友谊大厦涉外商务楼\",\"addressRawDic\":{},\"djClassifyHeaderType\":1,\"developerLongtitude\":\"\",\"leaveDJTimeStr\":1712161573.3638291,\"storeModel\":{\"orderAlias\":\"\",\"longtitude\":\"121.49\",\"showFreeLimitDesc\":\"58免首重\",\"shopType\":\"2020\",\"showSinceDesc\":\"可自提\",\"storeCode\":\"007780\",\"sceneId\":\"11000\",\"showInvoice\":1,\"provinceCode\":\"866\",\"shopCode\":\"2020007780ENT23234\",\"f_cellWidth\":165,\"showSinceSupport\":\"1\",\"distanceDesc\":\"\",\"deliveryTip\":\"\",\"latitude\":\"31.23\",\"comSid\":\"2000\",\"shopName\":\"联华超市武宁生活馆馆馆\",\"showIndexDelTimeDesc\":\"9:30送达\",\"showDistributeDesc\":\"可配送\",\"showDistributeSupport\":\"1\",\"f_skuCount\":17,\"storeId\":\"a8dc67a568b64f4f8e43a767704c7999\",\"distance\":\"208\",\"cityCode\":\"867\",\"districtCode\":\"868\",\"logo\":\"https:\\/\\/img21.st.iblimg.com\\/site-2\\/images\\/store\\/logo\\/2017\\/09\\/1601372813.png\",\"addr\":\"四川南路26号门店地址\",\"showNewDelTimeDesc\":\"最快今日9:30送达\",\"storeType\":\"2020\",\"showDelTimeDesc\":\"最快今日9:30送达\",\"orderTypes\":\"25,46,1\"},\"sceneId\":\"11000\",\"orderSourceCode\":\"1\",\"isDaoJiaApp\":false,\"headerBgColorStr\":\"#FFFFFF\",\"sendType\":0,\"locationCity\":\"\",\"head4FCDefColor\":\"#221D1D\",\"bl_ad\":\"\",\"locationAdress\":\"\",\"classifyShowIndex\":0,\"isChangeNet\":false,\"latitude\":\"31.23187\",\"developerLatitude\":\"\",\"headType\":1,\"shopCart_tdStoreModel\":{\"storeInfo\":{\"provinceName\":\"上海市\",\"shopBeginTime\":\"8:00\",\"logo\":\"\",\"beginTime\":\"\",\"storeId\":\"3e6635bdb03a4745a19aad786872c963\",\"sceneId\":\"\",\"orderTypes\":\"\",\"state\":\"1\",\"cityCode\":\"867\",\"shopCode\":\"20402000211\",\"districtCode\":\"873\",\"longtitude\":\"121.382686\",\"comSid\":\"2000\",\"deliveryTip\":\"\",\"storeType\":\"2040\",\"orderAlias\":\"\",\"addr\":\"真光路1258号\",\"showDistributeDesc\":\"仅支持配送\",\"merchantId\":\"20402000211\",\"storeName\":\"联华云超\",\"provinceCode\":\"866\",\"distanceDesc\":\"\",\"showSinceSupport\":\"0\",\"endTime\":\"\",\"distance\":\"\",\"showNewDelTimeDesc\":\"疫情发货待定现场联华\",\"longitude\":\"\",\"isDistributeSupport\":\"\",\"shopType\":\"\",\"fastHomeMap\":{\"OvernightBeforeMessage\":\"\",\"FreeLimit\":\"\",\"DailyStartTime\":\"\",\"OvernightAfterMessage\":\"\",\"DailyEndTime\":\"\",\"LogisticsStartTime\":\"\",\"DelTime\":\"\",\"LogisticsEndTime\":\"\"},\"cityName\":\"市辖区\",\"shopName\":\"联华云超\",\"storeCode\":\"200021\",\"showInvoice\":\"\",\"districtName\":\"普陀区\",\"showFreeLimitDesc\":\"\",\"shopEndTime\":\"23:00\",\"showDistributeSupport\":\"1\",\"shopId\":\"200021\",\"isSelf\":\"0\",\"showSinceDesc\":\"\",\"buttonDesc\":\"\",\"phone\":\"18516042869\",\"latitude\":\"31.245041\"},\"bdStatus\":\"1\",\"shopCustomField\":{\"searchTabO2oLabel\":\"即时达\",\"searchTabB2cLabel\":\"全城配\",\"searchTabO2oUncheckedIcon\":\"https:\\/\\/Img.iblimg.com\\/resh5-1\\/h5resource\\/xcx\\/images\\/black-tab.png\",\"searchTabO2oDesc\":\"最快30分钟\",\"searchTabB2cDesc\":\"48H内发货\",\"searchTabO2oCheckedIcon\":\"https:\\/\\/Img.iblimg.com\\/resh5-1\\/h5resource\\/xcx\\/images\\/orange-tab.png\"},\"bdStore\":\"0\"},\"homeSelectTabType\":1,\"isFirstShowClassify\":false,\"djModuleType\":1,\"sourceValue\":\"1\",\"isDeveloper\":false,\"djHomeStyle\":2,\"inStoreStyle\":0,\"storeDictionary\":{\"showIndexDelTimeDesc\":\"9:30送达\",\"logo\":\"https:\\/\\/img21.st.iblimg.com\\/site-2\\/images\\/store\\/logo\\/2017\\/09\\/1601372813.png\",\"storeId\":\"a8dc67a568b64f4f8e43a767704c7999\",\"sceneId\":\"11000\",\"shopLatitude\":\"31.23\",\"orderTypes\":\"25,46,1\",\"cityCode\":\"867\",\"f_cellWidth\":165,\"shopCode\":\"2020007780ENT23234\",\"comSid\":\"2000\",\"shopLongitude\":\"121.49\",\"longtitude\":\"121.49\",\"deliveryTip\":\"\",\"orderAlias\":\"\",\"storeType\":\"2020\",\"districtCode\":\"868\",\"addr\":\"四川南路26号门店地址\",\"showDistributeDesc\":\"可配送\",\"merchantId\":\"2020007780ENT23234\",\"provinceCode\":\"866\",\"distanceDesc\":\"\",\"showSinceSupport\":\"1\",\"distance\":\"208\",\"showNewDelTimeDesc\":\"最快今日9:30送达\",\"shopType\":\"2020\",\"shopName\":\"联华超市武宁生活馆馆馆\",\"storeCode\":\"007780\",\"showInvoice\":1,\"showDelTimeDesc\":\"最快今日9:30送达\",\"showFreeLimitDesc\":\"58免首重\",\"showDistributeSupport\":\"1\",\"f_skuCount\":17,\"shopId\":\"007780\",\"showSinceDesc\":\"可自提\",\"latitude\":\"31.23\"},\"labelColor\":\"#000000\",\"shopingCarCount\":\"0\"}}}"
                guard let data = json.data(using: .utf8),
                      let obj = try? JSONSerialization.jsonObject(with: data,
                                                                  options: [.fragmentsAllowed]) as? [String: Any] else {
                    dlog("--> 请先手动设置 json[1]")
                    return nil
                }
                let sit = obj["sit"] as? [String: Any]
                let prd = obj["prd"] as? [String: Any]
                guard sit != nil || prd != nil else {
                    dlog("--> 请先手动设置 json[2]")
                    return nil
                }
                var localInfo: [CTServiceAPIEnviroment: DJLocalInfo] = [:]
                localInfo[.develop] = DJLocalInfo(localInfo: sit)
                localInfo[.release] = DJLocalInfo(localInfo: prd)
                DJSavedData.backupToLocalStorage(localInfo: localInfo)
                dlog("--->obj: \(obj)")
                return nil
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
