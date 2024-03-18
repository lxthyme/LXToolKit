//
//  AppIntent.swift
//  DynamicLandExtension
//
//  Created by lxthyme on 2024/3/15.
//

import WidgetKit
import AppIntents

// MARK: - 👀
extension ConfigurationAppIntent {
    struct StringOptionsProvider: DynamicOptionsProvider {
        func results() async throws -> [String] {
            let heros = EmojiRanger.allHeros
            return heros.compactMap { $0.name }
        }
    }
}

@available(iOS 16.2, *)
struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static let intentClassName = "LXDynamicLandIntent"

    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("Select your hero")

    // An example configurable parameter.
    @Parameter(title: "Selected Hero", optionsProvider: StringOptionsProvider())
    var heroName: String?

    func perform() async throws -> some IntentResult {
        return .result()
    }
}
