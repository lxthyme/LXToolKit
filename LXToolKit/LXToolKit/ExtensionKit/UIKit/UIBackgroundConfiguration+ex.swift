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
        let prefix = "\n   "
        var idx = 1
        if let image = configuration.image {
            desc += "\(prefix)\(idx). image: \(image.description)"
        }
        idx += 1
        if configuration.imageProperties.desc.isNotEmpty {
            desc += "\(prefix)\(idx). imageProperties: \(configuration.imageProperties.desc)"
        }
        idx += 1
        if let text = configuration.text,
           text.isNotEmpty {
            desc += "\(prefix)\(idx). text: \(text)"
        }
        idx += 1
        if let attributedText = configuration.attributedText {
            desc += "\(prefix)\(idx). attributedText: \(attributedText.description)"
        }
        idx += 1
        if configuration.textProperties.desc.isNotEmpty {
            desc += "\(prefix)\(idx). textProperties: \(configuration.textProperties.desc)"
        }
        idx += 1
        if let secondaryText = configuration.secondaryText,
           secondaryText.isNotEmpty {
            desc += "\(prefix)\(idx). secondaryText: \(secondaryText)"
        }
        idx += 1
        if let secondaryAttributedText = configuration.secondaryAttributedText {
            desc += "\(prefix)\(idx). secondaryAttributedText: \(secondaryAttributedText.description)"
        }
        idx += 1
        if configuration.secondaryTextProperties.desc.isNotEmpty {
            desc += "\(prefix)\(idx). secondaryTextProperties: \(configuration.secondaryTextProperties.desc)"
        }
        idx += 1
        desc += "\(prefix)\(idx). axesPreservingSuperviewLayoutMargins: \(configuration.axesPreservingSuperviewLayoutMargins)"
        idx += 1
        if configuration.directionalLayoutMargins != .zero {
            desc += "\(prefix)\(idx). directionalLayoutMargins: \(configuration.directionalLayoutMargins)"
        }
        idx += 1
        desc += "\(prefix)\(idx). prefersSideBySideTextAndSecondaryText: \(configuration.prefersSideBySideTextAndSecondaryText)"
        idx += 1
        if configuration.imageToTextPadding != 0 {
            desc += "\(prefix)\(idx). imageToTextPadding: \(configuration.imageToTextPadding)"
        }
        idx += 1
        if configuration.textToSecondaryTextHorizontalPadding != 0 {
            desc += "\(prefix)\(idx). textToSecondaryTextHorizontalPadding: \(configuration.textToSecondaryTextHorizontalPadding)"
        }
        idx += 1
        if configuration.textToSecondaryTextVerticalPadding != 0 {
            desc += "\(prefix)\(idx). textToSecondaryTextVerticalPadding: \(configuration.textToSecondaryTextVerticalPadding)"
        }
        idx += 1
        return """
        \(desc)
        """
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

        var configuration: UIBackgroundConfiguration? {
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
        var title: String {
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
        let imageDesc: String
        let imageContentModeDesc: String
        if #available(iOS 15.0, *) {
            imageDesc = configuration.image?.description ?? "NaN"
            imageContentModeDesc = configuration.imageContentMode.rawValue.description
        } else {
            imageDesc = "--UnAvailable--"
            imageContentModeDesc = "--UnAvailable--"
        }
        return """
        \(title):
            1. customView: \(configuration.customView?.description ?? "NaN")
            2. cornerRadius: \(configuration.cornerRadius)
            3. backgroundInsets: \(configuration.backgroundInsets)
            4. edgesAddingLayoutMarginsToBackgroundInsets: \(configuration.edgesAddingLayoutMarginsToBackgroundInsets)
            5. backgroundColor: \(configuration.backgroundColor?.description ?? "NaN")
            6. backgroundColorTransformer: \(configuration.backgroundColorTransformer.debugDescription)
            7. visualEffect: \(configuration.visualEffect?.description ?? "NaN")
            8. image: \(imageDesc)
            9. imageContentMode: \(imageContentModeDesc)
            10. strokeColor: \(configuration.strokeColor?.description ?? "NaN")
            11. strokeColorTransformer: \(configuration.strokeColorTransformer.debugDescription)
            12. strokeWidth: \(configuration.strokeWidth)
            13. strokeOutset: \(configuration.strokeOutset)
        """
    }
}

