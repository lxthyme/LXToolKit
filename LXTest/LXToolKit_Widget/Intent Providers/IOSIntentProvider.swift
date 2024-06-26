//
//  IOSIntentProvider.swift
//  LXTest
//
//  Created by lxthyme on 2023/10/24.
//

import SwiftUI
import WidgetKit

#if os(iOS)
struct SiriKitIntentProvider: IntentTimelineProvider {
    typealias Intent = EmojiRangerSelectionIntent
    public typealias Entry = SimpleEntry

    func recommendations() -> [IntentRecommendation<EmojiRangerSelectionIntent>] {
        return recommendedIntents()
            .map { intent in
                return IntentRecommendation(intent: intent, description: intent.heoName ?? "Spouty")
            }
    }
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), relevance: nil, hero: .spouty)
    }
    func getSnapshot(for configuration: Intent, in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date(), relevance: nil, hero: .spouty)
        completion(entry)
    }
    func getTimeline(for configuration: Intent, in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        let selectedCharacter = hero(for: configuration)
        let endDate = selectedCharacter.fullHealthDate
        let oneMinute: TimeInterval = 60
        var currentDate = Date()
        var entries: [SimpleEntry] = []

        while currentDate < endDate {
            let relevance = TimelineEntryRelevance(score: Float(selectedCharacter.healthLevel))
            let entry = SimpleEntry(date: currentDate, relevance: relevance, hero: selectedCharacter)

            currentDate += oneMinute
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

    func hero(for configuarion: EmojiRangerSelectionIntent) -> EmojiRanger {
        if let name = configuarion.heoName {
            EmojiRanger.setLastSelectedHero(heroName: name)
            return EmojiRanger.heroFromName(name: name)
        }
        return .spouty
    }
    private func recommendedIntents() -> [EmojiRangerSelectionIntent] {
        return EmojiRanger.availableHeros
            .map { hero in
                let intent = EmojiRangerSelectionIntent()
                intent.heoName = hero.name
                return intent
            }
    }

}

@available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, *)
struct AppIntentProvider: AppIntentTimelineProvider {
    typealias Entry = SimpleEntry
    typealias Intent = EmojiRangerSelection

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), relevance: nil, hero: .spouty)
    }
    func snapshot(for configuration: EmojiRangerSelection, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), relevance: nil, hero: .spouty)
    }

    func timeline(for configuration: EmojiRangerSelection, in context: Context) async -> Timeline<SimpleEntry> {
        let selectedCharacter = hero(for: configuration)
        let endDate = selectedCharacter.fullHealthDate
        let oneMinute: TimeInterval = 60
        var currentDate = Date()
        var entries: [SimpleEntry] = []

        while currentDate < endDate {
            let relevance = TimelineEntryRelevance(score: Float(selectedCharacter.healthLevel))
            let entry = SimpleEntry(date: currentDate, relevance: relevance, hero: selectedCharacter)
            currentDate += oneMinute
            entries.append(entry)
        }
        return Timeline(entries: entries, policy: .atEnd)
    }

    func hero(for configuration: EmojiRangerSelection) -> EmojiRanger {
        if let name = configuration.heroName {
            EmojiRanger.setLastSelectedHero(heroName: name)
            return EmojiRanger.heroFromName(name: name)
        }
        return .spouty
    }
}

#endif
