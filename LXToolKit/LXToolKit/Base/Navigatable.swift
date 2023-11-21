//
//  Navigatable.swift
//  LXToolKit
//
//  Created by lxthyme on 2023/5/10.
//

import Foundation
import Hero
import MessageUI
import SafariServices

public protocol Navigatable {
    var navigator: Navigator { get set }
}

// MARK: - 👀
public extension Navigator {
    // MARK: - segues list, all app scenes
    public enum Scene {
        case openURL(url: URL?, inWebView: Bool = false, transition: Transition = .navigation(type: .cover(direction: .left)))
        case vc(provider: () -> UIViewController?, transition: Transition = .navigation(type: .cover(direction: .left)))
        case vcString(vcString: String, transition: Transition = .navigation(type: .cover(direction: .left)))
        // case tabs(vm: DJHomeTabBarVM, transition: Transition = .root(in: UIApplication.xl.keyWindow!))
    }
}

open class Navigator {
    public static var `default` = Navigator()

    public enum Transition {
        case root(in: UIWindow)
        case navigation(type: HeroDefaultAnimationType)
        case customModal(type: HeroDefaultAnimationType)
        case modal
        case detail
        case alert
        case custom
    }
    func pop(sender: UIViewController?, toRoot: Bool = false) {
        if toRoot {
            sender?.navigationController?.popToRootViewController(animated: true)
        } else {
            sender?.navigationController?.popViewController()
        }
    }

    func dismiss(sender: UIViewController?) {
        sender?.navigationController?.dismiss(animated: true)
    }

    // MARK: - get a single VC
    public func get(segue: Navigator.Scene) -> (UIViewController?, Transition?)? {
        switch segue {
        case .openURL(let url, let inWebView, let transition):
            guard let url else { return nil }

            if inWebView {
                let vc = SFSafariViewController(url: url)
                return (vc, transition)
            }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            return nil
        case .vc(let provider, let transition): return (provider(), transition)
        case .vcString(let vcString, let transition):
            guard let VCCls = NSClassFromString(vcString) as? UIViewController.Type else { return nil }
            return (VCCls.init(), transition)
        // case .tabs(let vm, let transition, _):
        //     let rootVC = DJHomeTabBarVC(vm: vm, navigator: self)
        //     let detailVC = DJHomeTabBarVC(vm: vm, navigator: self)
        //     let splitVC = UISplitViewController()
        //     splitVC.viewControllers = [rootVC , detailVC]
        //     return (splitVC, transition)
        }
    }
    // MARK: - invoke a single segue
    @discardableResult
    public func show(segue: Scene, sender: UIViewController?, transition: Transition = .navigation(type: .cover(direction: .left))) -> UIViewController? {
        guard let (vc, tran) = get(segue: segue),
           let vc else {
               return nil
        }
        show(target: vc,
             sender: sender,
             transition: tran ?? transition)
        return vc
    }

    public func show(target: UIViewController, sender: UIViewController?, transition: Transition) {
        switch transition {
        case .root(in: let window):
            UIView.transition(with: window,
                              duration: 0.5,
                              options: .transitionFlipFromLeft) {
                window.rootViewController = target
            }
            return
        case .custom: return
        default: break
        }

        guard let sender = sender else {
            fatalError("You need to pass in a sender for .navigation or .modal transitions")
        }

        if let nav = sender as? UINavigationController {
            nav.pushViewController(target, animated: false)
            return
        }

        switch transition {
        case .navigation(let type):
            if let nav = sender.navigationController {
                nav.hero.navigationAnimationType = .autoReverse(presenting: type)
                nav.pushViewController(target, animated: true)
            }
        case .customModal(let type):
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: target)
                nav.hero.modalAnimationType = .autoReverse(presenting: type)
                sender.present(nav, animated: true)
            }
        case .modal:
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: target)
                sender.present(nav, animated: true)
            }
        case .detail:
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: target)
                nav.showDetailViewController(nav, sender: nil)
            }
        case .alert:
            DispatchQueue.main.async {
                sender.present(target, animated: true)
            }
        default: break
        }
    }

    func toInviteContact(withPhone phone: String) -> MFMessageComposeViewController {
        let vc = MFMessageComposeViewController()
        // vc.body = "Hey! Come join SwiftHub at \(AppConfig.App.githubUrl)"
        vc.recipients = [phone]
        return vc
    }
}
