//
//  WhatsNewManager.swift
//  SwiftHub
//
//  Created by Sygnoos9 on 12/16/18.
//  Copyright © 2018 Khoren Markosyan. All rights reserved.
//

import Foundation
import WhatsNewKit

typealias WhatsNewBlock = (WhatsNew, WhatsNewConfiguration, KeyValueWhatsNewVersionStore?)
typealias WhatsNewConfiguration = WhatsNewViewController.Configuration

class WhatsNewManager: NSObject {

    /// The default singleton instance.
    static let shared = WhatsNewManager()

    func whatsNew(trackVersion track: Bool = true) -> WhatsNewBlock {
        return (items(), configuration(), track ? versionStore(): nil)
    }

    private func items() -> WhatsNew {
        let whatsNew = WhatsNew(
            title: R.string.localizabled.whatsNewTitle(),
            items: [
                WhatsNew.Item(title: R.string.localizabled.whatsNewItem4Title(),
                              subtitle: R.string.localizabled.whatsNewItem4Subtitle(),
                              image: R.image.icon_whatsnew_trending()),
                WhatsNew.Item(title: R.string.localizabled.whatsNewItem1Title(),
                              subtitle: R.string.localizabled.whatsNewItem1Subtitle(),
                              image: R.image.icon_whatsnew_cloc()),
                WhatsNew.Item(title: R.string.localizabled.whatsNewItem2Title(),
                              subtitle: R.string.localizabled.whatsNewItem2Subtitle(),
                              image: R.image.icon_whatsnew_theme()),
                WhatsNew.Item(title: R.string.localizabled.whatsNewItem3Title(),
                              subtitle: R.string.localizabled.whatsNewItem3Subtitle(),
                              image: R.image.icon_whatsnew_github())
            ])
        return whatsNew
    }

    private func configuration() -> WhatsNewViewController.Configuration {
        var configuration = WhatsNewViewController.Configuration(
            detailButton: .init(title: R.string.localizabled.whatsNewDetailButtonTitle(),
                                action: .website(url: Configs.App.githubUrl)),
            completionButton: .init(stringLiteral: R.string.localizabled.whatsNewCompletionButtonTitle())
        )
        //        configuration.itemsView.layout = .centered
        configuration.itemsView.imageSize = .original
        configuration.apply(animation: .slideRight)
        if ThemeType.currentTheme().isDark {
            configuration.apply(theme: .darkRed)
            configuration.backgroundColor = .primaryDark()
        } else {
            configuration.apply(theme: .whiteRed)
            configuration.backgroundColor = .white
        }
        return configuration
    }

    private func versionStore() -> KeyValueWhatsNewVersionStore {
        let versionStore = KeyValueWhatsNewVersionStore(keyValueable: UserDefaults.standard,
                                                        prefixIdentifier: Configs.App.bundleIdentifier)
        return versionStore
    }
}
