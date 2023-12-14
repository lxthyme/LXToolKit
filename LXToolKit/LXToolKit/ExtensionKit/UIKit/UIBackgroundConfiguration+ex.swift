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
        return "\(title): \(configuration?.description ?? "UnSupported")"
    }
}

// MARK: - 👀UIBackgroundConfiguration
public extension UIBackgroundConfiguration {
    enum Ex {
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
            imageDesc = configuration.image?.description ?? ""
            imageContentModeDesc = configuration.imageContentMode.rawValue.description
        } else {
            imageDesc = "--UnAvailable--"
            imageContentModeDesc = "--UnAvailable--"
        }
        return """
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

// MARK: - 👀UIListSeparatorConfiguration
// @available(iOS 14.5, *)
// extension UIListSeparatorConfiguration {
//     public static var allConfiguration: [UIListSeparatorConfiguration] {
//         var list: [UIListSeparatorConfiguration] = [
//         ]
//         return list
//     }
// }

// MARK: - 👀UICollectionLayoutListConfiguration
// extension UICollectionLayoutListConfiguration {
//     public static var allConfiguration: [UICollectionLayoutListConfiguration] {
//         var list: [UICollectionLayoutListConfiguration] = [
//         ]
//         return list
//     }
// }
