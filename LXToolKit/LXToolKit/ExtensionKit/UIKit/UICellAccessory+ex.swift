//
//  UICellAccessory+ex.swift
//  LXToolKit
//
//  Created by lxthyme on 2023/12/1.
//

import Foundation

// MARK: - 👀
@available(iOS 14.0, *)
extension UICellAccessory.DisplayedState: CustomStringConvertible {
    public var description: String {
        switch self {
        case .always:
            return ".always"
        case .whenEditing:
            return ".whenEditing"
        case .whenNotEditing:
            return ".whenNotEditing"
        }
    }
}
@available(iOS 14.0, *)
extension UICellAccessory.LayoutDimension: CustomStringConvertible {
    public var description: String {
        switch self {
        case .actual:
            return ".actual"
        case .standard:
            return ".standard"
        case .custom(let cGFloat):
            return ".custom(\(cGFloat))"
        }
    }
}
// MARK: - 👀
@available(iOS 14.0, *)
extension UICellAccessory.DisclosureIndicatorOptions: CustomStringConvertible {
    public var description: String {
        return "DisclosureIndicatorOptions(isHidden: \(isHidden), reservedLayoutWidth: \(reservedLayoutWidth), tintColor: \(tintColor?.xl.hexString ?? "NaN"))"
    }
}
@available(iOS 14.0, *)
extension UICellAccessory.CheckmarkOptions: CustomStringConvertible {
    public var description: String {
        return "CheckmarkOptions(isHidden: \(isHidden), reservedLayoutWidth: \(reservedLayoutWidth), tintColor: \(tintColor?.xl.hexString ?? "NaN"))"
    }
}
@available(iOS 14.0, *)
extension UICellAccessory.DeleteOptions: CustomStringConvertible {
    public var description: String {
        return "DeleteOptions(isHidden: \(isHidden), reservedLayoutWidth: \(reservedLayoutWidth), tintColor: \(tintColor?.xl.hexString ?? "NaN"), backgroundColor: \(backgroundColor?.xl.hexString ?? "NaN"))"
    }
}
@available(iOS 14.0, *)
extension UICellAccessory.InsertOptions: CustomStringConvertible {
    public var description: String {
        return "InsertOptions(isHidden: \(isHidden), reservedLayoutWidth: \(reservedLayoutWidth), tintColor: \(tintColor?.xl.hexString ?? "NaN"), backgroundColor: \(backgroundColor?.xl.hexString ?? "NaN"))"
    }
}
@available(iOS 14.0, *)
extension UICellAccessory.ReorderOptions: CustomStringConvertible {
    public var description: String {
        return "ReorderOptions(isHidden: \(isHidden), reservedLayoutWidth: \(reservedLayoutWidth), tintColor: \(tintColor?.xl.hexString ?? "NaN"), showsVerticalSeparator: \(showsVerticalSeparator))"
    }
}
@available(iOS 14.0, *)
extension UICellAccessory.MultiselectOptions: CustomStringConvertible {
    public var description: String {
        return "MultiselectOptions(isHidden: \(isHidden), reservedLayoutWidth: \(reservedLayoutWidth), tintColor: \(tintColor?.xl.hexString ?? "NaN"), backgroundColor: \(backgroundColor?.xl.hexString ?? "NaN"))"
    }
}
@available(iOS 14.0, *)
extension UICellAccessory.OutlineDisclosureOptions: CustomStringConvertible {
    public var description: String {
        return "OutlineDisclosureOptions(style: \(style), isHidden: \(isHidden), reservedLayoutWidth: \(reservedLayoutWidth), tintColor: \(tintColor?.xl.hexString ?? "NaN"))"
    }
}
@available(iOS 14.0, *)
extension UICellAccessory.LabelOptions: CustomStringConvertible {
    public var description: String {
        return "LabelOptions(isHidden: \(isHidden), reservedLayoutWidth: \(reservedLayoutWidth), tintColor: \(tintColor?.xl.hexString ?? "NaN"), font: \(font), adjustsFontForContentSizeCategory: \(adjustsFontForContentSizeCategory))"
    }
}
@available(iOS 14.0, *)
extension UICellAccessory.CustomViewConfiguration: CustomStringConvertible {
    public var description: String {
        return "CustomViewConfiguration(customView: \(customView), placement: \(placement), isHidden: \(isHidden), reservedLayoutWidth: \(reservedLayoutWidth), tintColor: \(tintColor?.xl.hexString ?? "NaN"), maintainsFixedSize: \(maintainsFixedSize))"
    }
}
@available(iOS 15.4, *)
extension UICellAccessory.DetailOptions: CustomStringConvertible {
    public var description: String {
        return "DeleteOptions(isHidden: \(isHidden), reservedLayoutWidth: \(reservedLayoutWidth), tintColor: \(tintColor?.xl.hexString ?? "NaN"))"
    }
}
@available(iOS 16.0, *)
extension UICellAccessory.PopUpMenuOptions: CustomStringConvertible {
    public var description: String {
        return "PopUpMenuOptions(isHidden: \(isHidden), reservedLayoutWidth: \(reservedLayoutWidth), tintColor: \(tintColor?.xl.hexString ?? "NaN"))"
    }
}

