//
//  AllCharactersView.swift
//  DJTest
//
//  Created by lxthyme on 2024/3/18.
//

import SwiftUI
import WidgetKit

@available(iOS 16.2, *)
struct LXAllCharactersView: View {
    let heros: [EmojiRanger]
    init(heros: [EmojiRanger]? = EmojiRanger.availableHeros) {
        self.heros = heros ?? EmojiRanger.availableHeros
    }
    var body: some View {
        VStack(spacing: 48, content: {
            ForEach(heros.sorted(by: { $0.healthLevel > $1.healthLevel }), id: \.self) { hero in
                Link(destination: hero.url, label: {
                    HStack(content: {
                        LXAvatarView(hero: hero)
                        VStack(alignment: .leading, content: {
                            Text(hero.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                            Text("Level \(hero.level)")
                                .foregroundStyle(.white)
                            LXHealthLevelShape(level: hero.healthLevel)
                                .frame(height: 10)
                        })
                    })
                })
            }
        })
    }
}

@available(iOS 17.0, *)
// #Preview("Hero List", body: {
struct LXAllCharactersView_Previews: PreviewProvider {
    static var previews: some View {
        LXAllCharactersView()
            .widgetBackground()
            .previewContext(WidgetPreviewContext(family: .systemExtraLarge))
    }
}
