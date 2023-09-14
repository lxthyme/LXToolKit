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
// import DJSwiftModule
// import DJBusinessModuleSwift

// protocol LXNavigatable {
//     var navigator: LXNavigator { get set }
// }

// open class LXNavigator {
extension Navigator {
    // static var `default` = LXNavigator()

    // MARK: - segues list, all app scenes
    public enum Scene: Hashable {
        public func hash(into hasher: inout Hasher) {
            var identifier = "NaN"
            switch self {
            case .vc(let vc):
                identifier = "vc: \(NSStringFromClass(vc))"
                hasher.combine(identifier)
            case .vm(let vc, let vm):
                identifier = "vm: \(NSStringFromClass(vc))_\(vm.xl.xl_typeName)"
                hasher.combine(identifier)
            case .vcString(let vcString):
                identifier = "vcString: \(vcString)"
                hasher.combine(identifier)
            case .safari(let url):
                identifier = "safari: \(url.absoluteString)"
                hasher.combine(identifier)
            case .safariController(let url):
                identifier = "safariController: \(url.absoluteString)"
                hasher.combine(identifier)
            case .test(vm: let vm):
                identifier = "test: \(vm.xl.xl_typeName)"
                hasher.combine(identifier)
            case .tabs2:
                hasher.combine("tabs2")
            case .tabs(vm: let vm):
                identifier = "tabs: \(vm.xl.xl_typeName)"
                hasher.combine(identifier)
            }
            dlog("-->hashValue: \(identifier)")
        }
        public static func == (lhs: LXToolKit.Navigator.Scene, rhs: LXToolKit.Navigator.Scene) -> Bool {
            switch(lhs, rhs) {
            // case (.vc(let lhsVC), .vc(let rhsVC)):
            //     return NSStringFromClass(lhsVC) == NSStringFromClass(rhsVC)
            // case (.vm(let lhsVC, _), .vm(let rhsVC, _)):
            //     return NSStringFromClass(lhsVC) == NSStringFromClass(rhsVC)
            // case (.safari(let url), .safari(let url)):
            case let (lhs, rhs):
                // dlog("-->hashValue: \(lhs.hashValue), \(rhs.hashValue)")
                return lhs.hashValue == rhs.hashValue
            }

        }

        // case tabs(viewModel: HomeTabBarViewModel)
        // case search(viewModel: SearchViewModel)
        // case languages(viewModel: LanguagesViewModel)
        // case users(viewModel: UsersViewModel)
        // case userDetails(viewModel: UserViewModel)
        // case repositories(viewModel: RepositoriesViewModel)
        // case repositoryDetails(viewModel: RepositoryViewModel)
        // case contents(viewModel: ContentsViewModel)
        // case source(viewModel: SourceViewModel)
        // case commits(viewModel: CommitsViewModel)
        // case branches(viewModel: BranchesViewModel)
        // case releases(viewModel: ReleasesViewModel)
        // case pullRequests(viewModel: PullRequestsViewModel)
        // case pullRequestDetails(viewModel: PullRequestViewModel)
        // case events(viewModel: EventsViewModel)
        // case notifications(viewModel: NotificationsViewModel)
        // case issues(viewModel: IssuesViewModel)
        // case issueDetails(viewModel: IssueViewModel)
        // case linesCount(viewModel: LinesCountViewModel)
        // case theme(viewModel: ThemeViewModel)
        // case language(viewModel: LanguageViewModel)
        // case acknowledgements
        // case contacts(viewModel: ContactsViewModel)
        // case whatsNew(block: WhatsNewBlock)
        // case login(vm: LXLoginVM)
        // case events(vm: LXEventsVM)
        case safari(URL)
        case safariController(URL)
        // !!!: 2020
        // !!!: 2021
        // !!!: 2022
        // !!!: 2023
        // case LXiOS15ButtonTestVC(viewModel: LXBaseVM)
        // case HomeViewController(viewModel: LXBaseVM)
        case test(vm: LXBaseVM)
        case vc(vc: UIViewController.Type)
        case vcString(vcString: String)
        case vm(vc: LXBaseVC.Type, vm: LXBaseVM)
        // !!!: WWDC
        // !!!: MVVM
        case tabs2
        case tabs(vm: DJHomeTabBarVM)
    }

