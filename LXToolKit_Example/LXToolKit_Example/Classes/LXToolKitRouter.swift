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
    static let kitRouter: LXOutlineOpt = .outline(title: "LXToolKit_Example", subitems: [
        .subitem(title: "LXToolKit_Example", scene: .vc(provider: { LXToolKitTestVC() })),
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
    static let routerSwiftDaily: LXOutlineOpt = .outline(title: "Swift Daily", subitems: [
        .subitem(title: "DJSwiftTestCaseVC", scene: .vc(provider: { DJSwiftTestCaseVC() })),
        .subitem(title: "DJSwiftTestCaseVC", scene: .vc(provider: { DJSwiftTestCaseVC() })),
        .subitem(title: "LXRxSwiftTestVC", scene: .vc(provider: { LXRxSwiftTestVC(vm: LXBaseVM(), navigator: Navigator.default) })),
    ].reversed())
    static let router2023: LXOutlineOpt = .outline(title: "2023", subitems: [
        .subitem(title: "LX03_08_03VC", scene: .vc(provider: { LX03_08_03VC() })),
        .subitem(title: "LXApiTestVC", scene: .vc(provider: { LXApiTestVC() })),
        .subitem(title: "LXHandyJSONTestVC", scene: .vc(provider: { () -> UIViewController? in
            let vm = LXFloatTestVM()
            let vc = LXHandyJSONTestVC(vm: vm, navigator: Navigator.default)
            return vc
        })),
        .subitem(title: "LXWebVC", scene: .vc(provider: { LXWebVC() })),
        .subitem(title: "LXStrenchableWebVC", scene: .vc(provider: { LXStrenchableWebVC(vm: LXBaseVM(), navigator: Navigator.default) })),
        .subitem(title: "LXLabelVC", scene: .vc(provider: { LXLabelVC() })),
        .subitem(title: "LXActionSheetTestVC", scene: .vc(provider: { LXActionSheetTestVC() })),
        .subitem(title: "LXTableTestVC", scene: .vc(provider: { LXTableTestVC(vm: LXBaseVM(), navigator: Navigator.default) })),
        .subitem(title: "LXCollectionVC", scene: .vc(provider: { LXCollectionVC() })),
    ].reversed())
    static let routerWWWDC: LXOutlineOpt = .outline(title: "WWDC", subitems: [
        .subitem(title: "LXAttributedStringVC", scene: .vc(provider: { LXAttributedStringVC() })),
    ].reversed())
    static let routerMVVM: LXOutlineOpt = .outline(title: "MVVM", subitems: [
        .subitem(title: "baidu.com", scene: .openURL(url: URL(string: "http://baidu.com"))),
        .subitem(title: "baidu.com", scene: .openURL(url: URL(string: "http://baidu.com"))),
        .subitem(title: "baidu.com(inWebView)", scene: .openURL(url: URL(string: "http://baidu.com"), inWebView: true)),
        // .subitem(title: "DJHomeTabBarVM", scene: .tabs(vm: DJHomeTabBarVM(authorized: false))),
        .subitem(title: "DJHomeTabBarVC + UISplitViewController", scene: .vc(provider: {
            let keyWindow = UIApplication.XL.keyWindow
            Application.shared.presentInitialScreen(in: keyWindow)
            return nil
        })),
        .subitem(title: "LXMVVMSampleVC", scene: .vc(provider: { LXMVVMSampleVC() })),
        .subitem(title: "HomeViewController", scene: .vc(provider: { HomeViewController() })),
        .subitem(title: "LXAttributedStringVC", scene: .vc(provider: { LXAttributedStringVC() })),
    ].reversed())
    static let router2022: LXOutlineOpt = .outline(title: "2022", subitems: [
        .subitem(title: "LXTable0120VC", scene: .vc(provider: { LXTable0120VC(vm: LXBaseVM(), navigator: Navigator.default) })),
        // .LXiOS15ButtonTestVC,
        .subitem(title: "LXiOS15VC", scene: .vc(provider: { LXiOS15VC(vm: LXBaseVM(), navigator: Navigator.default) })),
        .subitem(title: "LXMasonryTestVCVC", scene: .vc(provider: { LXMasonryTestVCVC(vm: LXBaseVM(), navigator: Navigator.default) })),
        // .login(vm: LXLoginVM(with: provider)),
        // .events(vm: LXEventsVM(with: .user(user: User()), provider: provider)),
        .subitem(title: "LXWebViewTestVC", scene: .vc(provider: { LXWebViewTestVC(vm: LXBaseVM(), navigator: Navigator.default) })),
        .subitem(title: "LXLoggerTestVC", scene: .vc(provider: { LXLoggerTestVC() })),
        .subitem(title: "LXYYLabelMoreTestVC", scene: .vc(provider: { LXYYLabelMoreTestVC(vm: LXBaseVM(), navigator: Navigator.default) })),
        .subitem(title: "RxNetworksTestVC", scene: .vc(provider: { RxNetworksTestVC() })),
        // .HomeViewController(viewModel: vm),
        // .test(vm: vm),
        // .tabs(vm: vm as! DJHomeTabBarVM),
    ].reversed())
    static let router2021: LXOutlineOpt = .outline(title: "2021", subitems: [
        .subitem(title: "LX0114VC", scene: .vc(provider: { LX0114VC() })),
        // .LXPhotoAlbumVC,
        .subitem(title: "LXPickerVC", scene: .vc(provider: { LXPickerVC() })),
        .subitem(title: "ExampleViewController", scene: .vc(provider: { ExampleViewController() })),
        .subitem(title: "LX0117VC", scene: .vc(provider: { LX0117VC() })),
        .subitem(title: "LXClsListVC", scene: .vc(provider: { LXClsListVC() })),
        .subitem(title: "LXCubeVC", scene: .vc(provider: { LXCubeVC() })),
        .subitem(title: "LXRx0225VC", scene: .vc(provider: { LXRx0225VC() })),
        .subitem(title: "LX0324EventsVC", scene: .vc(provider: { LX0324EventsVC() })),
        .subitem(title: "LXNestedTableVC", scene: .vc(provider: { LXNestedTableVC() })),
        .subitem(title: "LXTableTestVC", scene: .vc(provider: { LXTableTestVC() })),
        .subitem(title: "LX1019TestVC", scene: .vc(provider: { LX1019TestVC() })),
        .subitem(title: "LXHugTestVC", scene: .vc(provider: { LXHugTestVC() })),
        .subitem(title: "LXStack1206VC", scene: .vc(provider: { LXStack1206VC() })),
    ].reversed())
    static let router2020: LXOutlineOpt = .outline(title: "2020", subitems: [
        .subitem(title: "LXMultiRequestTestVC", scene: .vc(provider: { LXMultiRequestTestVC() })),
        .subitem(title: "LXOffScreenVC", scene: .vc(provider: { LXOffScreenVC() })),
        .subitem(title: "LXResolveIMPVC", scene: .vc(provider: { LXResolveIMPVC() })),
        .subitem(title: "LXRequiredVC", scene: .vc(provider: { LXRequiredVC() })),
        .subitem(title: "LXRequiredVC1", scene: .vc(provider: { LXRequiredVC1() })),
        .subitem(title: "LXTransitionVC", scene: .vc(provider: { LXTransitionVC() })),
        .subitem(title: "LXProxyTestVC", scene: .vc(provider: { LXProxyTestVC() })),
        .subitem(title: "LXTestStringVC", scene: .vc(provider: { LXTestStringVC() })),
        .subitem(title: "LXPresentVC", scene: .vc(provider: { LXPresentVC() })),
        .subitem(title: "LXTestVC", scene: .vc(provider: { LXTestVC() })),
        .subitem(title: "LXStackViewVC", scene: .vc(provider: { LXStackViewVC() })),
        .subitem(title: "LXWikipediaImageSearchVC", scene: .vc(provider: { LXWikipediaImageSearchVC() })),
        .subitem(title: "LXStackTestVC", scene: .vc(provider: { LXStackTestVC() })),
        .subitem(title: "LXButtonTestVC", scene: .vc(provider: { LXButtonTestVC() })),
        .subitem(title: "LXImageTestVC", scene: .vc(provider: { LXImageTestVC() })),
        .subitem(title: "LXDaily1117VC", scene: .vc(provider: { LXDaily1117VC() })),
        .subitem(title: "LXKingfisherVC", scene: .vc(provider: { LXKingfisherVC() })),
        .subitem(title: "LXStackMessageVC", scene: .vc(provider: { LXStackMessageVC() })),
        .subitem(title: "LXLockTestVC", scene: .vc(provider: { LXLockTestVC() })),
        .subitem(title: "LXTTTTT", scene: .vc(provider: { LXTTTTT() })),
        .subitem(title: "LXMusicVC", scene: .vc(provider: { LXMusicVC() })),
        .subitem(title: "LXSongVC", scene: .vc(provider: { LXSongVC() })),
        .subitem(title: "LXLightedVC", scene: .vc(provider: { LXLightedVC() })),
    ].reversed())
}
