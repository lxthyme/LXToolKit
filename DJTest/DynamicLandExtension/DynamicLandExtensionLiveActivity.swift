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
            VStack {
                Text("Hello \(context.attributes.hero.name)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.eventDescription)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.currentHealthLevel)")
            } minimal: {
                Text("M \(context.state.currentHealthLevel)")
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
