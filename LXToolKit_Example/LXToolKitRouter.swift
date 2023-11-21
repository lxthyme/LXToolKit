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

// MARK: - 👀
public extension Navigator {
    static let kitRouter: LXOutlineOpt = .outline(title: "LXToolKitObjC_Example", subitems: [
        .outline(title: "LXToolKit_Example", subitems: [
            .subitem(title: "LXToolKit_Example", vc: .vc(identifier: UUID().uuidString, vcProvider: { LXToolKitTestVC() })),
        ]),
        LXToolKitTest.routerSwiftDaily,
        LXToolKitTest.router2023,
        LXToolKitTest.routerWWWDC,
        LXToolKitTest.routerMVVM,
        LXToolKitTest.router2022,
        LXToolKitTest.router2021,
        LXToolKitTest.router2020,
    ])
}

struct LXToolKitTest {
    static let routerSwiftDaily: LXOutlineOpt = .outline(title: "Swift Daily", subitems: [
        .subitem(title: "DJSwiftTestCaseVC", vc: .vc(identifier: DJSwiftTestCaseVC.xl.xl_typeName, vcProvider: { DJSwiftTestCaseVC() })),
        .subitem(title: "DJSwiftTestCaseVC", vc: .vc(identifier: DJSwiftTestCaseVC.xl.xl_typeName, vcProvider: { DJSwiftTestCaseVC() })),
        .subitem(title: "LXRxSwiftTestVC", vc: .vc(identifier: LXRxSwiftTestVC.xl.xl_typeName, vcProvider: { LXRxSwiftTestVC(vm: LXBaseVM(), navigator: Navigator.default) })),
    ].reversed())
    static let router2023: LXOutlineOpt = .outline(title: "2023", subitems: [
        .subitem(title: "LX03_08_03VC", vc: .vc(identifier: LX03_08_03VC.xl.xl_typeName, vcProvider: { LX03_08_03VC() })),
        .subitem(title: "LXApiTestVC", vc: .vc(identifier: LXApiTestVC.xl.xl_typeName, vcProvider: { LXApiTestVC() })),
        .subitem(title: "LXHandyJSONTestVC", vc: .vc(identifier: LXHandyJSONTestVC.xl.xl_typeName, vcProvider: { () -> UIViewController? in
            let vm = LXFloatTestVM()
            let vc = LXHandyJSONTestVC(vm: vm, navigator: Navigator.default)
            return vc
        })),
        .subitem(title: "LXWebVC", vc: .vc(identifier: LXWebVC.xl.xl_typeName, vcProvider: { LXWebVC() })),
        .subitem(title: "LXStrenchableWebVC", vc: .vc(identifier: LXStrenchableWebVC.xl.xl_typeName,vcProvider: { LXStrenchableWebVC(vm: LXBaseVM(), navigator: Navigator.default) })),
        .subitem(title: "LXLabelVC", vc: .vc(identifier: LXLabelVC.xl.xl_typeName, vcProvider: { LXLabelVC() })),
        .subitem(title: "LXActionSheetTestVC", vc: .vc(identifier: LXActionSheetTestVC.xl.xl_typeName, vcProvider: { LXActionSheetTestVC() })),
        .subitem(title: "LXTableTestVC", vc: .vc(identifier: LXTableTestVC.xl.xl_typeName, vcProvider: { LXTableTestVC(vm: LXBaseVM(), navigator: Navigator.default) })),
        .subitem(title: "LXCollectionVC", vc: .vc(identifier: LXCollectionVC.xl.xl_typeName, vcProvider: { LXCollectionVC() })),
    ].reversed())
    static let routerWWWDC: LXOutlineOpt = .outline(title: "WWDC", subitems: [
        .subitem(title: "LXAttributedStringVC", vc: .vc(identifier: LXAttributedStringVC.xl.xl_typeName, vcProvider: { LXAttributedStringVC() })),
    ].reversed())
    static let routerMVVM: LXOutlineOpt = .outline(title: "MVVM", subitems: [
        .subitem(title: "baidu.com", vc: .openURL(url: URL(string: "http://baidu.com"))),
        .subitem(title: "baidu.com", vc: .openURL(url: URL(string: "http://baidu.com"))),
        .subitem(title: "baidu.com(inWebView)", vc: .openURL(url: URL(string: "http://baidu.com"), inWebView: true)),
        // .subitem(title: "DJHomeTabBarVM", vc: .tabs(vm: DJHomeTabBarVM(authorized: false))),
        .subitem(title: "DJHomeTabBarVC + UISplitViewController", vc: .vc(identifier: "DJHomeTabBarVC + UISplitViewController", vcProvider: {
            let keyWindow = UIApplication.xl.keyWindow
            Application.shared.presentInitialScreen(in: keyWindow)
            return nil
        })),
        .subitem(title: "LXMVVMSampleVC", vc: .vc(identifier: LXMVVMSampleVC.xl.xl_typeName, vcProvider: { LXMVVMSampleVC() })),
        .subitem(title: "HomeViewController", vc: .vc(identifier: HomeViewController.xl.xl_typeName, vcProvider: { HomeViewController() })),
        .subitem(title: "LXAttributedStringVC", vc: .vc(identifier: LXAttributedStringVC.xl.xl_typeName, vcProvider: { LXAttributedStringVC() })),
    ].reversed())
    static let router2022: LXOutlineOpt = .outline(title: "2022", subitems: [
        .subitem(title: "LXTable0120VC", vc: .vc(identifier: LXTable0120VC.xl.xl_typeName,vcProvider: { LXTable0120VC(vm: LXBaseVM(), navigator: Navigator.default) })),
        // .LXiOS15ButtonTestVC,
        .subitem(title: "LXiOS15VC", vc: .vc(identifier: LXiOS15VC.xl.xl_typeName,vcProvider: { LXiOS15VC(vm: LXBaseVM(), navigator: Navigator.default) })),
        .subitem(title: "LXMasonryTestVCVC", vc: .vc(identifier: LXMasonryTestVCVC.xl.xl_typeName,vcProvider: { LXMasonryTestVCVC(vm: LXBaseVM(), navigator: Navigator.default) })),
        // .login(vm: LXLoginVM(with: provider)),
        // .events(vm: LXEventsVM(with: .user(user: User()), provider: provider)),
        .subitem(title: "LXWebViewTestVC", vc: .vc(identifier: LXWebViewTestVC.xl.xl_typeName,vcProvider: { LXWebViewTestVC(vm: LXBaseVM(), navigator: Navigator.default) })),
        .subitem(title: "LXLoggerTestVC", vc: .vc(identifier: LXLoggerTestVC.xl.xl_typeName, vcProvider: { LXLoggerTestVC() })),
        .subitem(title: "LXYYLabelMoreTestVC", vc: .vc(identifier: LXYYLabelMoreTestVC.xl.xl_typeName, vcProvider: { LXYYLabelMoreTestVC(vm: LXBaseVM(), navigator: Navigator.default) })),
        .subitem(title: "RxNetworksTestVC", vc: .vc(identifier: RxNetworksTestVC.xl.xl_typeName, vcProvider: { RxNetworksTestVC() })),
        // .HomeViewController(viewModel: vm),
        // .test(vm: vm),
        // .tabs(vm: vm as! DJHomeTabBarVM),
    ].reversed())
    static let router2021: LXOutlineOpt = .outline(title: "2021", subitems: [
        .subitem(title: "LX0114VC", vc: .vc(identifier: LX0114VC.xl.xl_typeName, vcProvider: { LX0114VC() })),
        // .LXPhotoAlbumVC,
        .subitem(title: "LXPickerVC", vc: .vc(identifier: LXPickerVC.xl.xl_typeName, vcProvider: { LXPickerVC() })),
        .subitem(title: "ExampleViewController", vc: .vc(identifier: ExampleViewController.xl.xl_typeName, vcProvider: { ExampleViewController() })),
        .subitem(title: "LX0117VC", vc: .vc(identifier: LX0117VC.xl.xl_typeName, vcProvider: { LX0117VC() })),
        .subitem(title: "LXClsListVC", vc: .vc(identifier: LXClsListVC.xl.xl_typeName, vcProvider: { LXClsListVC() })),
        .subitem(title: "LXCubeVC", vc: .vc(identifier: LXCubeVC.xl.xl_typeName, vcProvider: { LXCubeVC() })),
        .subitem(title: "LXRx0225VC", vc: .vc(identifier: LXRx0225VC.xl.xl_typeName, vcProvider: { LXRx0225VC() })),
        .subitem(title: "LX0324EventsVC", vc: .vc(identifier: LX0324EventsVC.xl.xl_typeName, vcProvider: { LX0324EventsVC() })),
        .subitem(title: "LXNestedTableVC", vc: .vc(identifier: LXNestedTableVC.xl.xl_typeName, vcProvider: { LXNestedTableVC() })),
        .subitem(title: "LXTableTestVC", vc: .vc(identifier: LXTableTestVC.xl.xl_typeName, vcProvider: { LXTableTestVC() })),
        .subitem(title: "LX1019TestVC", vc: .vc(identifier: LX1019TestVC.xl.xl_typeName, vcProvider: { LX1019TestVC() })),
        .subitem(title: "LXHugTestVC", vc: .vc(identifier: LXHugTestVC.xl.xl_typeName, vcProvider: { LXHugTestVC() })),
        .subitem(title: "LXStack1206VC", vc: .vc(identifier: LXStack1206VC.xl.xl_typeName, vcProvider: { LXStack1206VC() })),
    ].reversed())
    static let router2020: LXOutlineOpt = .outline(title: "2020", subitems: [
        .subitem(title: "LXMultiRequestTestVC", vc: .vc(identifier: LXMultiRequestTestVC.xl.xl_typeName, vcProvider: { LXMultiRequestTestVC() })),
        .subitem(title: "LXOffScreenVC", vc: .vc(identifier: LXOffScreenVC.xl.xl_typeName, vcProvider: { LXOffScreenVC() })),
        .subitem(title: "LXResolveIMPVC", vc: .vc(identifier: LXResolveIMPVC.xl.xl_typeName, vcProvider: { LXResolveIMPVC() })),
        .subitem(title: "LXRequiredVC", vc: .vc(identifier: LXRequiredVC.xl.xl_typeName, vcProvider: { LXRequiredVC() })),
        .subitem(title: "LXRequiredVC1", vc: .vc(identifier: LXRequiredVC1.xl.xl_typeName, vcProvider: { LXRequiredVC1() })),
        .subitem(title: "LXTransitionVC", vc: .vc(identifier: LXTransitionVC.xl.xl_typeName, vcProvider: { LXTransitionVC() })),
        .subitem(title: "LXProxyTestVC", vc: .vc(identifier: LXProxyTestVC.xl.xl_typeName, vcProvider: { LXProxyTestVC() })),
        .subitem(title: "LXTestStringVC", vc: .vc(identifier: LXTestStringVC.xl.xl_typeName, vcProvider: { LXTestStringVC() })),
        .subitem(title: "LXPresentVC", vc: .vc(identifier: LXPresentVC.xl.xl_typeName, vcProvider: { LXPresentVC() })),
        .subitem(title: "LXTestVC", vc: .vc(identifier: LXTestVC.xl.xl_typeName, vcProvider: { LXTestVC() })),
        .subitem(title: "LXStackViewVC", vc: .vc(identifier: LXStackViewVC.xl.xl_typeName, vcProvider: { LXStackViewVC() })),
        .subitem(title: "LXWikipediaImageSearchVC", vc: .vc(identifier: LXWikipediaImageSearchVC.xl.xl_typeName, vcProvider: { LXWikipediaImageSearchVC() })),
        .subitem(title: "LXStackTestVC", vc: .vc(identifier: LXStackTestVC.xl.xl_typeName, vcProvider: { LXStackTestVC() })),
        .subitem(title: "LXButtonTestVC", vc: .vc(identifier: LXButtonTestVC.xl.xl_typeName, vcProvider: { LXButtonTestVC() })),
        .subitem(title: "LXImageTestVC", vc: .vc(identifier: LXImageTestVC.xl.xl_typeName, vcProvider: { LXImageTestVC() })),
        .subitem(title: "LXDaily1117VC", vc: .vc(identifier: LXDaily1117VC.xl.xl_typeName, vcProvider: { LXDaily1117VC() })),
        .subitem(title: "LXKingfisherVC", vc: .vc(identifier: LXKingfisherVC.xl.xl_typeName, vcProvider: { LXKingfisherVC() })),
        .subitem(title: "LXStackMessageVC", vc: .vc(identifier: LXStackMessageVC.xl.xl_typeName, vcProvider: { LXStackMessageVC() })),
        .subitem(title: "LXLockTestVC", vc: .vc(identifier: LXLockTestVC.xl.xl_typeName, vcProvider: { LXLockTestVC() })),
        .subitem(title: "LXTTTTT", vc: .vc(identifier: LXTTTTT.xl.xl_typeName, vcProvider: { LXTTTTT() })),
        .subitem(title: "LXMusicVC", vc: .vc(identifier: LXMusicVC.xl.xl_typeName, vcProvider: { LXMusicVC() })),
        .subitem(title: "LXSongVC", vc: .vc(identifier: LXSongVC.xl.xl_typeName, vcProvider: { LXSongVC() })),
        .subitem(title: "LXLightedVC", vc: .vc(identifier: LXLightedVC.xl.xl_typeName, vcProvider: { LXLightedVC() })),
    ].reversed())
}


