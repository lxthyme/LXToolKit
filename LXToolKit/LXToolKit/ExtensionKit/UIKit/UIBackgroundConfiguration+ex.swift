//
//  UIBackgroundConfiguration+ex.swift
//  LXToolKit
//
//  Created by lxthyme on 2023/12/13.
//

import Foundation

// MARK: - 👀UIListContentConfiguration
// public extension Swifty where Base == UIListContentConfiguration {
public extension UIListContentConfiguration {
    enum Ex: CaseIterable {
        case cell
        case subtitleCell
        case valueCell
        case plainHeader
        case plainFooter
        case groupedHeader
        case groupedFooter
        case prominentInsetGroupedHeader
        case extraProminentInsetGroupedHeader
        case sidebarCell
        case sidebarSubtitleCell
        case accompaniedSidebarCell
        case accompaniedSidebarSubtitleCell
        case sidebarHeader
        case UICollectionViewListCellDefaultContentConfiguration
        case UITableViewCellDefaultContentConfiguration
        case UITableViewHeaderFooterViewDefaultContentConfiguration

        public var configuration: UIListContentConfiguration? {
            switch self {
            case .cell: return .cell()
            case .subtitleCell: return .subtitleCell()
            case .valueCell: return .valueCell()
            case .plainHeader: return .plainHeader()
            case .plainFooter: return .plainFooter()
            case .groupedHeader: return .groupedHeader()
            case .groupedFooter: return .groupedFooter()
            case .prominentInsetGroupedHeader:
                return if #available(iOS 15.0, *) {
                    .prominentInsetGroupedHeader()
                } else {
                    // Fallback on earlier versions
                    nil
                }
            case .extraProminentInsetGroupedHeader:
                return if #available(iOS 15.0, *) {
                    .extraProminentInsetGroupedHeader()
                } else {
                    // Fallback on earlier versions
                    nil
                }
            case .sidebarCell: return .sidebarCell()
            case .sidebarSubtitleCell: return .sidebarSubtitleCell()
            case .accompaniedSidebarCell: return .accompaniedSidebarCell()
            case .accompaniedSidebarSubtitleCell: return .accompaniedSidebarSubtitleCell()
            case .sidebarHeader: return .sidebarHeader()
            case .UICollectionViewListCellDefaultContentConfiguration: return UICollectionViewListCell().defaultContentConfiguration()
            case .UITableViewCellDefaultContentConfiguration: return UITableViewCell().defaultContentConfiguration()
            case .UITableViewHeaderFooterViewDefaultContentConfiguration: return UITableViewHeaderFooterView().defaultContentConfiguration()
            }
        }
        public var title: String {
            switch self {
            case .cell: return ".cell"
            case .subtitleCell: return ".subtitleCell"
            case .valueCell: return ".valueCell"
            case .plainHeader: return ".plainHeader"
            case .plainFooter: return ".plainFooter"
            case .groupedHeader: return ".groupedHeader"
            case .groupedFooter: return ".groupedFooter"
            case .prominentInsetGroupedHeader: return ".prominentInsetGroupedHeader"
            case .extraProminentInsetGroupedHeader: return ".extraProminentInsetGroupedHeader"
            case .sidebarCell: return ".sidebarCell"
            case .sidebarSubtitleCell: return ".sidebarSubtitleCell"
            case .accompaniedSidebarCell: return ".accompaniedSidebarCell"
            case .accompaniedSidebarSubtitleCell: return ".accompaniedSidebarSubtitleCell"
            case .sidebarHeader: return ".sidebarHeader"
            case .UICollectionViewListCellDefaultContentConfiguration: return "UICollectionViewListCell().defaultContentConfiguration"
            case .UITableViewCellDefaultContentConfiguration: return "UITableViewCell().defaultContentConfiguration"
            case .UITableViewHeaderFooterViewDefaultContentConfiguration: return "UITableViewHeaderFooterView().defaultContentConfiguration"
            }
        }
    }
}

