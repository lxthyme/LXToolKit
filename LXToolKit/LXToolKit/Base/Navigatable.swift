//
//  Navigatable.swift
//  LXToolKit
//
//  Created by lxthyme on 2023/5/10.
//

import Foundation
import Hero
import MessageUI

public protocol Navigatable {
    var navigator: Navigator { get set }
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
