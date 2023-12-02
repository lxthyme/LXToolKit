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
        return "CustomViewConfiguration(customView: \(customView.description), placement: \(placement), isHidden: \(isHidden), reservedLayoutWidth: \(reservedLayoutWidth), tintColor: \(tintColor?.xl.hexString ?? "NaN"), maintainsFixedSize: \(maintainsFixedSize))"
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

// MARK: - 👀
@available(iOS 14.0, *)
extension UICellAccessory.AccessoryType {
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
        case .customView(let view):
            return "customView(\(view.description))"
        }
    }
    @available(iOS 14.0, *)
    public var list: [UICellAccessory] {
        switch self {
        case .disclosureIndicator:
            return UICellAccessory.generate_disclosureIndicator()
        case .detail:
            return if #available(iOS 15.4, *) {
                UICellAccessory.generate_detail()
            } else {
                // Fallback on earlier versions
                []
            }
        case .checkmark:
            return UICellAccessory.generate_checkmark()
        case .delete:
            return UICellAccessory.generate_delete()
        case .insert:
            return UICellAccessory.generate_insert()
        case .reorder:
            return UICellAccessory.generate_reorder()
        case .multiselect:
            return UICellAccessory.generate_multiselect()
        case .outlineDisclosure:
            return UICellAccessory.generate_outlineDisclosure()
        case .popUpMenu:
            return if #available(iOS 17.0, *) {
                UICellAccessory.generate_popUpMenu()
            } else {
                // Fallback on earlier versions
                []
            }
        case .label:
            return UICellAccessory.generate_label()
        case .customView:
            return UICellAccessory.generate_customView()
        }
    }
}

// MARK: - 🔐
@available(iOS 14.0, *)
private extension UICellAccessory {
    static func makeToast(_ msg: String?) {
        UIApplication.XL.keyWindow?.rootViewController?.view.makeToast(msg)
    }
}
// MARK: - 👀
@available(iOS 14.0, *)
extension UICellAccessory.LayoutDimension {
    public static let xl_custom_64: UICellAccessory.LayoutDimension = .custom(64)
}
@available(iOS 14.0, *)
extension UIColor {
    public static let xl_tintColor: UIColor = .random
    public static let xl_backgroundColor: UIColor = .random
}
// MARK: - 👀
@available(iOS 14.0, *)
extension UICellAccessory.DisplayedState: CaseIterable {
    public static var allCases: [UICellAccessory.DisplayedState] {
        return [.always, .whenEditing, .whenNotEditing]
    }
}
// MARK: - 👀
@available(iOS 14.0, *)
extension UICellAccessory.LayoutDimension: CaseIterable {
    public static var allCases: [UICellAccessory.LayoutDimension] {
        return [.actual, .standard, .xl_custom_64]
    }
}
// MARK: - 👀
@available(iOS 14.0, *)
extension UICellAccessory.LayoutDimension: Equatable {
    public static func == (lhs: UICellAccessory.LayoutDimension, rhs: UICellAccessory.LayoutDimension) -> Bool {
        return lhs.description == rhs.description
    }
}
// MARK: - 👀
@available(iOS 14.0, *)
extension UICellAccessory.OutlineDisclosureOptions.Style: CaseIterable {
    public static var allCases: [UICellAccessory.OutlineDisclosureOptions.Style] {
        return [.automatic, .header, .cell]
    }
}

