//
//  AdventureLiveActivityContent.swift
//  LXTest
//
//  Created by lxthyme on 2023/10/24.
//

import SwiftUI
import WidgetKit

#if canImport(ActivityKit)
@available(iOS 16.2, *)
struct AdventureLiveActivityContent: View {
    let hero: EmojiRanger
    let isStale: Bool
    let contentState: AdventureAttributes.ContentState

    var body: some View {
        VStack(alignment: .center) {
            HStack(content: {
                LiveActivityAvatarView(hero: hero)

                Spacer()

                StatsView(hero: hero, isStale: isStale)
            })

            HealthBar(currentHealthLevel: contentState.currentHealthLevel)

            EventDescriptionView(hero: hero, contentState: contentState)
        }
        .foregroundStyle(Color.textColor)
    }
}

@available(iOS 16.2, *)
struct AdventureLiveActivityView: View {
    let hero: EmojiRanger
    let isStale: Bool
    let contentState: AdventureAttributes.ContentState

    var body: some View {
        AdventureLiveActivityContent(
            hero: hero,
            isStale: isStale,
            contentState: contentState
        )
        .padding()
        .background(
            ContainerRelativeShape()
                .fill(Color.liveActivityBackground)
        )
    }
}

@available(iOS 16.2, *)
struct LiveActivityAvatarView: View {
    let hero: EmojiRanger

    var body: some View {
        Link(destination: hero.url) {
            HStack(content: {
                Avatar(hero: hero, includeBackground: true)
                    .frame(minWidth: 25, minHeight: 25)
                    .aspectRatio(1, contentMode: .fit)

                Text(hero.name)
                    .layoutPriority(100)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            })
        }
        .frame(height: 30)
    }
}

@available(iOS 16.2, *)
struct HealthBar: View {
    let currentHealthLevel: Double

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "heart.circle.fill")
                .symbolRenderingMode(.palette)
                .foregroundStyle(.red, .white)
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
struct EventDescriptionView: View {
    let hero: EmojiRanger
    let contentState: AdventureAttributes.ContentState

    var body: some View {
        Text(contentState.eventDescription)
            .lineLimit(1)
            .minimumScaleFactor(0.7)
            .font(.headline)
    }
}

@available(iOS 16.2, *)
struct StatsView: View {
    let hero: EmojiRanger
    let isStale: Bool

    var body: some View {
        Group {
            if isStale {
                Text("Outdated \(Image(systemName: "clock.badge.exclamationmark.fill")) ")
                    .padding(4)
                    .background(
                        ContainerRelativeShape()
                            .fill(Color.red)
                    )
            } else {
                Text("Level: \(hero.level)  XP: \(hero.exp)")
            }
        }
        .font(.caption)
        .multilineTextAlignment(.center)
        .frame(height: 30)
    }
}

@available(iOS 16.2, *)
#Preview {
        // AdventureLiveActivityView(hero: .spouty, isStale: true, contentState: <#T##AdventureAttributes.ContentState#>)
        LiveActivityAvatarView(hero: .spouty)
            .previewDisplayName("LiveActivityAvatarView")
        // HealthBar(currentHealthLevel: 0.8)
        //     .previewDisplayName("HealthBar")
        // EventDescriptionView(hero: <#T##EmojiRanger#>, contentState: <#T##AdventureAttributes.ContentState#>)
        // StatsView(hero: .spouty, isStale: true)
        //     .previewDisplayName("StatsView")
}
@available(iOS 16.2, *)
#Preview {
        HealthBar(currentHealthLevel: 0.8)
            .previewDisplayName("HealthBar")
}
@available(iOS 16.2, *)
#Preview {
        StatsView(hero: .spouty, isStale: true)
            .previewDisplayName("StatsView")
}

#endif
