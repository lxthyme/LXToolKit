//
//  LXLeaderboardProvider.swift
//  LXTest
//
//  Created by lxthyme on 2024/3/18.
//

import WidgetKit
import SwiftUI

@available(iOS 16.2, *)
struct LXLeaderboardEntry: TimelineEntry {
    public let date: Date
    var heros: [EmojiRanger]?
}

@available(iOS 16.2, *)
struct LXLeaderboardPlaceholderView: View {
    var body: some View {
        LXLeaderboardWidgetEntryView(entry: LXLeaderboardEntry(date: Date(), heros: EmojiRanger.availableHeros))
    }
}

@available(iOS 16.2, *)
struct LXLeaderboardProvider: TimelineProvider {
    typealias Entry = LXLeaderboardEntry

    func placeholder(in context: Context) -> LXLeaderboardEntry {
        return LXLeaderboardEntry(date: Date(), heros: EmojiRanger.availableHeros)
    }

    func getSnapshot(in context: Context, completion: @escaping (LXLeaderboardEntry) -> Void) {
        let entry = LXLeaderboardEntry(date: Date(), heros: EmojiRanger.availableHeros)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<LXLeaderboardEntry>) -> Void) {
        EmojiRanger.loadLeaderboardData { (heros, error) in
            guard let heros else {
                let timeline = Timeline(entries: [LXLeaderboardEntry(date: Date(), heros: EmojiRanger.availableHeros)],
                                        policy: .atEnd)
                completion(timeline)
                return
            }
            let timeline = Timeline(entries: [LXLeaderboardEntry(date: Date(), heros: EmojiRanger.availableHeros)],
                                    policy: .atEnd)
            completion(timeline)
        }
    }

}

@available(iOS 16.2, *)
struct LXLeaderboardWidgetEntryView: View {
    var entry: LXLeaderboardProvider.Entry
    var body: some View {
        LXAllCharactersView(heros: entry.heros)
            .padding()
            .widgetBackground()
    }
}

@available(iOS 16.2, *)
struct LXLeaderboardWidget: Widget {
    private static var supportedFamilies: [WidgetFamily] {
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
        StaticConfiguration(kind: EmojiRanger.LeaderboardWidgetKind,
                            provider: LXLeaderboardProvider()) { entry in
            LXLeaderboardWidgetEntryView(entry: entry)
        }
                            .configurationDisplayName("Ranger Leaderboard")
                            .description("See all the rangers.")
                            .supportedFamilies(LXLeaderboardWidget.supportedFamilies)
    }
}

// #Preview(body: {
struct LXLeaderboardWidgetEntryView_Previews: PreviewProvider {
    static var previews: some View {
        LXLeaderboardWidgetEntryView(entry: LXLeaderboardEntry(date: Date(), heros: nil))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
