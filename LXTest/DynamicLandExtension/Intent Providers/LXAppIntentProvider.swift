//
//  LXAppIntentProvider.swift
//  LXTest
//
//  Created by lxthyme on 2024/3/18.
//

import SwiftUI
import WidgetKit

@available(iOS 16.0, *)
struct LXAppIntentProvider: AppIntentTimelineProvider {
    typealias Entry = SimpleEntry
    // typealias Intent = <#type#>
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), hero: .spouty, relevance: nil)
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), hero: .spouty, relevance: nil)
    }

    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        let selectedHero = hero(for: configuration)
        let endDate = selectedHero.fullHealthDate
        let oneMinute: TimeInterval = 60
        var currentDate = Date()
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        // let currentDate = Date()
        // for hourOffset in 0 ..< 5 {
        //     let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
        //     let entry = SimpleEntry(date: entryDate, configuration: configuration)
        //     entries.append(entry)
        // }
        while currentDate < endDate {
            let relevance = TimelineEntryRelevance(score: Float(selectedHero.healthLevel))
            let entry = SimpleEntry(date: currentDate, hero: selectedHero, relevance: relevance)
            currentDate += oneMinute
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

// MARK: - 👀
extension LXAppIntentProvider {
    func hero(for configuration: ConfigurationAppIntent) -> EmojiRanger {
        if let name = configuration.heroName {
            EmojiRanger.setLastSelectedHero(heroName: name)
            return EmojiRanger.heroFromName(name: name)
        }
        return .spouty
    }
}
