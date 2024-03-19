//
//  LXAvatarView.swift
//  DJTest
//
//  Created by lxthyme on 2024/3/15.
//

import SwiftUI

@available(iOS 16.2, *)
struct LXAvatarView: View {
    var hero: EmojiRanger
    var includeBackground: Bool = true

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

@available(iOS 16.2, *)
#Preview {
    LXAvatarView(hero: EmojiRanger.spouty)
}
