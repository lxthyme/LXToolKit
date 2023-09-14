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

extension Navigator {
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
            // dlog("-->hashValue: \(identifier)")
        }
        public static func == (lhs: LXToolKit.Navigator.Scene, rhs: LXToolKit.Navigator.Scene) -> Bool {
            switch(lhs, rhs) {
            case let (lhs, rhs):
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
        case test(vm: LXBaseVM)
        case vc(vc: UIViewController.Type)
        case vcString(vcString: String)
        case vm(vc: LXBaseVC.Type, vm: LXBaseVM)
        // !!!: WWDC
        // !!!: MVVM
        case tabs2
        case tabs(vm: DJHomeTabBarVM)
    }

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
            return vc.init(vm: vm, navigator: self)
            // return vc.init()
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

    // MARK: - invoke a single segue
    func show(segue: Scene, sender: UIViewController?, transition: Transition = .navigation(type: .cover(direction: .left))) {
        if let target = get(segue: segue) {
            show(target: target, sender: sender, transition: transition)
        }
    }
}

// MARK: - 👀
extension Navigator.Scene {
    var info: (title: String, desc: String) {
        var tmp: (title: String, desc: String)
        switch self {
        case .safari(let url):
            tmp = (title: "safari", desc: "\(url.absoluteString)")
        case .safariController:
            tmp = (title: "safariController", desc: "")
            // !!!: Swift Daily
            // !!!: 2023
            // !!!: 2022
            // !!!: 2021
            // !!!: 2020
            // Demo
        case .test:
            tmp = (title: "test", desc: "---")
            // !!!: WWDC
            // !!!: MVVM
        case .tabs2:
            tmp = (title: "DJHomeTabBarVC + UISplitViewController", desc: "---")
        case .tabs:
            tmp = (title: "DJHomeTabBarVC", desc: "---")
        case .vc(vc: let vc): tmp = (title: "\(NSStringFromClass(vc).components(separatedBy: ".").last ?? "NaN")", desc: "---")
        case .vcString(let vcString): tmp = (title: vcString, desc: "---")
        case .vm(let vc, _): tmp = (title: "\(NSStringFromClass(vc).components(separatedBy: ".").last ?? "NaN"))", desc: "---")
        }
        return tmp
    }
}