// MARK: - 👀
@available(iOS 14.0, *)
extension UICellAccessory {
    static public func generate_disclosureIndicator() -> [UICellAccessory] {
        func disclosureIndicatorOptions(_ reservedLayoutWidth: UICellAccessory.LayoutDimension) -> UICellAccessory.DisclosureIndicatorOptions {
            return .init(
                isHidden: false,
                reservedLayoutWidth: reservedLayoutWidth,
                tintColor: .xl_tintColor
            )
        }
        return UICellAccessory.LayoutDimension.allCases.map { .disclosureIndicator(displayed: .always, options: disclosureIndicatorOptions($0)) }
    }
    @available(iOS 15.4, *)
    static public func generate_detail() -> [UICellAccessory] {
        func detailOptions(_ reservedLayoutWidth: UICellAccessory.LayoutDimension) -> UICellAccessory.DetailOptions {
            return .init(
                isHidden: false,
                reservedLayoutWidth: reservedLayoutWidth,
                tintColor: .xl_tintColor
            )
        }
        return UICellAccessory.LayoutDimension.allCases.map {
            .detail(displayed: .always, options: detailOptions($0), actionHandler: {
                let msg = "-->[.detail]"
                dlog(msg)
                makeToast(msg)
            })
        }
    }
    static public func generate_checkmark() -> [UICellAccessory] {
        func checkmarkOptions(_ reservedLayoutWidth: UICellAccessory.LayoutDimension) -> UICellAccessory.CheckmarkOptions {
            return .init(
                isHidden: false,
                reservedLayoutWidth: reservedLayoutWidth,
                tintColor: .xl_tintColor
            )
        }
        return UICellAccessory.LayoutDimension.allCases.map { .checkmark(displayed: .always, options: checkmarkOptions($0)) }
    }
    static public func generate_delete() -> [UICellAccessory] {
        func deleteOptions(_ reservedLayoutWidth: UICellAccessory.LayoutDimension) -> UICellAccessory.DeleteOptions {
            return .init(
                isHidden: false,
                reservedLayoutWidth: reservedLayoutWidth,
                tintColor: .xl_tintColor,
                backgroundColor: .xl_backgroundColor
            )
        }
        return UICellAccessory.LayoutDimension.allCases.map {
            .delete(displayed: .always, options: deleteOptions($0), actionHandler: {
                let msg = "-->[.delete]"
                dlog(msg)
                makeToast(msg)
            })
        }
    }
    static public func generate_insert() -> [UICellAccessory] {
        func insertOptions(_ reservedLayoutWidth: UICellAccessory.LayoutDimension) -> UICellAccessory.InsertOptions {
            return .init(
                isHidden: false,
                reservedLayoutWidth: reservedLayoutWidth,
                tintColor: .xl_tintColor,
                backgroundColor: .xl_backgroundColor
            )
        }
        return UICellAccessory.LayoutDimension.allCases.map {
            .insert(displayed: .always, options: insertOptions($0), actionHandler: {
                let msg = "-->[.insert]"
                dlog(msg)
                makeToast(msg)
            })
        }
    }
    static public func generate_reorder() -> [UICellAccessory] {
        func reorderOptions(_ reservedLayoutWidth: UICellAccessory.LayoutDimension) -> UICellAccessory.ReorderOptions {
            return .init(
                isHidden: false,
                reservedLayoutWidth: reservedLayoutWidth,
                tintColor: .xl_tintColor,
                showsVerticalSeparator: true
            )
        }
        return UICellAccessory.LayoutDimension.allCases.map { .reorder(displayed: .always, options: reorderOptions($0)) }
    }
    static public func generate_multiselect() -> [UICellAccessory] {
        func multiselectOptions(_ reservedLayoutWidth: UICellAccessory.LayoutDimension) -> UICellAccessory.MultiselectOptions {
            return .init(
                isHidden: false,
                reservedLayoutWidth: reservedLayoutWidth,
                tintColor: .xl_tintColor,
                backgroundColor: .xl_backgroundColor
            )
        }
        return UICellAccessory.LayoutDimension.allCases.map { .multiselect(displayed: .always, options: multiselectOptions($0)) }
    }
    static public func generate_outlineDisclosure() -> [UICellAccessory] {
        func outlineDisclosureOptions(_ style: UICellAccessory.OutlineDisclosureOptions.Style, reservedLayoutWidth: UICellAccessory.LayoutDimension) -> UICellAccessory.OutlineDisclosureOptions {
            return .init(
                style: style,
                isHidden: false,
                reservedLayoutWidth: reservedLayoutWidth,
                tintColor: .xl_tintColor
            )
        }
        let xl_actionHandler: UICellAccessory.ActionHandler = {
            let msg = "-->[.outlineDisclosure]"
            dlog(msg)
            makeToast(msg)
        }
        return [
            UICellAccessory.OutlineDisclosureOptions.Style.allCases.map { .outlineDisclosure(displayed: .always, options: outlineDisclosureOptions($0, reservedLayoutWidth: .actual), actionHandler: xl_actionHandler) },
            UICellAccessory.OutlineDisclosureOptions.Style.allCases.map { .outlineDisclosure(displayed: .always, options: outlineDisclosureOptions($0, reservedLayoutWidth: .standard), actionHandler: xl_actionHandler) },
            UICellAccessory.OutlineDisclosureOptions.Style.allCases.map { .outlineDisclosure(displayed: .always, options: outlineDisclosureOptions($0, reservedLayoutWidth: .xl_custom_64), actionHandler: xl_actionHandler) },

            // UICellAccessory.LayoutDimension.allCases.map { .outlineDisclosure(displayed: .always, options: outlineDisclosureOptions(.automatic, reservedLayoutWidth: $0), actionHandler: xl_actionHandler) },
            // UICellAccessory.LayoutDimension.allCases.map { .outlineDisclosure(displayed: .always, options: outlineDisclosureOptions(.header, reservedLayoutWidth: $0), actionHandler: xl_actionHandler) },
            // UICellAccessory.LayoutDimension.allCases.map { .outlineDisclosure(displayed: .always, options: outlineDisclosureOptions(.cell, reservedLayoutWidth: $0), actionHandler: xl_actionHandler) },
        ].flatMap { $0 }
    }
    @available(iOS 17.0, *)
    static public func generate_popUpMenu() -> [UICellAccessory] {
        var selectedTitle = ""
        let menu = UIMenu(
            title: "Title 1",
            subtitle: "Subtitle 1",
            options: .displayAsPalette,
            children: [
                UIAction(title: "Item 1", state: selectedTitle == "Item 1" ? .on : .off, handler: { action in
                    selectedTitle = action.title
                    let msg = "-->\(action.title)"
                    dlog(msg)
                    makeToast(msg)
                }),
                UIAction(title: "Item 2", state: selectedTitle == "Item 2" ? .on : .off, handler: { action in
                    selectedTitle = action.title
                    let msg = "-->\(action.title)"
                    dlog(msg)
                    makeToast(msg)
                }),
                UIAction(title: "Item 3", state: selectedTitle == "Item 3" ? .on : .off, handler: { action in
                    selectedTitle = action.title
                    let msg = "-->\(action.title)"
                    dlog(msg)
                    makeToast(msg)
                }),
                UIAction(title: "Item 4", state: selectedTitle == "Item 4" ? .on : .off, handler: { action in
                    selectedTitle = action.title
                    let msg = "-->\(action.title)"
                    dlog(msg)
                    makeToast(msg)
                }),
                UIAction(title: "Item 5", state: selectedTitle == "Item 5" ? .on : .off, handler: { action in
                    selectedTitle = action.title
                    let msg = "-->\(action.title)"
                    dlog(msg)
                    makeToast(msg)
                }),
            ]
        )
        func popUpMenuOptions(_ reservedLayoutWidth: UICellAccessory.LayoutDimension) -> UICellAccessory.PopUpMenuOptions {
            return .init(
                isHidden: false,
                reservedLayoutWidth: reservedLayoutWidth,
                tintColor: .xl_tintColor
            )
        }
        return UICellAccessory.LayoutDimension.allCases.map {
            .popUpMenu(menu, displayed: .always, options: popUpMenuOptions($0), selectedElementDidChangeHandler: { menu in
                let msg = "-->[.popUpMenu]: \(menu.title)"
                dlog(msg)
                makeToast(msg)
            })
        }
    }
    static public func generate_label() -> [UICellAccessory] {
        func labelOptions(_ reservedLayoutWidth: UICellAccessory.LayoutDimension) -> UICellAccessory.LabelOptions {
            return .init(
                isHidden: false,
                reservedLayoutWidth: reservedLayoutWidth,
                tintColor: .xl_tintColor,
                font: .systemFont(ofSize: 14),
                adjustsFontForContentSizeCategory: true
            )
        }
        return UICellAccessory.LayoutDimension.allCases.map { .label(text: "label", displayed: .always, options: labelOptions($0)) }
    }
    static public func createCustomLabel(title: String = "🚀") -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        // label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        label.sizeToFit()
        return label
    }
    static public func customViewConfiguration(_ customView: UIView = createCustomLabel(),
                                               placement: UICellAccessory.Placement = .trailing(displayed: .always, at: { accessories in
        return 1
    }),
                                               isHidden: Bool = false,
                                               reservedLayoutWidth: UICellAccessory.LayoutDimension,
                                               tintColor: UIColor = .xl_tintColor,
                                               maintainsFixedSize: Bool = true) -> UICellAccessory.CustomViewConfiguration {
        return .init(
            customView: customView,
            // placement: .leading(displayed: .always, at: { accessories in
            //     let msg = "-->[.customView]: \(accessories)"
            //     dlog(msg)
            //     makeToast(msg)
            //     return 0
            // }),
            placement: placement,
            isHidden: isHidden,
            reservedLayoutWidth: reservedLayoutWidth,
            tintColor: tintColor,
            maintainsFixedSize: maintainsFixedSize
        )
    }
    static public func generate_customView() -> [UICellAccessory] {
        return UICellAccessory.LayoutDimension.allCases.map { UICellAccessory.customView(configuration: customViewConfiguration(createCustomLabel(title: "🚀\($0)"), reservedLayoutWidth: $0)) }
        // return [UICellAccessory.customView(configuration: customViewConfiguration(createCustomLabel(title: "🚀.standard"), reservedLayoutWidth: .standard))]
    }
    static public func generateListAccessory() -> [UICellAccessory] {
        var list: [[UICellAccessory]] = [
            generate_disclosureIndicator(),
            // generate_detail(),
            generate_checkmark(),
            generate_delete(),
            generate_insert(),
            generate_reorder(),
            generate_multiselect(),
            generate_outlineDisclosure(),
            // generate_popUpMenu(),
            generate_label(),
            generate_customView(),
        ]
        if #available(iOS 15.4, *) {
            list.append(generate_detail())
        }
        if #available(iOS 17.0, *) {
            list.append(generate_popUpMenu())
        }
        return list.flatMap { $0 }
    }
}
