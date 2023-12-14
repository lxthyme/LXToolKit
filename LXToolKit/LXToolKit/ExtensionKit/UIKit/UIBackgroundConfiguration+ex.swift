//
//  UIBackgroundConfiguration+ex.swift
//  LXToolKit
//
//  Created by lxthyme on 2023/12/13.
//

import Foundation

// MARK: - 👀UIListContentConfiguration
extension UIListContentConfiguration {
    @available(iOS 15.0, *)
    public static var allConfiguration: [UIListContentConfiguration] {
        var list: [UIListContentConfiguration] = [
            .cell(),
            .subtitleCell(),
            .valueCell(),
            .plainHeader(),
            .plainFooter(),
            .groupedHeader(),
            .groupedFooter(),
            .prominentInsetGroupedHeader(),
            .extraProminentInsetGroupedHeader(),
            .sidebarCell(),
            .sidebarSubtitleCell(),
            .accompaniedSidebarCell(),
            .accompaniedSidebarSubtitleCell(),
            .sidebarHeader(),
            UICollectionViewListCell().defaultContentConfiguration(),
            UITableViewCell().defaultContentConfiguration(),
            UITableViewHeaderFooterView().defaultContentConfiguration(),
        ]
        return list
    }
}

// MARK: - 👀UIBackgroundConfiguration
extension UIBackgroundConfiguration {
    public static var allConfiguration: [UIBackgroundConfiguration] {
        var list: [UIBackgroundConfiguration] = [
            .clear(),
            .listPlainCell(),
            .listPlainHeaderFooter(),
            .listGroupedCell(),
            .listGroupedHeaderFooter(),
            .listSidebarHeader(),
            .listSidebarCell(),
            .listAccompaniedSidebarCell(),
        ]
        if #available(iOS 16.0, *) {
            list.append(contentsOf: [
                UICollectionViewCell().defaultBackgroundConfiguration(),
                UICollectionViewListCell().defaultBackgroundConfiguration(),
                UITableViewCell().defaultBackgroundConfiguration(),
                UITableViewHeaderFooterView().defaultBackgroundConfiguration(),
            ])
        }
        return list
    }
    public var info: String {
        let imageDesc: String
        let imageContentModeDesc: String
        if #available(iOS 15.0, *) {
            imageDesc = image?.description ?? ""
            imageContentModeDesc = imageContentMode.rawValue.description
        } else {
            imageDesc = "--UnAvailable--"
            imageContentModeDesc = "--UnAvailable--"
        }
        return """
            1. customView: \(customView?.description ?? "NaN")
            2. cornerRadius: \(cornerRadius)
            3. backgroundInsets: \(backgroundInsets)
            4. edgesAddingLayoutMarginsToBackgroundInsets: \(edgesAddingLayoutMarginsToBackgroundInsets)
            5. backgroundColor: \(backgroundColor?.description ?? "NaN")
            6. backgroundColorTransformer: \(backgroundColorTransformer.debugDescription)
            7. visualEffect: \(visualEffect?.description ?? "NaN")
            8. image: \(imageDesc)
            9. imageContentMode: \(imageContentModeDesc)
            10. strokeColor: \(strokeColor?.description ?? "NaN")
            11. strokeColorTransformer: \(strokeColorTransformer.debugDescription)
            12. strokeWidth: \(strokeWidth)
            13. strokeOutset: \(strokeOutset)
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
