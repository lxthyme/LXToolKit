//
//  Wireframe.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/9/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
import UIKit
import Foundation
import RxSwift

enum RetryResult {
    case retry
    case cancel
}

protocol Wireframe {
    func open(url: URL)
    func promptFor<Action: CustomStringConvertible>(_ message: String, cancelAction: Action, actions: [Action]) -> Observable<Action>
}

class DefaultWireframe {
    static let shared = DefaultWireframe()

    private static func rootVC() -> UIViewController? {
        return UIApplication.shared.keyWindow?.rootViewController
    }
    static func presentAlert(title: String, message: String, style: UIAlertController.Style = .alert, actions: [UIAlertAction] = []) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        if actions.count > 0 {
            actions.forEach(alert.addAction)
        } else {
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        }
        rootVC()?.present(alert, animated: true, completion: nil)
    }
}
// MARK: - 👀Wireframe
extension DefaultWireframe: Wireframe {
    func open(url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    func promptFor<Action>(_ message: String, cancelAction: Action, actions: [Action]) -> Observable<Action> where Action: CustomStringConvertible {
        return Observable.create { observer in
            let alert = UIAlertController(title: "LXExample", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: cancelAction.description, style: .cancel, handler: { _ in
                observer.on(.next(cancelAction))
            }))

            for action in actions {
                alert.addAction(UIAlertAction(title: action.description, style: .default, handler: { _ in
                    observer.on(.next(action))
                }))
            }

            DefaultWireframe.rootVC()?.present(alert, animated: true, completion: nil)

            return Disposables.create {
                alert.dismiss(animated: false, completion: nil)
            }
        }
    }
}

// MARK: - 👀
extension RetryResult: CustomStringConvertible {
    var description: String {
        switch self {
            case .retry:
                return "Retry"
            case .cancel:
                return "Cancel"
        }
    }
}
