//
//  Window + ex.swift
//  LXSwiftUIKit
//
//  Created by lxthyme on 2022/9/7.
//

import Foundation
import UIKit

struct MainApp {
    public static var xl_keyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .compactMap({ $0 as? UIWindowScene })
            .first?
            .windows
            .filter({ $0.isKeyWindow })
            .first
    }
}