    // enum Transition {
    //     case root(in: UIWindow)
    //     case navigation(type: HeroDefaultAnimationType)
    //     case customModal(type: HeroDefaultAnimationType)
    //     case modal
    //     case detail
    //     case alert
    //     case custom
    // }

    // MARK: - get a single VC
    func get(segue: Scene) -> UIViewController? {
        switch segue {
            // case .tabs(let viewModel):
            //     let rootVC = HomeTabBarController(viewModel: viewModel, navigator: self)
            //     let detailVC = InitialSplitViewController(viewModel: nil, navigator: self)
            //     let detailNavVC = NavigationController(rootViewController: detailVC)
            //     let splitVC = SplitViewController()
            //     splitVC.viewControllers = [rootVC, detailNavVC]
            //     return splitVC
            //
            // case .search(let viewModel): return SearchViewController(viewModel: viewModel, navigator: self)
            // case .languages(let viewModel): return LanguagesViewController(viewModel: viewModel, navigator: self)
            // case .users(let viewModel): return UsersViewController(viewModel: viewModel, navigator: self)
            // case .userDetails(let viewModel): return UserViewController(viewModel: viewModel, navigator: self)
            // case .repositories(let viewModel): return RepositoriesViewController(viewModel: viewModel, navigator: self)
            // case .repositoryDetails(let viewModel): return RepositoryViewController(viewModel: viewModel, navigator: self)
            // case .contents(let viewModel): return ContentsViewController(viewModel: viewModel, navigator: self)
            // case .source(let viewModel): return SourceViewController(viewModel: viewModel, navigator: self)
            // case .commits(let viewModel): return CommitsViewController(viewModel: viewModel, navigator: self)
            // case .branches(let viewModel): return BranchesViewController(viewModel: viewModel, navigator: self)
            // case .releases(let viewModel): return ReleasesViewController(viewModel: viewModel, navigator: self)
            // case .pullRequests(let viewModel): return PullRequestsViewController(viewModel: viewModel, navigator: self)
            // case .pullRequestDetails(let viewModel): return PullRequestViewController(viewModel: viewModel, navigator: self)
            // case .events(let viewModel): return EventsViewController(viewModel: viewModel, navigator: self)
            // case .notifications(let viewModel): return NotificationsViewController(viewModel: viewModel, navigator: self)
            // case .issues(let viewModel): return IssuesViewController(viewModel: viewModel, navigator: self)
            // case .issueDetails(let viewModel): return IssueViewController(viewModel: viewModel, navigator: self)
            // case .linesCount(let viewModel): return LinesCountViewController(viewModel: viewModel, navigator: self)
            // case .theme(let viewModel): return ThemeViewController(viewModel: viewModel, navigator: self)
            // case .language(let viewModel): return LanguageViewController(viewModel: viewModel, navigator: self)
            // case .acknowledgements: return AcknowListViewController()
            // case .contacts(let viewModel): return ContactsViewController(viewModel: viewModel, navigator: self)
            //
            // case .whatsNew(let block):
            //     if let versionStore = block.2 {
            //         return WhatsNewViewController(whatsNew: block.0, configuration: block.1, versionStore: versionStore)
            //     } else {
            //         return WhatsNewViewController(whatsNew: block.0, configuration: block.1)
            //     }
            //
        case .safari(let url):
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            return nil

        case .safariController(let url):
            let vc = SFSafariViewController(url: url)
            return vc
            // !!!: 2020
            // !!!: 2021
            // !!!: 2022
            // !!!: 2023
        case .test:
            let vc = UIViewController()
            vc.view.backgroundColor = .red
            return vc
        case .vc(let VC): return VC.init()
        case .vcString(let vcString):
            guard let VCCls = NSClassFromString(vcString) as? UIViewController.Type else { return nil }
            return VCCls.init()
        case .vm(let vc, let vm):
            guard vc.isKind(of: LXBaseVC.self) else {
                return nil
            }
            // return vc.init(vm: vm, navigator: self)
            return vc.init()
            // !!!: WWDC
            // !!!: MVVM
        case .tabs(let vm):
            let rootVC = DJHomeTabBarVC(vm: vm, navigator: self)
            let detailVC = DJHomeTabBarVC(vm: vm, navigator: self)
            let splitVC = UISplitViewController()
            splitVC.viewControllers = [rootVC , detailVC]
            return splitVC
        case .tabs2:
            Application.shared.presentInitialScreen(in: Application.shared.window)
            return nil
        }
    }

