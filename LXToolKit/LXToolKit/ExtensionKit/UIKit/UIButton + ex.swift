//
//  UIButton + ex.swift
//  LXToolKit
//
//  Created by lxthyme on 2022/2/8.
//

import Foundation

// MARK: - 👀UIButton.Configuration
public extension UIButton {
    enum ConfigurationEnum: CaseIterable {
        case plain
        case tinted
        case gray
        case filled
        case borderless
        case bordered
        case borderedTinted
        case borderedProminent
    }
}
public extension Swifty where Base == UIButton.ConfigurationEnum {
    static func from(value: String) -> UIButton.ConfigurationEnum? {
        let item: UIButton.ConfigurationEnum?
        switch value {
        case "plain":
            item = .plain
        case "tinted":
            item = .tinted
        case "gray":
            item = .gray
        case "filled":
            item = .filled
        case "borderless":
            item = .borderless
        case "bordered":
            item = .bordered
        case "borderedTinted":
            item = .borderedTinted
        case "borderedProminent":
            item = .borderedProminent
        default:
            item = nil
        }
        return item
    }
    var rawValue: String {
        switch base {
        case .plain:
            return "plain"
        case .tinted:
            return "tinted"
        case .gray:
            return "gray"
        case .filled:
            return "filled"
        case .borderless:
            return "borderless"
        case .bordered:
            return "bordered"
        case .borderedTinted:
            return "borderedTinted"
        case .borderedProminent:
            return "borderedProminent"
        }
    }
}
// MARK: - 👀UIButton.Configuration.Size
@available(iOS 15.0, *)
public extension Swifty where Base == UIButton.Configuration.Size {
    /// UIButton.Configuration.Size 的所有枚举
    static var allCases: [UIButton.Configuration.Size] {
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
    static var allCases: [UIButton.Configuration.CornerStyle] {
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
    static var allCases: [UIButton.Configuration.MacIdiomStyle] {
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
    static var allCases: [UIButton.Configuration.TitleAlignment] {
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

public extension Swifty where Base: UIButton {
    func centerTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        let isRTL = UIView.userInterfaceLayoutDirection(for: base.semanticContentAttribute) == .rightToLeft
        if isRTL {
            base.imageEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
            base.titleEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
            base.contentEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: -insetAmount)
        } else {
            base.imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
            base.titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
            base.contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
        }
    }
}
