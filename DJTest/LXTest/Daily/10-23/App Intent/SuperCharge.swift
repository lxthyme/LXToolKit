//
//  SuperCharge.swift
//  LXTest
//
//  Created by lxthyme on 2023/10/24.
//

import SwiftUI
import AppIntents
import WidgetKit

@available(iOS 16.2, macOS 13.0, watchOS 9.0, tvOS 16.0, *)
struct SuperCharge: AppIntent {
    static var title: LocalizedStringResource = "Emoji Ranger SuperCharger"
    static var description = IntentDescription("All heroes get instant 100% health.")

    func perform() async throws -> some IntentResult {
        EmojiRanger.superchargeHeros()
        return .result()
    }
}
