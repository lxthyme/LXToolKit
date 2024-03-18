//
//  DynamicLandExtension.swift
//  DynamicLandExtension
//
//  Created by lxthyme on 2024/3/15.
//

import WidgetKit
import SwiftUI

// struct Provider: AppIntentTimelineProvider {
//     func placeholder(in context: Context) -> SimpleEntry {
//         SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
//     }
// 
//     func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
//         SimpleEntry(date: Date(), configuration: configuration)
//     }
//     
//     func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
//         var entries: [SimpleEntry] = []
// 
//         // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//         let currentDate = Date()
//         for hourOffset in 0 ..< 5 {
//             let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//             let entry = SimpleEntry(date: entryDate, configuration: configuration)
//             entries.append(entry)
//         }
// 
//         return Timeline(entries: entries, policy: .atEnd)
//     }
// }

struct SimpleEntry: TimelineEntry {
    let date: Date
    let hero: EmojiRanger
    let relevance: TimelineEntryRelevance?
    // let configuration: ConfigurationAppIntent
}

extension View {
     func widgetBackground() -> some View {
         if #available(iOSApplicationExtension 17.0, *) {
             return containerBackground(for: .widget) {
                 Color.gameBackgroundColor
             }
         } else {
             return background {
                 Color.gameBackgroundColor
             }
         }
    }
}

struct DynamicLandExtensionEntryView : View {
    var entry: SimpleEntry

    @Environment(\.widgetFamily) private var family
    @AppStorage("supercharged", store: UserDefaults(suiteName: EmojiRanger.appGroup))
    var supercharged: Bool = EmojiRanger.herosAreSupercharged()

    var body: some View {
        switch family {
        case .accessoryCircular:
            ProgressView(timerInterval: entry.hero.injuryDate...entry.hero.fullHealthDate,
                         countsDown: false,
                         label: { Text(entry.hero.name) }) {
                LXAvatarView(hero: entry.hero, includeBackground: false)
            }
                         .progressViewStyle(.circular)
                         .widgetBackground()
        case .systemSmall:
            LXAvatarView(hero: entry.hero)
                .widgetURL(entry.hero.url)
                .foregroundStyle(.white)
                .widgetBackground()
        case .systemMedium:
            HStack(alignment: .top, content: {
                LXAvatarView(hero: entry.hero)
                    .foregroundStyle(.white)
                Text(entry.hero.bio)
                    .foregroundStyle(.white)
            })
            .widgetBackground()
            .widgetURL(entry.hero.url)
        case .systemLarge:
            VStack(content: {
                HStack(alignment: .top, content: {
                    LXAvatarView(hero: entry.hero)
                        .foregroundStyle(.white)
                    Text(entry.hero.bio)
                        .foregroundStyle(.white)
                })
                .padding()
#if os(iOS)
                if #available(iOSApplicationExtension 17.0, *) {
                    Button(intent: SuperCharge()) {
                        Text("⚡️")
                            .lineLimit(1)
                    }
                }
#endif
            })
            .widgetBackground()
            .widgetURL(entry.hero.url)
        case .accessoryRectangular:
            HStack(alignment: .center, content: {
                VStack(alignment: .leading, content: {
                    Text(entry.hero.name)
                        .font(.headline)
                        .widgetAccentable()
                    Text("Level \(entry.hero.level)")
                    Text(entry.hero.fullHealthDate, style: .timer)
                })
                .frame(maxWidth: .infinity, alignment: .leading)
                LXAvatarView(hero: entry.hero, includeBackground: false)
            })
            .widgetBackground()
        case .accessoryInline:
            ViewThatFits {
                Text("\(entry.hero.name) is healing, ready in \(entry.hero.fullHealthDate, style: .relative)")
                Text("\(entry.hero.name) ready in \(entry.hero.fullHealthDate, style: .relative)")
                Text("\(entry.hero.name) \(entry.hero.fullHealthDate, style: .timer)")
            }
            .widgetBackground()
        case .systemExtraLarge:
            Group {
                Text("family: \(family)")
                LXAvatarView(hero: entry.hero)
            }
            .widgetBackground()
        @unknown default:
            LXAvatarView(hero: entry.hero)
                .widgetBackground()
        }
    }
}