extension UIListContentConfiguration.Ex: CustomStringConvertible {
    public var description: String {
        guard let configuration else {
            return "\(title): UnSupported"
        }
        var desc = ""
        let prefix = "   "
        var idx = 1
        if let image = configuration.image {
            desc += "\(prefix)\(idx). image: \(image.description)\n"
        }
        idx += 1
        if configuration.imageProperties.desc.isNotEmpty {
            desc += "\(prefix)\(idx). imageProperties: \(configuration.imageProperties.desc)\n"
        }
        idx += 1
        if let text = configuration.text,
           text.isNotEmpty {
            desc += "\(prefix)\(idx). text: \(text)\n"
        }
        idx += 1
        if let attributedText = configuration.attributedText {
            desc += "\(prefix)\(idx). attributedText: \(attributedText.description)\n"
        }
        idx += 1
        if configuration.textProperties.desc.isNotEmpty {
            desc += "\(prefix)\(idx). textProperties: \(configuration.textProperties.desc)\n"
        }
        idx += 1
        if let secondaryText = configuration.secondaryText,
           secondaryText.isNotEmpty {
            desc += "\(prefix)\(idx). secondaryText: \(secondaryText)\n"
        }
        idx += 1
        if let secondaryAttributedText = configuration.secondaryAttributedText {
            desc += "\(prefix)\(idx). secondaryAttributedText: \(secondaryAttributedText.description)\n"
        }
        idx += 1
        if configuration.secondaryTextProperties.desc.isNotEmpty {
            desc += "\(prefix)\(idx). secondaryTextProperties: \(configuration.secondaryTextProperties.desc)\n"
        }
        idx += 1
        desc += "\(prefix)\(idx). axesPreservingSuperviewLayoutMargins: \(configuration.axesPreservingSuperviewLayoutMargins)\n"
        idx += 1
        if configuration.directionalLayoutMargins != .zero {
            desc += "\(prefix)\(idx). directionalLayoutMargins: \(configuration.directionalLayoutMargins)\n"
        }
        idx += 1
        desc += "\(prefix)\(idx). prefersSideBySideTextAndSecondaryText: \(configuration.prefersSideBySideTextAndSecondaryText)\n"
        idx += 1
        if configuration.imageToTextPadding != 0 {
            desc += "\(prefix)\(idx). imageToTextPadding: \(configuration.imageToTextPadding)\n"
        }
        idx += 1
        if configuration.textToSecondaryTextHorizontalPadding != 0 {
            desc += "\(prefix)\(idx). textToSecondaryTextHorizontalPadding: \(configuration.textToSecondaryTextHorizontalPadding)\n"
        }
        idx += 1
        if configuration.textToSecondaryTextVerticalPadding != 0 {
            desc += "\(prefix)\(idx). textToSecondaryTextVerticalPadding: \(configuration.textToSecondaryTextVerticalPadding)\n"
        }
        idx += 1
        return desc.removingSuffix("\n")
    }
}

// MARK: - 👀UIBackgroundConfiguration
public extension UIBackgroundConfiguration {
    enum Ex: CaseIterable {
        case clear
        case listPlainCell
        case listPlainHeaderFooter
        case listGroupedCell
        case listGroupedHeaderFooter
        case listSidebarHeader
        case listSidebarCell
        case listAccompaniedSidebarCell
        case UICollectionViewCellDefaultBackgroundConfiguration
        case UICollectionViewListCellDefaultBackgroundConfiguration
        case UITableViewCellDefaultBackgroundConfiguration
        case UITableViewHeaderFooterViewDefaultBackgroundConfiguration

        public var configuration: UIBackgroundConfiguration? {
            switch self {
            case .clear: return .clear()
            case .listPlainCell: return .listPlainCell()
            case .listPlainHeaderFooter: return .listPlainHeaderFooter()
            case .listGroupedCell: return .listGroupedCell()
            case .listGroupedHeaderFooter: return .listGroupedHeaderFooter()
            case .listSidebarHeader: return .listSidebarHeader()
            case .listSidebarCell: return .listSidebarCell()
            case .listAccompaniedSidebarCell: return .listAccompaniedSidebarCell()
            case .UICollectionViewCellDefaultBackgroundConfiguration:
                return if #available(iOS 16.0, *) {
                    UICollectionViewCell().defaultBackgroundConfiguration()
                } else {
                    nil
                }
            case .UICollectionViewListCellDefaultBackgroundConfiguration:
                return if #available(iOS 16.0, *) {
                    UICollectionViewListCell().defaultBackgroundConfiguration()
                } else {
                    nil
                }
            case .UITableViewCellDefaultBackgroundConfiguration:
                return if #available(iOS 16.0, *) {
                    UITableViewCell().defaultBackgroundConfiguration()
                } else {
                    nil
                }
            case .UITableViewHeaderFooterViewDefaultBackgroundConfiguration:
                return if #available(iOS 16.0, *) {
                    UITableViewHeaderFooterView().defaultBackgroundConfiguration()
                } else {
                    nil
                }
            }
        }
        public var title: String {
            switch self {
            case .clear: return ".clear"
            case .listPlainCell: return ".listPlainCell"
            case .listPlainHeaderFooter: return ".listPlainHeaderFooter"
            case .listGroupedCell: return ".listGroupedCell"
            case .listGroupedHeaderFooter: return ".listGroupedHeaderFooter"
            case .listSidebarHeader: return ".listSidebarHeader"
            case .listSidebarCell: return ".listSidebarCell"
            case .listAccompaniedSidebarCell: return ".listAccompaniedSidebarCell"
            case .UICollectionViewCellDefaultBackgroundConfiguration: return "UICollectionViewCell.defaultBackgroundConfiguration"
            case .UICollectionViewListCellDefaultBackgroundConfiguration: return "UICollectionViewListCell.defaultBackgroundConfiguration"
            case .UITableViewCellDefaultBackgroundConfiguration: return "UITableViewCell.defaultBackgroundConfiguration"
            case .UITableViewHeaderFooterViewDefaultBackgroundConfiguration: return "UITableViewHeaderFooterView.defaultBackgroundConfiguration"
            }
        }
    }
}

