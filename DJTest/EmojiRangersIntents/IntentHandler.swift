//
//  IntentHandler.swift
//  EmojiRangersIntents
//
//  Created by lxthyme on 2023/10/24.
//

import Intents

@available(iOS 16.2, *)
class IntentHandler: INExtension, EmojiRangerSelectionIntentHandling {
    func provideHeoNameOptionsCollection(for intent: EmojiRangerSelectionIntent) async throws -> INObjectCollection<NSString> {
        let heros: [NSString] = EmojiRanger.allHeros.map { hero in
            hero.name as NSString
        }

        return INObjectCollection(items: heros)
    }

    override func handler(for intent: INIntent) -> Any {
        return self
    }
}