// MARK: - 👀
extension UIListContentConfiguration.TextProperties {
    public var desc: String {
        var t_showsExpansionTextWhenTruncated: Bool?
        if #available(iOS 16.0, *) {
            t_showsExpansionTextWhenTruncated = showsExpansionTextWhenTruncated
        }
        return """
            1. font: \(font)
            2. color: \(color)
            3. colorTransformer: \(colorTransformer.debugDescription)
            4. alignment: \(alignment)
            5. lineBreakMode: \(lineBreakMode)
            6. numberOfLines: \(numberOfLines)
            7. adjustsFontSizeToFitWidth: \(adjustsFontSizeToFitWidth)
            8. minimumScaleFactor: \(minimumScaleFactor)
            9. allowsDefaultTighteningForTruncation: \(allowsDefaultTighteningForTruncation)
            10. adjustsFontForContentSizeCategory: \(adjustsFontForContentSizeCategory)
            11. showsExpansionTextWhenTruncated: \(t_showsExpansionTextWhenTruncated?.description ?? "UnSupported")
            12. transform: \(transform)
        """
    }
}

// MARK: - 👀
extension UIListContentConfiguration.ImageProperties {
    public var desc: String {
        var desc = ""
        var idx = 1
        let prefix = "\n        "
        if let preferredSymbolConfiguration {
            desc += "\(prefix)\(idx). preferredSymbolConfiguration: \(preferredSymbolConfiguration.description)"
        }
        idx += 1
        if let tintColor {
            desc += "\(prefix)\(idx). tintColor: \(tintColor.description)"
        }
        idx += 1
        desc += "\(prefix)\(idx). tintColorTransformer: \(tintColorTransformer.debugDescription)"
        idx += 1
        if cornerRadius > 0 {
            desc += "\(prefix)\(idx). cornerRadius: \(cornerRadius)"
        }
        idx += 1
        if maximumSize != .zero {
            desc += "\(prefix)\(idx). maximumSize: \(maximumSize)"
        }
        idx += 1
        if reservedLayoutSize != .zero {
            desc += "\(prefix)\(idx). reservedLayoutSize: \(reservedLayoutSize)"
        }
        idx += 1
        desc += "\(prefix)\(idx). accessibilityIgnoresInvertColors: \(accessibilityIgnoresInvertColors)"
        idx += 1
        desc += "\(prefix)\(idx). ImageProperties.standardDimension: \(UIListContentConfiguration.ImageProperties.standardDimension)"
        idx += 1
        return """
        \(desc)
        """
    }
}

// MARK: - 👀UIListSeparatorConfiguration
@available(iOS 14.5, *)
extension UIListSeparatorConfiguration {
    public var desc: String {
        let visualEffect: String = if #available(iOS 15.0, *) {
            "\(visualEffect?.description ?? "NaN")"
        } else {
            // Fallback on earlier versions
            "UnSupported"
        }
        return """
            1. topSeparatorVisibility: \(topSeparatorVisibility)
            2. bottomSeparatorVisibility: \(bottomSeparatorVisibility)
            3. UIListSeparatorConfiguration.automaticInsets: \(UIListSeparatorConfiguration.automaticInsets)
            4. topSeparatorInsets: \(topSeparatorInsets)
            5. bottomSeparatorInsets: \(bottomSeparatorInsets)
            6. color: \(color)
            7. multipleSelectionColor: \(multipleSelectionColor)
            8. visualEffect: \(visualEffect)
        """
    }
}

// MARK: - 👀UICollectionLayoutListConfiguration
extension UICollectionLayoutListConfiguration {
    @available(iOS 15.0, *)
    public var desc: String {
        return """
            1. appearance: \(appearance)
            2. showsSeparators: \(showsSeparators)
            3. separatorConfiguration: \(separatorConfiguration)
            4. itemSeparatorHandler: \(itemSeparatorHandler.debugDescription)
            5. backgroundColor: \(backgroundColor?.description ?? "NaN")
            6. leadingSwipeActionsConfigurationProvider: \(leadingSwipeActionsConfigurationProvider.debugDescription)
            7. trailingSwipeActionsConfigurationProvider: \(trailingSwipeActionsConfigurationProvider.debugDescription)
            8. headerMode: \(headerMode)
            9. footerMode: \(footerMode)
            10. headerTopPadding: \(headerTopPadding ?? 0)
        """
    }
}