// MARK: - ✈️CustomStringConvertible
extension UIBackgroundConfiguration.Ex: CustomStringConvertible {
    public var description: String {
        guard let configuration else {
            return "UnSupported"
        }
        let imageDesc: String?
        let imageContentModeDesc: String
        if #available(iOS 15.0, *) {
            imageDesc = configuration.image?.description
            imageContentModeDesc = configuration.imageContentMode.description
        } else {
            imageDesc = "--UnAvailable--"
            imageContentModeDesc = "--UnAvailable--"
        }
        var desc = ""
        var idx = 1
        let prefix = "    "
        if let customView = configuration.customView {
            desc += "\(prefix)\(idx). customView: \(customView)\n"
        }
        idx += 1
        if configuration.cornerRadius > 0 {
            desc += "\(prefix)\(idx). cornerRadius: \(configuration.cornerRadius)\n"
        }
        idx += 1
        if configuration.backgroundInsets != .zero {
            desc += "\(prefix)\(idx). backgroundInsets: \(configuration.backgroundInsets)\n"
        }
        idx += 1
        desc += "\(prefix)\(idx). edgesAddingLayoutMarginsToBackgroundInsets: \(configuration.edgesAddingLayoutMarginsToBackgroundInsets)\n"
        idx += 1
        if let backgroundColor = configuration.backgroundColor {
            desc += "\(prefix)\(idx). backgroundColor: \(backgroundColor.xl.getColorName())\n"
        }
        idx += 1
        if let backgroundColorTransformer = configuration.backgroundColorTransformer {
            desc += "\(prefix)\(idx). backgroundColorTransformer: \(backgroundColorTransformer)\n"
        }
        idx += 1
        if let visualEffect = configuration.visualEffect {
            desc += "\(prefix)\(idx). visualEffect: \(visualEffect)\n"
        }
        idx += 1
        if let imageDesc {
            desc += "\(prefix)\(idx). image: \(imageDesc)\n"
        }
        idx += 1
        desc += "\(prefix)\(idx). imageContentMode: \(imageContentModeDesc)\n"
        idx += 1
        if let strokeColor = configuration.strokeColor {
            desc += "\(prefix)\(idx). strokeColor: \(strokeColor.xl.getColorName())\n"
        }
        idx += 1
        if let strokeColorTransformer = configuration.strokeColorTransformer {
            desc += "\(prefix)\(idx). strokeColorTransformer: \(strokeColorTransformer)\n"
        }
        idx += 1
        if configuration.strokeWidth > 0 {
            desc += "\(prefix)\(idx). strokeWidth: \(configuration.strokeWidth)\n"
        }
        idx += 1
        if configuration.strokeOutset > 0 {
            desc += "\(prefix)\(idx). strokeOutset: \(configuration.strokeOutset)\n"
        }
        idx += 1
        return desc.removingSuffix("\n")
    }
}

// MARK: - 👀
extension NSLineBreakMode: CustomStringConvertible {
    public var description: String {
        switch self {
        case .byWordWrapping: return ".byWordWrapping"
        case .byCharWrapping: return ".byCharWrapping"
        case .byClipping: return ".byClipping"
        case .byTruncatingHead: return ".byTruncatingHead"
        case .byTruncatingTail: return ".byTruncatingTail"
        case .byTruncatingMiddle: return ".byTruncatingMiddle"
        @unknown default: return "Unknown-NSLineBreakMode(\(self.rawValue)"
        }
    }
}

