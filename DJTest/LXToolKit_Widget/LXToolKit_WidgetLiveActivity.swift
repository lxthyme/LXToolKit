//
//  LXToolKit_WidgetLiveActivity.swift
//  LXToolKit_Widget
//
//  Created by lxthyme on 2023/10/12.
//

import ActivityKit
import WidgetKit
import SwiftUI

public struct LXToolKit_WidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
        public init(emoji: String) {
            self.emoji = emoji
        }
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct LXToolKit_WidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LXToolKit_WidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
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
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension LXToolKit_WidgetAttributes {
    fileprivate static var preview: LXToolKit_WidgetAttributes {
        LXToolKit_WidgetAttributes(name: "World")
    }
}

extension LXToolKit_WidgetAttributes.ContentState {
    fileprivate static var smiley: LXToolKit_WidgetAttributes.ContentState {
        LXToolKit_WidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: LXToolKit_WidgetAttributes.ContentState {
         LXToolKit_WidgetAttributes.ContentState(emoji: "🤩")
     }
}

@available(iOS 17.0, *)
#Preview("Notification", as: .content, using: LXToolKit_WidgetAttributes.preview) {
   LXToolKit_WidgetLiveActivity()
} contentStates: {
    LXToolKit_WidgetAttributes.ContentState.smiley
    LXToolKit_WidgetAttributes.ContentState.starEyes
}
