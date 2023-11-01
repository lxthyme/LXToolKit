/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The adventure attributes.
*/

#if canImport(ActivityKit)

import ActivityKit

@available(iOS 16.2, *)
struct AdventureAttributes: ActivityAttributes {
    struct ContentState: Codable & Hashable {
        let currentHealthLevel: Double
        let eventDescription: String
    }
    
    let hero: EmojiRanger
}

#endif
