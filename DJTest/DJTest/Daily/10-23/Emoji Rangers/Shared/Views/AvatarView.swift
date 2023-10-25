//
//  AvatarView.swift
//  DJTest
//
//  Created by lxthyme on 2023/10/24.
//

import SwiftUI

struct Avatar: View {
    var hero: EmojiRanger
    var includeBackground = true

    var body: some View {
        ZStack {
            if includeBackground {
                Circle().fill(Color.gameWidgetBackground)
            }
            Text(hero.avatar)
                .font(.system(size: 500))
                .minimumScaleFactor(0.01)
                .multilineTextAlignment(.center)
        }
        .aspectRatio(1, contentMode: .fit)
        .frame(maxWidth: 50)
    }
}

// MARK: - 🔐
private extension View {
    func invalidatableContentIfPossible() -> some View {
        if #available(iOS 17.0, *) {
            return invalidatableContent()
        } else {
            // Fallback on earlier versions
            return self
        }
    }
}

struct AvatarView: View {
    var hero: EmojiRanger
    @Environment(\.showsWidgetContainerBackground) var showWidgetBackground
    @Environment(\.widgetRenderingMode) var renderingMode
    @AppStorage("supercharged", store: UserDefaults(suiteName: EmojiRanger.appGroup))
    var supercharged = EmojiRanger.herosAreSupercharged()

    init(hero: EmojiRanger) {
        self.hero = hero
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Avatar(hero: hero, includeBackground: renderingMode != .vibrant)
                    HeroNameView(hero, includeDetail: showWidgetBackground)
                }
                if !showWidgetBackground {
                    HStack(spacing: 5) {
                        Text("Level \(hero.level)")
                            .minimumScaleFactor(0.25)
                        Text("•")
                        Text("\(hero.exp) XP")
                            .minimumScaleFactor(0.25)
                    }
                    Spacer()
                }
                VStack(alignment: .leading, spacing: 6) {
                    Text("HP")
                    HealthLevelShape(level: hero.healthLevel)
                        .frame(height: 10)
                    Text("Healing Time")
                    if supercharged {
                        Text("Supercharged")
                            .lineLimit(1)
                            .font(.system(.title, design: .monospaced))
                            .minimumScaleFactor(0.25)
                    } else {
                        Text(hero.fullHealthDate, style: .timer)
                            .font(.system(.title, design: .monospaced))
                            .minimumScaleFactor(0.25)
                    }
                }
                .invalidatableContentIfPossible()
            }
        }
    }
}

#Preview {
    AvatarView(hero: .spouty)
        .previewLayout(.fixed(width: 160, height: 160))
}
