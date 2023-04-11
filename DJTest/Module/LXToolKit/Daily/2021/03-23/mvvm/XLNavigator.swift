//
//  XLNavigator.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/24.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Hero

protocol XLNavigatable {
    var navigator: XLNavigator! { get set }
}

// MARK: - 👀
extension XLNavigator {
    enum Scene {
        case events(vm: XLEventsVM)
    }
    enum Transition {
        case root(in: UIWindow)
        case navigation(type: HeroDefaultAnimationType)
        case customModal(type: HeroDefaultAnimationType)
        case modal
        case detail
        case alert
        case custom
    }
}

class XLNavigator {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    static var `default` = XLNavigator()

}

// MARK: 👀Public Actions
extension XLNavigator {
    // MARK: - get a single VC
    func get(segue: Scene) -> UIViewController? {
        switch segue {
            case .events(let vm): return XLEventsVC(with: vm, navigator: self)
        }
    }
    func pop(sender: UIViewController?, toRoot: Bool = false, animated: Bool = true) {
        if toRoot {
            sender?.navigationController?.popToRootViewController(animated: animated)
        } else {
            sender?.navigationController?.popViewController(animated: animated)
        }
    }
    func dismiss(sender: UIViewController) {
        sender.navigationController?.dismiss(animated: true, completion: nil)
    }
    // MARK: - invoke a single segue
    func show(segue: Scene, sender: UIViewController?, transition: Transition = .navigation(type: .cover(direction: .left)), animated: Bool = true) {
        if let target = get(segue: segue) {
            show(target: target, sender: sender, transition: transition, animated: animated)
        }
    }
}

// MARK: 🔐Private Actions
private extension XLNavigator {
    func show(target: UIViewController, sender: UIViewController?, transition: Transition, animated: Bool) {
        switch transition {
            case .root(in: let window):
                UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                    window.rootViewController = target
                }, completion: nil)
            case .custom: return
            default: break
        }

        guard let sender = sender else { fatalError("You need to pass in a sender for .navigation or .modal transitions") }

        if let nav = sender as? UINavigationController {
            nav.pushViewController(target, animated: animated)
            return
        }

        switch transition {
            case .navigation(let type):
                /// push controller to navigation stack
                if let nav = sender.navigationController {
                    nav.hero.navigationAnimationType = .autoReverse(presenting: type)
                    nav.pushViewController(target, animated: animated)
                }
            case .customModal(let type):
                /// present modally with custom animation
                DispatchQueue.main.async {
                    let nav = LXBaseNavController(rootViewController: target)
                    nav.hero.modalAnimationType = .autoReverse(presenting: type)
                    sender.present(nav, animated: animated, completion: nil)
                }
            case .modal:
                /// present modally
                DispatchQueue.main.async {
                    let nav = LXBaseNavController(rootViewController: target)
                    sender.present(nav, animated: animated, completion: nil)
                }
            case .detail:
                DispatchQueue.main.async {
                    let nav = LXBaseNavController(rootViewController: target)
                    sender.showDetailViewController(nav, sender: nil)
                }
            case .alert:
                DispatchQueue.main.async {
                    sender.present(target, animated: animated, completion: nil)
                }
            default: break
        }
    }
}
