//
//  UIButton + ex.swift
//  LXToolKit
//
//  Created by lxthyme on 2022/2/8.
//

import Foundation

// MARK: - 👀UIButton.Configuration
@available(iOS 15.0, *)
public extension Swifty where Base == UIButton.Configuration {
    var allList: [UIButton.Configuration] {
        return [
            .plain(),
            .tinted(),
            .gray(),
            .filled(),
            .borderless(),
            .bordered(),
            .borderedTinted(),
            .borderedProminent(),
        ]
    }
    var rawValue: String {
        switch base {
        case .plain():
            return "plain"
        case .tinted():
            return "tinted"
        case .gray():
            return "gray"
        case .filled():
            return "filled"
        case .borderless():
            return "borderless"
        case .bordered():
            return "bordered"
        case .borderedTinted():
            return "borderedTinted"
        case .borderedProminent():
            return "borderedProminent"
        default:
            return "\(base.hashValue)"
        }
    }
}
// MARK: - 👀UIButton.Configuration.Size
@available(iOS 15.0, *)
public extension Swifty where Base == UIButton.Configuration.Size {
    /// UIButton.Configuration.Size 的所有枚举
    static var allList: [UIButton.Configuration.Size] {
        return [
            .mini,
            .small,
            .medium,
            .large,
        ]
    }
    var rawValue: String {
        switch base {
        case .mini:
            return "mini"
        case .small:
            return "small"
        case .medium:
            return "medium"
        case .large:
            return "large"
        @unknown default:
            return "\(base.hashValue)"
        }
    }
}
// MARK: - 👀UIButton.Configuration.CornerStyle
@available(iOS 15.0, *)
public extension Swifty where Base == UIButton.Configuration.CornerStyle {
    static var allList: [UIButton.Configuration.CornerStyle] {
        return [
            .fixed,
            .dynamic,
            .small,
            .medium,
            .large,
            .capsule,
        ]
    }
    var rawValue: String {
        switch base {
        case .fixed:
            return "fixed"
        case .dynamic:
            return "dynamic"
        case .small:
            return "small"
        case .medium:
            return "medium"
        case .large:
            return "large"
        case .capsule:
            return "capsule"
        @unknown default:
            return "\(base.hashValue)"
        }
    }
}
// MARK: - 👀UIButton.Configuration.MacIdiomStyle
@available(iOS 15.0, *)
public extension Swifty where Base == UIButton.Configuration.MacIdiomStyle {
    static var allList: [UIButton.Configuration.MacIdiomStyle] {
        return [
            .automatic,
            .bordered,
            .borderless,
            .borderlessTinted,
        ]
    }
    var rawValue: String {
        switch base {
        case .automatic:
            return "automatic"
        case .bordered:
            return "bordered"
        case .borderless:
            return "borderless"
        case .borderlessTinted:
            return "borderlessTinted"
        @unknown default:
            return "\(base.hashValue)"
        }
    }
}
// MARK: - 👀UIButton.Configuration.TitleAlignment
@available(iOS 15.0, *)
public extension Swifty where Base == UIButton.Configuration.TitleAlignment {
    static var allList: [UIButton.Configuration.TitleAlignment] {
        return [
            .automatic,
            .leading,
            .center,
            .trailing,
        ]
    }
    var rawValue: String {
        switch base {
        case .automatic:
            return "automatic"
        case .leading:
            return "leading"
        case .center:
            return "center"
        case .trailing:
            return "trailing"
        @unknown default:
            return "\(base.hashValue)"
        }
    }
}
