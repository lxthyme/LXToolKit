//
//  HeroNameView.swift
//  LXTest
//
//  Created by lxthyme on 2023/10/24.
//

import SwiftUI

@available(iOS 16.2, *)
struct HeroNameView: View {
    private let hero: EmojiRanger
    let includeDetail: Bool

    init(_ hero: EmojiRanger?, includeDetail: Bool = true) {
        self.hero = hero ?? EmojiRanger.spouty
        self.includeDetail = includeDetail
    }
    var body: some View {
        VStack(alignment: .leading, content: {
            Text(hero.name)
                .font(.title)
                .fontWeight(.bold)
                .lineLimit(1)
                .minimumScaleFactor(0.2)
            if includeDetail {
                Text("Level \(hero.level)")
                    .minimumScaleFactor(0.2)
                Text("\(hero.exp) XP")
                    .minimumScaleFactor(0.2)
            }
        })
    }
}

@available(iOS 16.2, *)
#Preview {
    HeroNameView(nil)
}
