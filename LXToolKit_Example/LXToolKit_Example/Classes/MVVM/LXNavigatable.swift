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
            switch self {
            case .vc(_, _, _, let uuid),
                    .vcString(_, _, let uuid),
                    .openURL(_, _, _, let uuid),
                    .tabs(_, _, let uuid):
                hasher.combine(uuid)
            }
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
        case openURL(url: URL?, inWebView: Bool = false, transition: Transition = .navigation(type: .cover(direction: .left)), uuid: UUID = UUID())
        case vc(identifier: String = "", vcProvider: () -> UIViewController?, transition: Transition = .navigation(type: .cover(direction: .left)), uuid: UUID = UUID())
        case vcString(vcString: String, transition: Transition = .navigation(type: .cover(direction: .left)), uuid: UUID = UUID())
        case tabs(vm: DJHomeTabBarVM, transition: Transition = .root(in: UIApplication.shared.keyWindow!), uuid: UUID = UUID())
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
        case .openURL(let url, let inWebView, _):
            guard let url else { return nil }

            if inWebView {
                let vc = SFSafariViewController(url: url)
                return vc
            }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            return nil
        case .vc(_, let vcProvider, _): return vcProvider()
        case .vcString(let vcString, _):
            guard let VCCls = NSClassFromString(vcString) as? UIViewController.Type else { return nil }
            return VCCls.init()
        case .tabs(let vm, _):
            let rootVC = DJHomeTabBarVC(vm: vm, navigator: self)
            let detailVC = DJHomeTabBarVC(vm: vm, navigator: self)
            let splitVC = UISplitViewController()
            splitVC.viewControllers = [rootVC , detailVC]
            return splitVC
        }
    }
    // func get(segue: Scene) -> (vc: UIViewController?, transition: Transition) {
    //     switch segue {
    //     case .openURL(let url, let inWebView, _):
    //         guard let url else { return nil }
    //
    //         if inWebView {
    //             let vc = SFSafariViewController(url: url)
    //             return vc
    //         }
    //         UIApplication.shared.open(url, options: [:], completionHandler: nil)
    //         return nil
    //     case .vc(_, let vcProvider, _): return vcProvider()
    //     case .vcString(let vcString, _):
    //         guard let VCCls = NSClassFromString(vcString) as? UIViewController.Type else { return nil }
    //         return VCCls.init()
    //     case .tabs(let vm, _):
    //         let rootVC = DJHomeTabBarVC(vm: vm, navigator: self)
    //         let detailVC = DJHomeTabBarVC(vm: vm, navigator: self)
    //         let splitVC = UISplitViewController()
    //         splitVC.viewControllers = [rootVC , detailVC]
    //         return splitVC
    //     }
    // }

    // MARK: - invoke a single segue
    func show(segue: Scene, sender: UIViewController?) {
        if let target = get(segue: segue) {
            show(target: target, sender: sender, transition: transition)
        }
    }
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
        case .openURL(let url, let inWebView, _):
            tmp = (title: "safari[\(inWebView)]", desc: "\(url?.absoluteString ?? "")")
        case .vc(let identifier, _, _): tmp = (title: "vc: \(identifier)", desc: "---")
        case .vcString(let vcString, _): tmp = (title: vcString, desc: "---")
        case .tabs:
            tmp = (title: "DJHomeTabBarVC", desc: "---")
        }
        return tmp
    }
}
