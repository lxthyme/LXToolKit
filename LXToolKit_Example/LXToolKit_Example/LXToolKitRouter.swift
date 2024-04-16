//
//  LXToolKitRouter.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/11/21.
//

import Foundation
import LXToolKit
import DJTestKit
import SwifterSwift

public struct LXToolKitRouter {}

// MARK: - 👀
public extension LXToolKitRouter {
    static let kitRouter: LXOutlineItem = LXOutlineItem(opt: .outline(.section(title: "LXToolKit_Example")), subitems: [
        LXOutlineItem(opt: .subitem(.section(title: "LXToolKitTestVC")), scene: .vc(provider: { LXToolKitTestVC() })),
        LXToolKitRouter.routerSwiftDaily,
        LXToolKitRouter.router2024,
        LXToolKitRouter.router2023,
        LXToolKitRouter.routerWWWDC,
        LXToolKitRouter.routerMVVM,
        LXToolKitRouter.router2022,
        LXToolKitRouter.router2021,
        LXToolKitRouter.router2020,
    ])
}
// MARK: - 🔐
internal extension LXToolKitRouter {
    static let routerSwiftDaily: LXOutlineItem = LXOutlineItem(opt: .outline(.section(title: "Swift Daily")), subitems: [
        LXOutlineItem(opt: .subitem(.section(title: "DJSwiftTestCaseVC(1)")), scene: .vc(provider: { DJSwiftTestCaseVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "DJSwiftTestCaseVC(2)")), scene: .vc(provider: { DJSwiftTestCaseVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXRxSwiftTestVC(3)")), scene: .vc(provider: { LXRxSwiftTestVC(vm: LXBaseVM(), navigator: Navigator.default) })),
    ].reversed())
    static let router2024: LXOutlineItem = LXOutlineItem(opt: .outline(.section(title: "2024")), subitems: [
        LXOutlineItem(opt: .subitem(.section(title: "LXTestVC202401")), scene: .vc(provider: { LXTestVC202401() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXTestListCycleVC")), scene: .vc(provider: { LXTestListCycleVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXStackTest202404VC")), scene: .vc(provider: { LXStackTest202404VC() })),
    ]);
    static let router2023: LXOutlineItem = LXOutlineItem(opt: .outline(.section(title: "2023")), subitems: [
        LXOutlineItem(opt: .subitem(.section(title: "LX03_08_03VC")), scene: .vc(provider: { LX03_08_03VC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXApiTestVC")), scene: .vc(provider: { LXApiTestVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXHandyJSONTestVC")), scene: .vc(provider: { () -> UIViewController? in
            let vm = LXFloatTestVM()
            let vc = LXHandyJSONTestVC(vm: vm, navigator: Navigator.default)
            return vc
        })),
        LXOutlineItem(opt: .subitem(.section(title: "LXWebVC")), scene: .vc(provider: { LXWebVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXStrenchableWebVC")), scene: .vc(provider: { LXStrenchableWebVC(vm: LXBaseVM(), navigator: Navigator.default) })),
        LXOutlineItem(opt: .subitem(.section(title: "LXLabelVC")), scene: .vc(provider: { LXLabelVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXActionSheetTestVC")), scene: .vc(provider: { LXActionSheetTestVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXTableTestVC")), scene: .vc(provider: { LXTableTestVC(vm: LXBaseVM(), navigator: Navigator.default) })),
        LXOutlineItem(opt: .subitem(.section(title: "LXCollectionVC")), scene: .vc(provider: { LXCollectionVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXAccessoryListVC")), scene: .vc(provider: {
            if #available(iOS 16.0, *) {
                return LXAccessoryListVC()
            } else {
                // Fallback on earlier versions
                let vc = LXSampleTextViewVC()
                vc.dataFill(content: "UICellAccessory")
                return vc
            }
        })),
        LXOutlineItem(opt: .subitem(.section(title: "LXActionSheetVC")), scene: .vc(provider: { LXActionSheetVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXPresentrVC")), scene: .vc(provider: {
            if #available(iOS 14.0, *) {
                return LXPresentrVC()
            } else {
                // Fallback on earlier versions
                let vc = LXSampleTextViewVC()
                vc.dataFill(content: "LXPresentrVC")
                return vc
            }
        })),
        LXOutlineItem(opt: .subitem(.section(title: "LXFloatPanelVC")), scene: .vc(provider: { LXFloatPanelVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXSearchVC")), scene: .vc(provider: { LXSearchVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXSearchResultVC")), scene: .vc(provider: { LXSearchResultVC() })),
    ].reversed())
    static let routerWWWDC: LXOutlineItem = LXOutlineItem(opt: .outline(.section(title: "WWDC")), subitems: [
        LXOutlineItem(opt: .subitem(.section(title: "LXAttributedStringVC")), scene: .vc(provider: { LXAttributedStringVC() })),
    ].reversed())
    static let routerMVVM: LXOutlineItem = LXOutlineItem(opt: .outline(.section(title: "MVVM")), subitems: [
        LXOutlineItem(opt: .subitem(.section(title: "baidu.com(1)")), scene: .openURL(url: URL(string: "http://baidu.com"))),
        LXOutlineItem(opt: .subitem(.section(title: "baidu.com(2)")), scene: .openURL(url: URL(string: "http://baidu.com"))),
        LXOutlineItem(opt: .subitem(.section(title: "baidu.com(inWebView)")), scene: .openURL(url: URL(string: "http://baidu.com"), inWebView: true)),
        // LXOutlineItem(opt: .subitem(.section(title: "DJHomeTabBarVM", scene: .tabs(vm: DJHomeTabBarVM(authorized: false))),
        LXOutlineItem(opt: .subitem(.section(title: "DJHomeTabBarVC + UISplitViewController")), scene: .vc(provider: {
            let keyWindow = UIApplication.XL.keyWindow
            Application.shared.presentInitialScreen(in: keyWindow)
            return nil
        })),
        LXOutlineItem(opt: .subitem(.section(title: "LXMVVMSampleVC")), scene: .vc(provider: { LXMVVMSampleVC() })),
        // LXOutlineItem(opt: .subitem(.section(title: "HomeViewController")), scene: .vc(provider: { HomeViewController() })),
        // LXOutlineItem(opt: .subitem(.section(title: "LXAttributedStringVC")), scene: .vc(provider: { LXAttributedStringVC() })),
    ].reversed())
    static let router2022: LXOutlineItem = LXOutlineItem(opt: .outline(.section(title: "2022")), subitems: [
        LXOutlineItem(opt: .subitem(.section(title: "LXTable0120VC")), scene: .vc(provider: { LXTable0120VC(vm: LXBaseVM(), navigator: Navigator.default) })),
        // .LXiOS15ButtonTestVC,
        LXOutlineItem(opt: .subitem(.section(title: "LXiOS15VC")), scene: .vc(provider: { LXiOS15VC(vm: LXBaseVM(), navigator: Navigator.default) })),
        LXOutlineItem(opt: .subitem(.section(title: "LXiOS15ButtonTestVC")), scene: .vc(provider: {
            if #available(iOS 15.0, *) {
                return LXiOS15ButtonTestVC()
            } else {
                // Fallback on earlier versions
                let vc = LXSampleTextViewVC()
                vc.title = "LXiOS15ButtonTestVC UnSupported"
                return vc
            }
        })),
        LXOutlineItem(opt: .subitem(.section(title: "LXMasonryTestVCVC")), scene: .vc(provider: { LXMasonryTestVCVC(vm: LXBaseVM(), navigator: Navigator.default) })),
        // .login(vm: LXLoginVM(with: provider)),
        // .events(vm: LXEventsVM(with: .user(user: User()), provider: provider)),
        LXOutlineItem(opt: .subitem(.section(title: "LXWebViewTestVC")), scene: .vc(provider: { LXWebViewTestVC(vm: LXBaseVM(), navigator: Navigator.default) })),
        LXOutlineItem(opt: .subitem(.section(title: "LXLoggerTestVC")), scene: .vc(provider: { LXLoggerTestVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXYYLabelMoreTestVC")), scene: .vc(provider: { LXYYLabelMoreTestVC(vm: LXBaseVM(), navigator: Navigator.default) })),
        // LXOutlineItem(opt: .subitem(.section(title: "RxNetworksTestVC")), scene: .vc(provider: { RxNetworksTestVC() })),
        // .HomeViewController(viewModel: vm),
        // .test(vm: vm),
        // .tabs(vm: vm as! DJHomeTabBarVM),
    ].reversed())
    static let router2021: LXOutlineItem = LXOutlineItem(opt: .outline(.section(title: "2021")), subitems: [
        LXOutlineItem(opt: .subitem(.section(title: "LX0114VC")), scene: .vc(provider: { LX0114VC() })),
        // .LXPhotoAlbumVC,
        LXOutlineItem(opt: .subitem(.section(title: "LXPickerVC")), scene: .vc(provider: { LXPickerVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "ExampleViewController")), scene: .vc(provider: { ExampleViewController() })),
        LXOutlineItem(opt: .subitem(.section(title: "LX0117VC")), scene: .vc(provider: { LX0117VC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXClsListVC")), scene: .vc(provider: { LXClsListVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXCubeVC")), scene: .vc(provider: { LXCubeVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXRx0225VC")), scene: .vc(provider: { LXRx0225VC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LX0324EventsVC")), scene: .vc(provider: { LX0324EventsVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXNestedTableVC")), scene: .vc(provider: { LXNestedTableVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXTableTestObjcVC")), scene: .vc(provider: { LXTableTestObjCVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LX1019TestVC")), scene: .vc(provider: { LX1019TestVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXHugTestVC")), scene: .vc(provider: { LXHugTestVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXStack1206VC")), scene: .vc(provider: { LXStack1206VC() })),
    ].reversed())
    static let router2020: LXOutlineItem = LXOutlineItem(opt: .outline(.section(title: "2020")), subitems: [
        LXOutlineItem(opt: .subitem(.section(title: "LXMultiRequestTestVC")), scene: .vc(provider: { LXMultiRequestTestVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXOffScreenVC")), scene: .vc(provider: { LXOffScreenVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXResolveIMPVC")), scene: .vc(provider: { LXResolveIMPVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXRequiredVC")), scene: .vc(provider: { LXRequiredVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXRequiredVC1")), scene: .vc(provider: { LXRequiredVC1() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXTransitionVC")), scene: .vc(provider: { LXTransitionVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXProxyTestVC")), scene: .vc(provider: { LXProxyTestVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXTestStringVC")), scene: .vc(provider: { LXTestStringVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXPresentVC")), scene: .vc(provider: { LXPresentVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXTestVC")), scene: .vc(provider: { LXTestVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXStackViewVC")), scene: .vc(provider: { LXStackViewVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXWikipediaImageSearchVC")), scene: .vc(provider: { LXWikipediaImageSearchVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXStackTestVC")), scene: .vc(provider: { LXStackTestVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXButtonTestVC")), scene: .vc(provider: { LXButtonTestVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXImageTestVC")), scene: .vc(provider: { LXImageTestVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXDaily1117VC")), scene: .vc(provider: { LXDaily1117VC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXKingfisherVC")), scene: .vc(provider: { LXKingfisherVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXStackMessageVC")), scene: .vc(provider: { LXStackMessageVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXLockTestVC")), scene: .vc(provider: { LXLockTestVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXTTTTT")), scene: .vc(provider: { LXTTTTT() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXMusicVC")), scene: .vc(provider: { LXMusicVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXSongVC")), scene: .vc(provider: { LXSongVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXLightedVC")), scene: .vc(provider: { LXLightedVC() })),
    ].reversed())
}