// MARK: - 👀
extension UIAxis: CustomStringConvertible {
    public var description: String {
        switch self {
        case .horizontal: return "UIAxis.horizontal"
        case .vertical: return "UIAxis.vertical"
        case .both: return "UIAxis.both"
        default: return "Unknown-UIAxis(\(self.rawValue)"
        }
    }
}

// MARK: - ✈️NSDirectionalRectEdge
extension NSDirectionalRectEdge: CustomStringConvertible {
    public var description: String {
        switch self {
        case .all: return "NSDirectionalRectEdge.all"
        case .top: return "NSDirectionalRectEdge.top"
        case .leading: return "NSDirectionalRectEdge.leading"
        case .trailing: return "NSDirectionalRectEdge.trailing"
        case .bottom: return "NSDirectionalRectEdge.bottom"
        case []: return "NSDirectionalRectEdge.none"
        default: return "NSDirectionalRectEdge(rawValue: \(self.rawValue))"
        }
    }
}

// MARK: - ✈️UIView.ContentMode
extension UIView.ContentMode: CustomStringConvertible {
    public var description: String {
        switch self {
        case .scaleToFill: return "UIView.ContentMode.scaleToFill"
        case .scaleAspectFit: return "UIView.ContentMode.scaleAspectFit"
        case .scaleAspectFill: return "UIView.ContentMode.scaleAspectFill"
        case .redraw: return "UIView.ContentMode.redraw"
        case .center: return "UIView.ContentMode.center"
        case .top: return "UIView.ContentMode.top"
        case .bottom: return "UIView.ContentMode.bottom"
        case .left: return "UIView.ContentMode.left"
        case .right: return "UIView.ContentMode.right"
        case .topLeft: return "UIView.ContentMode.topLeft"
        case .topRight: return "UIView.ContentMode.topRight"
        case .bottomLeft: return "UIView.ContentMode.bottomLeft"
        case .bottomRight: return "UIView.ContentMode.bottomRight"
        @unknown default: return "UIView.ContentMode(rawValue: \(self.rawValue))"
        }
    }
}

// MARK: - 👀
extension UIListContentConfiguration.TextProperties {
    public var desc: String {
        var t_showsExpansionTextWhenTruncated: String = if #available(iOS 16.0, *) {
            "\(showsExpansionTextWhenTruncated)"
        } else {
            "UnSupported"
        }
        var desc = ""
        var idx = 1
        let prefix = "        "
        desc += "\(prefix)\(idx). font: \(font)\n"
        idx += 1
        desc += "\(prefix)\(idx). color: \(color.xl.getColorName())\n"
        idx += 1
        if let colorTransformer {
            desc += "\(prefix)\(idx). colorTransformer: \(colorTransformer)\n"
        }
        idx += 1
        if alignment != .natural {
            desc += "\(prefix)\(idx). alignment: \(alignment)\n"
        }
        idx += 1
        desc += "\(prefix)\(idx). lineBreakMode: \(lineBreakMode)\n"
        idx += 1
        if numberOfLines > 0 {
            desc += "\(prefix)\(idx). numberOfLines: \(numberOfLines)\n"
        }
        idx += 1
        desc += "\(prefix)\(idx). adjustsFontSizeToFitWidth: \(adjustsFontSizeToFitWidth)\n"
        idx += 1
        if minimumScaleFactor > 0 {
            desc += "\(prefix)\(idx). minimumScaleFactor: \(minimumScaleFactor)\n"
        }
        idx += 1
        desc += "\(prefix)\(idx). allowsDefaultTighteningForTruncation: \(allowsDefaultTighteningForTruncation)\n"
        idx += 1
        desc += "\(prefix)\(idx). adjustsFontForContentSizeCategory: \(adjustsFontForContentSizeCategory)\n"
        idx += 1
        desc += "\(prefix)\(idx). showsExpansionTextWhenTruncated: \(t_showsExpansionTextWhenTruncated)\n"
        idx += 1
        if transform != .none {
            desc += "\(prefix)\(idx). transform: \(transform)\n"
        }
        idx += 1
        return desc
    }
}

