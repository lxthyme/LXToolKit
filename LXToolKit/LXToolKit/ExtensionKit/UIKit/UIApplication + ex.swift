//
//  UIApplication + ex.swift
//  LXToolKit
//
//  Created by lxthyme on 2023/9/19.
//

import Foundation

public extension Swifty where Base: UIApplication {
    static var keyWindow: UIWindow? {
        guard #available(iOS 13.0, *) else {
            return Base.shared.keyWindow
        }
        lazy var window = Base.shared.keyWindow

        let firstActiveScene = Base.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .filter { $0.activationState == .foregroundActive }
            .first
        guard #available(iOS 15.0, *) else {
            return firstActiveScene?
                .windows
                .first(where: \.isKeyWindow) ?? window
        }

        return firstActiveScene?.keyWindow ?? window
    }
}
