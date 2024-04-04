//
//  EmojiRangersIntents.swift
//  EmojiRangersIntents
//
//  Created by lxthyme on 2023/10/24.
//

import AppIntents

struct EmojiRangersIntents: AppIntent {
    static var title: LocalizedStringResource = "EmojiRangersIntents"

    func perform() async throws -> some IntentResult {
        return .result()
    }
}
