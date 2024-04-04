//
//  DynamicLandExtensionLiveActivity.swift
//  DynamicLandExtension
//
//  Created by lxthyme on 2024/3/15.
//

import ActivityKit
import WidgetKit
import SwiftUI

@available(iOS 16.2, *)
struct DynamicLandExtensionAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        let currentHealthLevel: Double
        let eventDescription: String
    }

    // Fixed non-changing properties about your activity go here!
    var hero: EmojiRanger
}
@available(iOS 16.2, *)
struct DynamicLandExtensionLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DynamicLandExtensionAttributes.self) { (context: ActivityViewContext<DynamicLandExtensionAttributes>) in
            // Lock screen/banner UI goes here
            // VStack {
            //     Text("Hello \(context.attributes.hero.name)")
            // }
            LXEmojiLiveActivityView(hero: context.attributes.hero, isStale: context.isStale, contentState: context.state)
                .activityBackgroundTint(Color.liveActivityBackground.opacity(0.25))
            // .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    // Text("Leading")
                    LXActivityAvatarView(hero: context.attributes.hero)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    // Text("Trailing")
                    LXActivityStatsView(hero: context.attributes.hero, isStale: context.isStale)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    // Text("Bottom \(context.state.eventDescription)")
                    LXActivityHealthBar(currentHealthLevel: context.state.currentHealthLevel)

                    LXActivityEventDescriptionView(hero: context.attributes.hero, contentState: context.state)
                }
            } compactLeading: {
                // Text("L")
                LXAvatarView(hero: context.attributes.hero, includeBackground: true)
            } compactTrailing: {
                // Text("T \(context.state.currentHealthLevel)")
                ProgressView(value: context.state.currentHealthLevel, total: 1) {
                    Text("\(Int(context.state.currentHealthLevel * 100))")
                }
                .progressViewStyle(.circular)
                .tint(context.state.currentHealthLevel <= 0.2 ? .red : .green)
            } minimal: {
                // Text("M \(context.state.currentHealthLevel)")
                ProgressView(value: context.state.currentHealthLevel, total: 1) {
                    LXAvatarView(hero: context.attributes.hero, includeBackground: false)
                }
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

@available(iOS 16.2, *)
extension DynamicLandExtensionAttributes {
    fileprivate static var preview: DynamicLandExtensionAttributes {
        DynamicLandExtensionAttributes(hero: .spouty)
    }
}

@available(iOS 16.2, *)
extension DynamicLandExtensionAttributes.ContentState {
    fileprivate static var smiley: DynamicLandExtensionAttributes.ContentState {
        DynamicLandExtensionAttributes.ContentState(currentHealthLevel: 0.2, eventDescription: "smiley description")
     }
     
     fileprivate static var starEyes: DynamicLandExtensionAttributes.ContentState {
         DynamicLandExtensionAttributes.ContentState(currentHealthLevel: 0.4, eventDescription: "star eyes description")
     }
}

@available(iOS 17.0, *)
#Preview("Notification", as: .content, using: DynamicLandExtensionAttributes.preview) {
   DynamicLandExtensionLiveActivity()
} contentStates: {
    DynamicLandExtensionAttributes.ContentState.smiley
    DynamicLandExtensionAttributes.ContentState.starEyes
}
