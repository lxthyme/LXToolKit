//
//  Navigatable.swift
//  test
//
//  Created by lxthyme on 2023/3/23.
//

import Foundation
import Hero
import MessageUI
import LXToolKit

// public protocol Navigatable {
//     var navigator: Navigator { get set }
// }

extension Navigator {
    enum Scene {
        case test(vm: LXBaseVM)
        case tabs(vm: DJHomeTabBarVM)
    }
}
extension Navigator {
// open class Navigator {
//     static var `default` = Navigator()
//
//     enum Transition {
//         case root(in: UIWindow)
//         case navigation(type: HeroDefaultAnimationType)
//         case customModal(type: HeroDefaultAnimationType)
//         case modal
//         case detail
//         case alert
//         case custom
//     }

    func get(segue: Scene) -> UIViewController? {
        switch segue {
        case .test:
            let vc = UIViewController()
            vc.view.backgroundColor = .red
            return vc
        case .tabs(vm: let vm):
            let rootVC = DJHomeTabBarVC(vm: vm, navigator: self)
            let detailVC = DJInitialSplitVC(vm: vm, navigator: self)
            let splitVC = UISplitViewController()
            splitVC.viewControllers = [rootVC , detailVC]
            return splitVC
        }
    }

    // func pop(sender: UIViewController?, toRoot: Bool = false) {
    //     if toRoot {
    //         sender?.navigationController?.popToRootViewController(animated: true)
    //     } else {
    //         sender?.navigationController?.popViewController()
    //     }
    // }
    //
    // func dismiss(sender: UIViewController?) {
    //     sender?.navigationController?.dismiss(animated: true)
    // }
    //
    func show(segue: Scene, sender: UIViewController?, transition: Transition = .navigation(type: .cover(direction: .left))) {
        if let target = get(segue: segue) {
            show(target: target, sender: sender, transition: transition)
        }
    }
    //
    // private func show(target: UIViewController, sender: UIViewController?, transition: Transition) {
    //     switch transition {
    //     case .root(in: let window):
    //         UIView.transition(with: window,
    //                           duration: 0.5,
    //                           options: .transitionFlipFromLeft) {
    //             window.rootViewController = target
    //         }
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
    //         nav.pushViewController(target, animated: false)
    //         return
    //     }
    //
    //     switch transition {
    //     case .navigation(let type):
    //         if let nav = sender.navigationController {
    //             nav.hero.navigationAnimationType = .autoReverse(presenting: type)
    //             nav.pushViewController(target, animated: true)
    //         }
    //     case .customModal(let type):
    //         DispatchQueue.main.async {
    //             let nav = UINavigationController(rootViewController: target)
    //             nav.hero.modalAnimationType = .autoReverse(presenting: type)
    //             sender.present(nav, animated: true)
    //         }
    //     case .modal:
    //         DispatchQueue.main.async {
    //             let nav = UINavigationController(rootViewController: target)
    //             sender.present(nav, animated: true)
    //         }
    //     case .detail:
    //         DispatchQueue.main.async {
    //             let nav = UINavigationController(rootViewController: target)
    //             nav.showDetailViewController(nav, sender: nil)
    //         }
    //     case .alert:
    //         DispatchQueue.main.async {
    //             sender.present(target, animated: true)
    //         }
    //     default: break
    //     }
    // }
    //
    // func toInviteContact(withPhone phone: String) -> MFMessageComposeViewController {
    //     let vc = MFMessageComposeViewController()
    //     vc.body = "Hey! Come join SwiftHub at \(AppConfig.App.githubUrl)"
    //     vc.recipients = [phone]
    //     return vc
    // }
}
