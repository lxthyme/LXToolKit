//
//  LXActivityAvatarView.swift
//  LXTest
//
//  Created by lxthyme on 2024/3/15.
//

import SwiftUI

@available(iOS 16.2, *)
struct LXEmojiLiveActivityContentView: View {
    let hero: EmojiRanger
    let isStale: Bool
    let contentState: DynamicLandExtensionAttributes.ContentState

    var body: some View {
        VStack(alignment: .center) {
            HStack {
                LXActivityAvatarView(hero: hero)
                Spacer()
                LXActivityStatsView(hero: hero, isStale: isStale)
            }
            LXActivityHealthBar(currentHealthLevel: contentState.currentHealthLevel)
            LXActivityEventDescriptionView(hero: hero, contentState: contentState)
        }
        .foregroundStyle(Color.textColor)
    }
}

@available(iOS 16.2, *)
struct LXEmojiLiveActivityView: View {
    let hero: EmojiRanger
    let isStale: Bool
    let contentState: DynamicLandExtensionAttributes.ContentState

    var body: some View {
        LXEmojiLiveActivityContentView(hero: hero, isStale: isStale, contentState: contentState)
            .padding()
            .background(ContainerRelativeShape().fill(Color.liveActivityBackground))
    }
}

@available(iOS 16.2, *)
struct LXActivityAvatarView: View {
    let hero: EmojiRanger
    // @Environment(\.show)
    init(hero: EmojiRanger) {
        self.hero = hero
    }
    var body: some View {
        Link(destination: hero.url) {
            HStack {
                LXAvatarView(hero: hero, includeBackground: true)
                    .frame(minWidth: 25, minHeight: 25)
                    .aspectRatio(1, contentMode: .fit)

                Text(hero.name)
                    .layoutPriority(100)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
        }
        .frame(height: 30)
    }
}

@available(iOS 16.2, *)
struct LXActivityHealthBar: View {
    let currentHealthLevel: Double

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "heart.circle.fill")
                .symbolRenderingMode(.palette)
                .foregroundStyle(Color.red, Color.white)
                .minimumScaleFactor(0.5)

            HealthLevelShape(level: currentHealthLevel)
                .frame(height: 10)

            Text("\(Int(currentHealthLevel * 100))")
                .minimumScaleFactor(0.5)
        }
        .frame(height: 16)
    }
}

@available(iOS 16.2, *)
struct LXActivityEventDescriptionView: View {
    let hero: EmojiRanger
    let contentState: DynamicLandExtensionAttributes.ContentState

    var body: some View {
        Text(contentState.eventDescription)
            .lineLimit(1)
            .minimumScaleFactor(0.7)
            .font(.headline)
    }
}

@available(iOS 16.2, *)
struct LXActivityStatsView: View {
    let hero: EmojiRanger
    let isStale: Bool

    var body: some View {
        Group {
            if isStale {
                Text("Outdated \(Image(systemName: "clock.badge.exclamationmark.fill")) ")
                    .padding(4)
                    .background(ContainerRelativeShape().fill(Color.red))
            } else {
                Text("Level: \(hero.level)    XP: \(hero.exp)")
            }
        }
        .font(.caption)
        .multilineTextAlignment(.center)
        .frame(height: 30)
    }
}

@available(iOS 16.2, *)
#Preview {
    LXActivityAvatarView(hero: EmojiRanger.spouty)
}
