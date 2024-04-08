//
//  DynamicLandExtensionBundle.swift
//  DynamicLandExtension
//
//  Created by lxthyme on 2024/3/15.
//

import WidgetKit
import SwiftUI

@main
@available(iOS 17.0, *)
struct DynamicLandExtensionBundle: WidgetBundle {
    var body: some Widget {
        DynamicLandExtension()
        LXLeaderboardWidget()
        DynamicLandExtensionLiveActivity()
    }
}