@available(iOS 17.0, *)
struct DynamicLandExtension: Widget {
    let kind: String = "DynamicLandExtension"

    private var supportedFamilies: [WidgetFamily] {
#if os(watchOS)
        []
#else
        [
            .accessoryCircular,
            .accessoryRectangular,
            .accessoryInline,
            .systemSmall,
            .systemMedium,
            .systemLarge,
        ]
#endif
    }

    func makeWidgetConfiguration() -> some WidgetConfiguration {
        // if #available(iOS 17.0, *) {
            return AppIntentConfiguration(kind: EmojiRanger.EmojiRangerWidgetKind,
                                          intent: ConfigurationAppIntent.self,
                                          provider: LXAppIntentProvider()) { entry in
                DynamicLandExtensionEntryView(entry: entry)
                    .widgetBackground()
            }
        // } else {
        //     // Fallback on earlier versions
        //     return IntentConfiguration(kind: EmojiRanger.EmojiRangerWidgetKind,
        //                                intent: LXDynamicLandIntent.self,
        //                                provider: <#T##IntentTimelineProvider#>, content: <#T##(TimelineEntry) -> View#>)
        // }
        // return AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: LXAppIntentProvider()) { entry in
        //     DynamicLandExtensionEntryView(entry: entry)
        //         .containerBackground(.fill.tertiary, for: .widget)
    }
    var body: some WidgetConfiguration {
        makeWidgetConfiguration()
            .configurationDisplayName("Ranger Detail")
            .description("See your favorite ranger.")
    }
}

let timeline = { () async -> [any TimelineEntry] in
    // SimpleEntry(date: .now, configuration: .smiley)
    // SimpleEntry(date: .now, configuration: .starEyes)
    [SimpleEntry(date: .now, hero: .panda, relevance: nil),
    SimpleEntry(date: .now, hero: .octo, relevance: nil)]
}

// @available(iOS 17.0, *)
// #Preview(as: .accessoryCircular, widget: {
//     DynamicLandExtension()
// }, timeline: timeline)
// #Preview(as: .accessoryCircular, widget: {
//     DynamicLandExtensionEntryView(entry: SimpleEntry(date: Date(), hero: .spouty, relevance: nil))
//         .widgetBackground()
//     // .previewContext(WidgetPreviewContext(family: .accessoryCircular))
//         .previewDisplayName("Circular")
// })
// }, timeline: timeline)
// @available(iOS 17.0, *)
// #Preview(body: {
private struct Widget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DynamicLandExtensionEntryView(entry: SimpleEntry(date: Date(), hero: .spouty, relevance: nil))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .previewDisplayName("small")
            DynamicLandExtensionEntryView(entry: SimpleEntry(date: Date(), hero: .spouty, relevance: nil))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
                .previewDisplayName("Medium")
            DynamicLandExtensionEntryView(entry: SimpleEntry(date: Date(), hero: .spouty, relevance: nil))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
                .previewDisplayName("Large")
            DynamicLandExtensionEntryView(entry: SimpleEntry(date: Date(), hero: .spouty, relevance: nil))
                .previewContext(WidgetPreviewContext(family: .systemExtraLarge))
                .previewDisplayName("ExtraLarge")
            DynamicLandExtensionEntryView(entry: SimpleEntry(date: Date(), hero: .spouty, relevance: nil))
                .previewContext(WidgetPreviewContext(family: .accessoryCircular))
                .previewDisplayName("Circular")
            DynamicLandExtensionEntryView(entry: SimpleEntry(date: Date(), hero: .spouty, relevance: nil))
                .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
                .previewDisplayName("Rectangular")
            DynamicLandExtensionEntryView(entry: SimpleEntry(date: Date(), hero: .spouty, relevance: nil))
                .previewContext(WidgetPreviewContext(family: .accessoryInline))
                .previewDisplayName("Inline")
        }
    }
}
