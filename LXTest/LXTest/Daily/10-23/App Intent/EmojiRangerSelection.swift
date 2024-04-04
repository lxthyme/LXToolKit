//
//  EmojiRangerSelection.swift
//  LXTest
//
//  Created by lxthyme on 2023/10/24.
//

import SwiftUI
import AppIntents
import WidgetKit

@available(iOS 16.2, macOS 13.0, watchOS 9.0, tvOS 16.0, *)
struct EmojiRangerSelection: AppIntent, CustomIntentMigratedAppIntent, WidgetConfigurationIntent {
    static let intentClassName = "EmojiRangerSelectionIntent"

    static var title: LocalizedStringResource = "Emoji Ranger Selection"
    static var description = IntentDescription("Select Hero")

    @Parameter(title: "Selected Hero", optionsProvider: StringOptionsProvider())
    var heroName: String?

    struct StringOptionsProvider: DynamicOptionsProvider {
        func results() async throws -> [String] {
            let heros = EmojiRanger.allHeros
            return heros.compactMap { $0.name }
        }
    }

    func perform() async throws -> some IntentResult {
        return .result()
    }
}
