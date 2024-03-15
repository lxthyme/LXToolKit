//
//  AppIntent.swift
//  DynamicLandExtension
//
//  Created by lxthyme on 2024/3/15.
//

import WidgetKit
import AppIntents

@available(iOS 16.2, *)
struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("This is an example widget.")

    // An example configurable parameter.
    @Parameter(title: "Favorite Emoji", default: "default[233]: 😃")
    var favoriteEmoji: String

    func perform() async throws -> some IntentResult {
        return .result()
    }
}
