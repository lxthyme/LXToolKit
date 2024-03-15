//
//  ActivityVM.swift
//  DJTest
//
//  Created by lxthyme on 2024/3/15.
//
import Foundation

#if canImport(ActivityKit)

import ActivityKit

class ActivityVM {
    private var currentActivity: Activity<DynamicLandExtensionAttributes>? = nil
    private init() {}
}

// MARK: - 👀
extension ActivityVM {
    func startActivity() throws {
        let attributes = DynamicLandExtensionAttributes(name: "emoj 233")
        let initialState = DynamicLandExtensionAttributes.ContentState(emoji: "emoj 234")
        let activity = try Activity.request(attributes: attributes,
                                            content: .init(state: initialState, staleDate: nil),
                                            pushType: .token)
        self.currentActivity = activity
    }
}

#endif
