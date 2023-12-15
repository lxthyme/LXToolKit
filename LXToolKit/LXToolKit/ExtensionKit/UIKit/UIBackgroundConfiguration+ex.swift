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
        return """

        \(title):
            1. image: \(configuration.image?.description ?? "NaN")
            2. imageProperties: \(configuration.imageProperties.desc)
            3. text: \(configuration.text ?? "NaN")
            4. attributedText: \(configuration.attributedText?.description ?? "NaN")
            5. textProperties: \(configuration.textProperties.desc)
            6. secondaryText: \(configuration.secondaryText ?? "NaN")
            7. secondaryAttributedText: \(configuration.secondaryAttributedText?.description ?? "NaN")
            8. secondaryTextProperties: \(configuration.secondaryTextProperties.desc)
            9. axesPreservingSuperviewLayoutMargins: \(configuration.axesPreservingSuperviewLayoutMargins)
            10. directionalLayoutMargins: \(configuration.directionalLayoutMargins)
            11. prefersSideBySideTextAndSecondaryText: \(configuration.prefersSideBySideTextAndSecondaryText)
            12. imageToTextPadding: \(configuration.imageToTextPadding)
            13. textToSecondaryTextHorizontalPadding: \(configuration.textToSecondaryTextHorizontalPadding)
            14. textToSecondaryTextVerticalPadding: \(configuration.textToSecondaryTextVerticalPadding)

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
            11. showsExpansionTextWhenTruncated: \(showsExpansionTextWhenTruncated)
            12. transform: \(transform)
        """
    }
}

// MARK: - 👀
extension UIListContentConfiguration.ImageProperties {
    public var desc: String {
        return """
            1. preferredSymbolConfiguration: \(preferredSymbolConfiguration?.description ?? "NaN")
            2. tintColor: \(tintColor?.description ?? "NaN")
            3. tintColorTransformer: \(tintColorTransformer.debugDescription )
            4. cornerRadius: \(cornerRadius)
            5. maximumSize: \(maximumSize)
            6. reservedLayoutSize: \(reservedLayoutSize)
            7. accessibilityIgnoresInvertColors: \(accessibilityIgnoresInvertColors)
            8. ImageProperties.standardDimension: \(UIListContentConfiguration.ImageProperties.standardDimension)
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
