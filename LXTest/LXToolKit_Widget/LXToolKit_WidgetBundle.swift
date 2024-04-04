//
//  LXToolKit_WidgetBundle.swift
//  LXToolKit_Widget
//
//  Created by lxthyme on 2023/10/12.
//

import WidgetKit
import SwiftUI

@main
struct LXToolKit_WidgetBundle: WidgetBundle {
    var body: some Widget {
        // LXToolKit_Widget()
        // LXToolKit_WidgetLiveActivity()
        EmojiRangerWidget()
        LeaderboardWidget()
        #if canImport(ActivityKit)
        AdventureActivityConfiguration()
        #endif
    }
}
