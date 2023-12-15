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
    static let kitRouter: LXOutlineOpt = .outline(.section(title: "LXToolKit_Example"), subitems: [
        .subitem(.section(title: "LXToolKit_Example"), scene: .vc(provider: { LXToolKitTestVC() })),
        LXToolKitRouter.routerSwiftDaily,
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
    static let routerSwiftDaily: LXOutlineOpt = .outline(.section(title: "Swift Daily"), subitems: [
        .subitem(.section(title: "DJSwiftTestCaseVC"), scene: .vc(provider: { DJSwiftTestCaseVC() })),
        .subitem(.section(title: "DJSwiftTestCaseVC"), scene: .vc(provider: { DJSwiftTestCaseVC() })),
        .subitem(.section(title: "LXRxSwiftTestVC"), scene: .vc(provider: { LXRxSwiftTestVC(vm: LXBaseVM(), navigator: Navigator.default) })),
    ].reversed())
    static let router2023: LXOutlineOpt = .outline(.section(title: "2023"), subitems: [
        .subitem(.section(title: "LX03_08_03VC"), scene: .vc(provider: { LX03_08_03VC() })),
        .subitem(.section(title: "LXApiTestVC"), scene: .vc(provider: { LXApiTestVC() })),
        .subitem(.section(title: "LXHandyJSONTestVC"), scene: .vc(provider: { () -> UIViewController? in
            let vm = LXFloatTestVM()
            let vc = LXHandyJSONTestVC(vm: vm, navigator: Navigator.default)
            return vc
        })),
        .subitem(.section(title: "LXWebVC"), scene: .vc(provider: { LXWebVC() })),
        .subitem(.section(title: "LXStrenchableWebVC"), scene: .vc(provider: { LXStrenchableWebVC(vm: LXBaseVM(), navigator: Navigator.default) })),
        .subitem(.section(title: "LXLabelVC"), scene: .vc(provider: { LXLabelVC() })),
        .subitem(.section(title: "LXActionSheetTestVC"), scene: .vc(provider: { LXActionSheetTestVC() })),
        .subitem(.section(title: "LXTableTestVC"), scene: .vc(provider: { LXTableTestVC(vm: LXBaseVM(), navigator: Navigator.default) })),
        .subitem(.section(title: "LXCollectionVC"), scene: .vc(provider: { LXCollectionVC() })),
        .subitem(.section(title: "LXAccessoryListVC"), scene: .vc(provider: {
            if #available(iOS 16.0, *) {
                return LXAccessoryListVC()
            } else {
                // Fallback on earlier versions
                let vc = LXSampleTextViewVC()
                vc.dataFill(content: "UICellAccessory")
                return vc
            }
        })),
        LXOutlineOpt.subitem(.section(title: "LXActionSheetVC"), scene: .vc(provider: { LXActionSheetVC() })),
        LXOutlineOpt.subitem(.section(title: "LXPresentrVC"), scene: .vc(provider: { LXPresentrVC() })),
        LXOutlineOpt.subitem(.section(title: "LXFloatPanelVC"), scene: .vc(provider: { LXFloatPanelVC() })),
        LXOutlineOpt.subitem(.section(title: "LXSearchVC"), scene: .vc(provider: { LXSearchVC() })),
        LXOutlineOpt.subitem(.section(title: "LXSearchResultVC"), scene: .vc(provider: { LXSearchResultVC() })),
    ].reversed())
    static let routerWWWDC: LXOutlineOpt = .outline(.section(title: "WWDC"), subitems: [
        .subitem(.section(title: "LXAttributedStringVC"), scene: .vc(provider: { LXAttributedStringVC() })),
    ].reversed())
    static let routerMVVM: LXOutlineOpt = .outline(.section(title: "MVVM"), subitems: [
        .subitem(.section(title: "baidu.com"), scene: .openURL(url: URL(string: "http://baidu.com"))),
        .subitem(.section(title: "baidu.com"), scene: .openURL(url: URL(string: "http://baidu.com"))),
        .subitem(.section(title: "baidu.com(inWebView)"), scene: .openURL(url: URL(string: "http://baidu.com"), inWebView: true)),
        // .subitem(.section(title: "DJHomeTabBarVM", scene: .tabs(vm: DJHomeTabBarVM(authorized: false))),
        .subitem(.section(title: "DJHomeTabBarVC + UISplitViewController"), scene: .vc(provider: {
            let keyWindow = UIApplication.XL.keyWindow
            Application.shared.presentInitialScreen(in: keyWindow)
            return nil
        })),
        .subitem(.section(title: "LXMVVMSampleVC"), scene: .vc(provider: { LXMVVMSampleVC() })),
        .subitem(.section(title: "HomeViewController"), scene: .vc(provider: { HomeViewController() })),
        .subitem(.section(title: "LXAttributedStringVC"), scene: .vc(provider: { LXAttributedStringVC() })),
    ].reversed())
    static let router2022: LXOutlineOpt = .outline(.section(title: "2022"), subitems: [
        .subitem(.section(title: "LXTable0120VC"), scene: .vc(provider: { LXTable0120VC(vm: LXBaseVM(), navigator: Navigator.default) })),
        // .LXiOS15ButtonTestVC,
        .subitem(.section(title: "LXiOS15VC"), scene: .vc(provider: { LXiOS15VC(vm: LXBaseVM(), navigator: Navigator.default) })),
        .subitem(.section(title: "LXMasonryTestVCVC"), scene: .vc(provider: { LXMasonryTestVCVC(vm: LXBaseVM(), navigator: Navigator.default) })),
        // .login(vm: LXLoginVM(with: provider)),
        // .events(vm: LXEventsVM(with: .user(user: User()), provider: provider)),
        .subitem(.section(title: "LXWebViewTestVC"), scene: .vc(provider: { LXWebViewTestVC(vm: LXBaseVM(), navigator: Navigator.default) })),
        .subitem(.section(title: "LXLoggerTestVC"), scene: .vc(provider: { LXLoggerTestVC() })),
        .subitem(.section(title: "LXYYLabelMoreTestVC"), scene: .vc(provider: { LXYYLabelMoreTestVC(vm: LXBaseVM(), navigator: Navigator.default) })),
        .subitem(.section(title: "RxNetworksTestVC"), scene: .vc(provider: { RxNetworksTestVC() })),
        // .HomeViewController(viewModel: vm),
        // .test(vm: vm),
        // .tabs(vm: vm as! DJHomeTabBarVM),
    ].reversed())
    static let router2021: LXOutlineOpt = .outline(.section(title: "2021"), subitems: [
        .subitem(.section(title: "LX0114VC"), scene: .vc(provider: { LX0114VC() })),
        // .LXPhotoAlbumVC,
        .subitem(.section(title: "LXPickerVC"), scene: .vc(provider: { LXPickerVC() })),
        .subitem(.section(title: "ExampleViewController"), scene: .vc(provider: { ExampleViewController() })),
        .subitem(.section(title: "LX0117VC"), scene: .vc(provider: { LX0117VC() })),
        .subitem(.section(title: "LXClsListVC"), scene: .vc(provider: { LXClsListVC() })),
        .subitem(.section(title: "LXCubeVC"), scene: .vc(provider: { LXCubeVC() })),
        .subitem(.section(title: "LXRx0225VC"), scene: .vc(provider: { LXRx0225VC() })),
        .subitem(.section(title: "LX0324EventsVC"), scene: .vc(provider: { LX0324EventsVC() })),
        .subitem(.section(title: "LXNestedTableVC"), scene: .vc(provider: { LXNestedTableVC() })),
        .subitem(.section(title: "LXTableTestVC"), scene: .vc(provider: { LXTableTestVC() })),
        .subitem(.section(title: "LX1019TestVC"), scene: .vc(provider: { LX1019TestVC() })),
        .subitem(.section(title: "LXHugTestVC"), scene: .vc(provider: { LXHugTestVC() })),
        .subitem(.section(title: "LXStack1206VC"), scene: .vc(provider: { LXStack1206VC() })),
    ].reversed())
    static let router2020: LXOutlineOpt = .outline(.section(title: "2020"), subitems: [
        .subitem(.section(title: "LXMultiRequestTestVC"), scene: .vc(provider: { LXMultiRequestTestVC() })),
        .subitem(.section(title: "LXOffScreenVC"), scene: .vc(provider: { LXOffScreenVC() })),
        .subitem(.section(title: "LXResolveIMPVC"), scene: .vc(provider: { LXResolveIMPVC() })),
        .subitem(.section(title: "LXRequiredVC"), scene: .vc(provider: { LXRequiredVC() })),
        .subitem(.section(title: "LXRequiredVC1"), scene: .vc(provider: { LXRequiredVC1() })),
        .subitem(.section(title: "LXTransitionVC"), scene: .vc(provider: { LXTransitionVC() })),
        .subitem(.section(title: "LXProxyTestVC"), scene: .vc(provider: { LXProxyTestVC() })),
        .subitem(.section(title: "LXTestStringVC"), scene: .vc(provider: { LXTestStringVC() })),
        .subitem(.section(title: "LXPresentVC"), scene: .vc(provider: { LXPresentVC() })),
        .subitem(.section(title: "LXTestVC"), scene: .vc(provider: { LXTestVC() })),
        .subitem(.section(title: "LXStackViewVC"), scene: .vc(provider: { LXStackViewVC() })),
        .subitem(.section(title: "LXWikipediaImageSearchVC"), scene: .vc(provider: { LXWikipediaImageSearchVC() })),
        .subitem(.section(title: "LXStackTestVC"), scene: .vc(provider: { LXStackTestVC() })),
        .subitem(.section(title: "LXButtonTestVC"), scene: .vc(provider: { LXButtonTestVC() })),
        .subitem(.section(title: "LXImageTestVC"), scene: .vc(provider: { LXImageTestVC() })),
        .subitem(.section(title: "LXDaily1117VC"), scene: .vc(provider: { LXDaily1117VC() })),
        .subitem(.section(title: "LXKingfisherVC"), scene: .vc(provider: { LXKingfisherVC() })),
        .subitem(.section(title: "LXStackMessageVC"), scene: .vc(provider: { LXStackMessageVC() })),
        .subitem(.section(title: "LXLockTestVC"), scene: .vc(provider: { LXLockTestVC() })),
        .subitem(.section(title: "LXTTTTT"), scene: .vc(provider: { LXTTTTT() })),
        .subitem(.section(title: "LXMusicVC"), scene: .vc(provider: { LXMusicVC() })),
        .subitem(.section(title: "LXSongVC"), scene: .vc(provider: { LXSongVC() })),
        .subitem(.section(title: "LXLightedVC"), scene: .vc(provider: { LXLightedVC() })),
    ].reversed())
}