    // func pop(sender: UIViewController?, toRoot: Bool = false) {
    //     if toRoot {
    //         sender?.navigationController?.popToRootViewController(animated: true)
    //     } else {
    //         sender?.navigationController?.popViewController(animated: true)
    //     }
    // }
    //
    // func dismiss(sender: UIViewController?) {
    //     sender?.navigationController?.dismiss(animated: true, completion: nil)
    // }

    // MARK: - invoke a single segue
    func show(segue: Scene, sender: UIViewController?, transition: Transition = .navigation(type: .cover(direction: .left))) {
        if let target = get(segue: segue) {
            show(target: target, sender: sender, transition: transition)
        }
    }

    // private func show(target: UIViewController, sender: UIViewController?, transition: Transition) {
    //     switch transition {
    //     case .root(in: let window):
    //         UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft, animations: {
    //             window.rootViewController = target
    //         }, completion: nil)
    //         return
    //     case .custom: return
    //     default: break
    //     }
    //
    //     guard let sender = sender else {
    //         fatalError("You need to pass in a sender for .navigation or .modal transitions")
    //     }
    //
    //     if let nav = sender as? UINavigationController {
    //         // push root controller on navigation stack
    //         nav.pushViewController(target, animated: false)
    //         return
    //     }
    //
    //     switch transition {
    //     case .navigation(let type):
    //         if let nav = sender.navigationController {
    //             // push controller to navigation stack
    //             nav.hero.navigationAnimationType = .autoReverse(presenting: type)
    //             nav.pushViewController(target, animated: true)
    //         }
    //     case .customModal(let type):
    //         // present modally with custom animation
    //         DispatchQueue.main.async {
    //             let nav = LXNavigationController(rootViewController: target)
    //             nav.hero.modalAnimationType = .autoReverse(presenting: type)
    //             sender.present(nav, animated: true, completion: nil)
    //         }
    //     case .modal:
    //         // present modally
    //         DispatchQueue.main.async {
    //             let nav = LXNavigationController(rootViewController: target)
    //             sender.present(nav, animated: true, completion: nil)
    //         }
    //     case .detail:
    //         DispatchQueue.main.async {
    //             let nav = LXNavigationController(rootViewController: target)
    //             sender.showDetailViewController(nav, sender: nil)
    //         }
    //     case .alert:
    //         DispatchQueue.main.async {
    //             sender.present(target, animated: true, completion: nil)
    //         }
    //     default: break
    //     }
    // }

    // func toInviteContact(withPhone phone: String) -> MFMessageComposeViewController {
    //     let vc = MFMessageComposeViewController()
    //     vc.body = "Hey! Come join SwiftHub at \(Configs.App.githubUrl)"
    //     vc.recipients = [phone]
    //     return vc
    // }
}