// MARK: - 👀
extension UIListContentConfiguration.ImageProperties {
    public var desc: String {
        var desc = "\n"
        var idx = 1
        let prefix = "        "
        if let preferredSymbolConfiguration {
            desc += "\(prefix)\(idx). preferredSymbolConfiguration: \(preferredSymbolConfiguration.description)\n"
        }
        idx += 1
        if let tintColor {
            desc += "\(prefix)\(idx). tintColor: \(tintColor.description)\n"
        }
        idx += 1
        if let tintColorTransformer {
            desc += "\(prefix)\(idx). tintColorTransformer: \(tintColorTransformer)\n"
        }
        idx += 1
        if cornerRadius > 0 {
            desc += "\(prefix)\(idx). cornerRadius: \(cornerRadius)\n"
        }
        idx += 1
        if maximumSize != .zero {
            desc += "\(prefix)\(idx). maximumSize: \(maximumSize)\n"
        }
        idx += 1
        if reservedLayoutSize != .zero {
            desc += "\(prefix)\(idx). reservedLayoutSize: \(reservedLayoutSize)\n"
        }
        idx += 1
        desc += "\(prefix)\(idx). accessibilityIgnoresInvertColors: \(accessibilityIgnoresInvertColors)\n"
        idx += 1
        desc += "\(prefix)\(idx). ImageProperties.standardDimension: \(UIListContentConfiguration.ImageProperties.standardDimension)\n"
        idx += 1
        return desc
    }
}

// MARK: - 👀UIListSeparatorConfiguration
@available(iOS 14.5, *)
extension UIListSeparatorConfiguration {
    public var desc: String {
        let visualEffectDesc: String? = if #available(iOS 15.0, *) {
            if let visualEffect {
                "\(visualEffect.description)"
            } else {
                nil
            }
        } else {
            // Fallback on earlier versions
            "UnSupported"
        }
        var desc = "\n"
        let prefix = "    "
        var idx = 1
        desc += "\(prefix)\(idx). topSeparatorVisibility: \(topSeparatorVisibility)\n"
        idx += 1
        desc += "\(prefix)\(idx). bottomSeparatorVisibility: \(bottomSeparatorVisibility)\n"
        idx += 1
        if UIListSeparatorConfiguration.automaticInsets != .zero {
            desc += "\(prefix)\(idx). UIListSeparatorConfiguration.automaticInsets: \(UIListSeparatorConfiguration.automaticInsets)\n"
        }
        idx += 1
        if topSeparatorInsets != .zero {
            desc += "\(prefix)\(idx). topSeparatorInsets: \(topSeparatorInsets)\n"
        }
        idx += 1
        if bottomSeparatorInsets != .zero {
            desc += "\(prefix)\(idx). bottomSeparatorInsets: \(bottomSeparatorInsets)\n"
        }
        idx += 1
        desc += "\(prefix)\(idx). color: \(color.xl.getColorName())\n"
        idx += 1
        desc += "\(prefix)\(idx). multipleSelectionColor: \(multipleSelectionColor.xl.getColorName())\n"
        idx += 1
        if let visualEffectDesc {
            desc += "\(prefix)\(idx). visualEffect: \(visualEffectDesc)\n"
        }
        idx += 1
        return desc.removingSuffix("\n")
    }
}

// MARK: - 👀UICollectionLayoutListConfiguration
extension UICollectionLayoutListConfiguration {
    @available(iOS 15.0, *)
    public var desc: String {
        var desc = ""
        let prefix = "    "
        var idx = 1
        desc += "\(prefix)\(idx). appearance: \(appearance)\n"
        idx += 1
        desc += "\(prefix)\(idx). showsSeparators: \(showsSeparators)\n"
        idx += 1
        desc += "\(prefix)\(idx). separatorConfiguration: \(separatorConfiguration)\n"
        idx += 1
        if let itemSeparatorHandler {
            desc += "\(prefix)\(idx). itemSeparatorHandler: \(String(describing: itemSeparatorHandler))\n"
        }
        idx += 1
        if let backgroundColor {
            desc += "\(prefix)\(idx). backgroundColor: \(backgroundColor.description)\n"
        }
        idx += 1
        if let leadingSwipeActionsConfigurationProvider {
            desc += "\(prefix)\(idx). leadingSwipeActionsConfigurationProvider: \(String(describing: leadingSwipeActionsConfigurationProvider))\n"
        }
        idx += 1
        if let trailingSwipeActionsConfigurationProvider {
            desc += "\(prefix)\(idx). trailingSwipeActionsConfigurationProvider: \(String(describing: trailingSwipeActionsConfigurationProvider))\n"
        }
        idx += 1
        desc += "\(prefix)\(idx). headerMode: \(headerMode)\n"
        idx += 1
        desc += "\(prefix)\(idx). footerMode: \(footerMode)\n"
        idx += 1
        if let headerTopPadding {
            desc += "\(prefix)\(idx). headerTopPadding: \(headerTopPadding)\n"
        }
        idx += 1
        return desc.removingSuffix("\n")
    }
}