@available(iOS 16.0, *)
public enum UICellAccessoryEnum {
    case disclosureIndicator(displayed: UICellAccessory.DisplayedState = .always, options: UICellAccessory.DisclosureIndicatorOptions = UICellAccessory.DisclosureIndicatorOptions())
    case detail(displayed: UICellAccessory.DisplayedState = .always, options: UICellAccessory.DetailOptions = UICellAccessory.DetailOptions(), actionHandler: UICellAccessory.ActionHandler? = nil)
    case checkmark(displayed: UICellAccessory.DisplayedState = .always, options: UICellAccessory.CheckmarkOptions = UICellAccessory.CheckmarkOptions())
    case delete(displayed: UICellAccessory.DisplayedState = .whenEditing, options: UICellAccessory.DeleteOptions = UICellAccessory.DeleteOptions(), actionHandler: UICellAccessory.ActionHandler? = nil)
    case insert(displayed: UICellAccessory.DisplayedState = .whenEditing, options: UICellAccessory.InsertOptions = UICellAccessory.InsertOptions(), actionHandler: UICellAccessory.ActionHandler? = nil)
    case reorder(displayed: UICellAccessory.DisplayedState = .whenEditing, options: UICellAccessory.ReorderOptions = UICellAccessory.ReorderOptions())
    case multiselect(displayed: UICellAccessory.DisplayedState = .whenEditing, options: UICellAccessory.MultiselectOptions = UICellAccessory.MultiselectOptions())
    case outlineDisclosure(displayed: UICellAccessory.DisplayedState = .always, options: UICellAccessory.OutlineDisclosureOptions = UICellAccessory.OutlineDisclosureOptions(), actionHandler: UICellAccessory.ActionHandler? = nil)
    case popUpMenu(_ menu: UIMenu, displayed: UICellAccessory.DisplayedState = .always, options: UICellAccessory.PopUpMenuOptions = UICellAccessory.PopUpMenuOptions(), selectedElementDidChangeHandler: UICellAccessory.MenuSelectedElementDidChangeHandler? = nil)
    case label(text: String, displayed: UICellAccessory.DisplayedState = .always, options: UICellAccessory.LabelOptions = UICellAccessory.LabelOptions())
    case customView(configuration: UICellAccessory.CustomViewConfiguration)

    public var value: UICellAccessory {
        switch self {
        case .disclosureIndicator(let displayed, let options):
            return .disclosureIndicator(displayed: displayed, options: options)
        case .detail(let displayed, let options, let actionHandler):
            return .detail(displayed: displayed, options: options, actionHandler: actionHandler)
        case .checkmark(let displayed, let options):
            return .checkmark(displayed: displayed, options: options)
        case .delete(let displayed, let options, let actionHandler):
            return .delete(displayed: displayed, options: options, actionHandler: actionHandler)
        case .insert(let displayed, let options, let actionHandler):
            return .insert(displayed: displayed, options: options, actionHandler: actionHandler)
        case .reorder(let displayed, let options):
            return .reorder(displayed: displayed, options: options)
        case .multiselect(let displayed, let options):
            return .multiselect(displayed: displayed, options: options)
        case .outlineDisclosure(let displayed, let options, let actionHandler):
            return .outlineDisclosure(displayed: displayed, options: options, actionHandler: actionHandler)
        case .popUpMenu(let menu, let displayed, let options, let selectedElementDidChangeHandler):
            return .popUpMenu(menu, displayed: displayed, options: options, selectedElementDidChangeHandler: selectedElementDidChangeHandler)
        case .label(let text, let displayed, let options):
            return .label(text: text, displayed: displayed, options: options)
        case .customView(let configuration):
            return .customView(configuration: configuration)
        }
    }
    public var title: String {
        switch self {
        case .disclosureIndicator:
            return "disclosureIndicator"
        case .detail:
            return "detail"
        case .checkmark:
            return "checkmark"
        case .delete:
            return "delete"
        case .insert:
            return "insert"
        case .reorder:
            return "reorder"
        case .multiselect:
            return "multiselect"
        case .outlineDisclosure:
            return "outlineDisclosure"
        case .popUpMenu:
            return "popUpMenu"
        case .label:
            return "label"
        case .customView:
            return "customView"
        }
    }
}
