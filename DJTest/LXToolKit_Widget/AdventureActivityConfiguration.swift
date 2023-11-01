//
//  AdventureActivityConfiguration.swift
//  DJTest
//
//  Created by lxthyme on 2023/10/24.
//

import SwiftUI
import WidgetKit

struct AdventureActivityConfiguration: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: AdventureAttributes.self) { ctx in
            AdventureLiveActivityView(
                hero: ctx.attributes.hero,
                isStale: ctx.isStale,
                contentState: ctx.state
            )
            .activityBackgroundTint(.liveActivityBackground.opacity(0.25))
        } dynamicIsland: { ctx in
            DynamicIsland {
                expandedContent(
                    hero: ctx.attributes.hero,
                    contentState: ctx.state,
                    isStale: ctx.isStale
                )
            } compactLeading: {
                Avatar(hero: ctx.attributes.hero,
                       includeBackground: true)
            } compactTrailing: {
                ProgressView(value: ctx.state.currentHealthLevel, total: 1) {
                    Text("\(Int(ctx.state.currentHealthLevel * 100))")
                }
            } minimal: {
                ProgressView(value: ctx.state.currentHealthLevel, total: 1) {
                    Avatar(hero: ctx.attributes.hero, includeBackground: false)
                }
                .progressViewStyle(.circular)
                .tint(ctx.state.currentHealthLevel <= 0.2 ? .red : .green)
            }
        }

    }
    @DynamicIslandExpandedContentBuilder
    private func expandedContent(hero: EmojiRanger,
                                 contentState: AdventureAttributes.ContentState,
                                 isStale: Bool) -> DynamicIslandExpandedContent<some View> {
        DynamicIslandExpandedRegion(.leading) {
            LiveActivityAvatarView(hero: hero)
        }
        DynamicIslandExpandedRegion(.trailing) {
            StatsView(hero: hero, isStale: isStale)
        }
        DynamicIslandExpandedRegion(.bottom) {
            HealthBar(currentHealthLevel: contentState.currentHealthLevel)
            EventDescriptionView(hero: hero, contentState: contentState)
        }
    }
}

extension AdventureAttributes {
    fileprivate static var preview: AdventureAttributes {
        AdventureAttributes(hero: EmojiRanger.spouty)
    }
}
extension AdventureAttributes.ContentState {
    fileprivate static var smiley: AdventureAttributes.ContentState {
        AdventureAttributes.ContentState(currentHealthLevel: 0.1, eventDescription: "0.1预览")
     }

     fileprivate static var starEyes: AdventureAttributes.ContentState {
         AdventureAttributes.ContentState(currentHealthLevel: 0.9, eventDescription: "0.9预览 Egghead comes from the magical ")
     }
}
@available(iOS 17.0, *)
#Preview("EmojiRanger-content",
         as: .content,
         using: AdventureAttributes.preview) {
    AdventureActivityConfiguration()
} contentStates: {
    AdventureAttributes.ContentState.smiley
    AdventureAttributes.ContentState.starEyes
}
// @available(iOS 17.0, *)
// #Preview("dynamicIsland.minimal",
//          as: .dynamicIsland(.minimal),
//          using: AdventureAttributes.preview) {
//     AdventureActivityConfiguration()
// } contentStates: {
//     AdventureAttributes.ContentState.smiley
//     AdventureAttributes.ContentState.starEyes
// }
// 
// @available(iOS 17.0, *)
// #Preview("dynamicIsland.compact",
//          as: .dynamicIsland(.compact),
//          using: AdventureAttributes.preview) {
//     AdventureActivityConfiguration()
// } contentStates: {
//     AdventureAttributes.ContentState.smiley
//     AdventureAttributes.ContentState.starEyes
// }
// 
// @available(iOS 17.0, *)
// #Preview("dynamicIsland.expanded",
//          as: .dynamicIsland(.expanded),
//          using: AdventureAttributes.preview) {
//     AdventureActivityConfiguration()
// } contentStates: {
//     AdventureAttributes.ContentState.smiley
//     AdventureAttributes.ContentState.starEyes
// }