// MARK: - 👀
extension Navigator.Scene {
    var info: (title: String, desc: String) {
        var tmp: (title: String, desc: String)
        switch self {
        case .safari:
            tmp = (title: "", desc: "")
        case .safariController:
            tmp = (title: "", desc: "")
            // Events
            // case .login:
            //     tmp = (title: "LoginVC", desc: "[SwiftHub]")
            // case .events:
            //     tmp = (title: "EventsVC", desc: "[SwiftHub]")
            // !!!: 2020
            // case .LXMultiRequestTestVC: tmp = (title: "LXMultiRequestTestVC", desc: "---")
            // case .LXOffScreenVC: tmp = (title: "LXOffScreenVC", desc: "---")
            // case .LXResolveIMPVC: tmp = (title: "LXResolveIMPVC", desc: "---")
            // case .LXRequiredVC: tmp = (title: "LXRequiredVC", desc: "---")
            // case .LXRequiredVC1: tmp = (title: "LXRequiredVC1", desc: "---")
            // case .LXTransitionVC: tmp = (title: "LXTransitionVC", desc: "---")
            // case .LXProxyTestVC: tmp = (title: "LXProxyTestVC", desc: "---")
            // case .LXTestStringVC: tmp = (title: "LXTestStringVC", desc: "---")
            // case .LXPresentVC: tmp = (title: "LXPresentVC", desc: "---")
            // case .LXTestVC: tmp = (title: "LXTestVC", desc: "---")
            // case .LXStackViewVC: tmp = (title: "LXStackViewVC", desc: "---")
            // case .LXWikipediaImageSearchVC: tmp = (title: "LXWikipediaImageSearchVC", desc: "---")
            // case .LXStackTestVC: tmp = (title: "LXStackTestVC", desc: "---")
            // case .LXButtonTestVC: tmp = (title: "LXButtonTestVC", desc: "---")
            // case .LXImageTestVC: tmp = (title: "LXImageTestVC", desc: "---")
            // case .LXDaily1117VC: tmp = (title: "LXDaily1117VC", desc: "---")
            // case .LXKingfisherVC: tmp = (title: "LXKingfisherVC", desc: "---")
            // case .LXStackMessageVC: tmp = (title: "LXStackMessageVC", desc: "---")
            // case .LXLockTestVC: tmp = (title: "LXLockTestVC", desc: "---")
            // case .LXTTTTT: tmp = (title: "LXTTTTT", desc: "---")
            // case .LXMusicVC: tmp = (title: "LXMusicVC", desc: "---")
            // case .LXSongVC: tmp = (title: "LXSongVC", desc: "---")
            // case .LXLightedVC: tmp = (title: "LXLightedVC", desc: "---")
            // !!!: 2021
            // case .LX0114VC: tmp = (title: "LX0114VC", desc: "---")
            // case .LXPhotoAlbumVC: tmp = (title: "LXPhotoAlbumVC", desc: "---")
            // case .LXPickerVC: tmp = (title: "LXPickerVC", desc: "---")
            // case .ExampleViewController: tmp = (title: "ExampleViewController", desc: "---")
            // case .LX0117VC: tmp = (title: "LX0117VC", desc: "---")
            // case .LXClsListVC: tmp = (title: "LXClsListVC", desc: "---")
            // case .LXCubeVC: tmp = (title: "LXCubeVC", desc: "---")
            // case .LXRx0225VC: tmp = (title: "LXRx0225VC", desc: "---")
            // case .LX0324EventsVC: tmp = (title: "LX0324EventsVC", desc: "---")
            // case .LXNestedTableVC: tmp = (title: "LXNestedTableVC", desc: "---")
            // case .LXTableTestVC: tmp = (title: "LXTableTestVC", desc: "---")
            // case .LX1019TestVC: tmp = (title: "LX1019TestVC", desc: "---")
            // case .LXHugTestVC: tmp = (title: "LXHugTestVC", desc: "---")
            // case .LXStack1206VC: tmp = (title: "LXStack1206VC", desc: "---")
            // !!!: 2022
            // !!!: 2023
            // Demo
        case .test:
            tmp = (title: "test", desc: "---")
            // !!!: WWDC
            // !!!: MVVM
        case .tabs2:
            tmp = (title: "DJHomeTabBarVC + UISplitViewController", desc: "---")
        case .tabs:
            tmp = (title: "DJHomeTabBarVC", desc: "---")
        case .vc(vc: let vc): tmp = (title: "\(NSStringFromClass(vc))", desc: "---")
        case .vcString(let vcString): tmp = (title: vcString, desc: "---")
        case .vm(let vc, _): tmp = (title: "\(NSStringFromClass(vc))", desc: "---")
        }
        return tmp
    }
}
