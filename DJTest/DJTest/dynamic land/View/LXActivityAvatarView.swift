//
//  LXActivityAvatarView.swift
//  DJTest
//
//  Created by lxthyme on 2024/3/15.
//

import SwiftUI

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
#Preview {
    LXActivityAvatarView(hero: EmojiRanger.spouty)
}
