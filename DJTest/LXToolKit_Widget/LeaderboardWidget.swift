//
//  LeaderboardWidget.swift
//  DJTest
//
//  Created by lxthyme on 2023/10/25.
//

import SwiftUI
import WidgetKit

struct LeaderboardProvider: TimelineProvider {
    public typealias Entry = LeaderboardEntry

    func placeholder(in context: Context) -> LeaderboardEntry {
        return LeaderboardEntry(date: Date(), heros: EmojiRanger.availableHeros)
    }

    func getSnapshot(in context: Context, completion: @escaping (LeaderboardEntry) -> Void) {
        let entry = LeaderboardEntry(date: Date(), heros: EmojiRanger.availableHeros)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<LeaderboardEntry>) -> Void) {
        EmojiRanger.loadLeaderboardData { heros, error in
            guard let heros else {
                let timeline = Timeline(entries: [LeaderboardEntry(date: Date(), heros: EmojiRanger.availableHeros)], policy: .atEnd)

                completion(timeline)
                return
            }
            let timeline = Timeline(entries: [LeaderboardEntry(date: Date(), heros: heros)], policy: .atEnd)
            completion(timeline)
        }
    }

}

struct LeaderboardEntry: TimelineEntry {
    public let date: Date
    var heros: [EmojiRanger]?
}

struct LeaderboardPlaceholderView: View {
    var body: some View {
        LeaderboardWidgetEntryView(entry: LeaderboardEntry(date: Date(), heros: nil))
    }
}

struct LeaderboardWidgetEntryView: View {
    var entry: LeaderboardProvider.Entry

    var body: some View {
        AllCharactersView(heros: entry.heros)
            .padding()
            .widgetBackground()
    }
}

struct LeaderboardWidget: Widget {
    private static var supportedFamliles: [WidgetFamily] {
        #if os(iOS)
        if #available(iOS 15.0, *) {
            return [.systemLarge, .systemExtraLarge]
        } else {
            // Fallback on earlier versions
            return [.systemLarge]
        }
        #else
        return []
        #endif
    }

    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: EmojiRanger.LeaderboardWidgetKind,
            provider: LeaderboardProvider()) { entry in
                LeaderboardWidgetEntryView(entry: entry)
            }
            .configurationDisplayName("Ranger Leaderboard")
            .description("See all the rangers.")
            .supportedFamilies(LeaderboardWidget.supportedFamliles)
    }
}

#Preview {
    Group {
        #if os(iOS)
        LeaderboardWidgetEntryView(entry: LeaderboardEntry(date: Date(), heros: nil))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
        #endif
    }
}

@available(iOS 17.0, *)
#Preview(as: .systemSmall, widget: {
    LeaderboardWidget()
}, timelineProvider: {
    LeaderboardProvider()
})
