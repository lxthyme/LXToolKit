//
//  AllCharactersView.swift
//  DJTest
//
//  Created by lxthyme on 2023/10/24.
//

import SwiftUI

struct AllCharactersView: View {
    let heros: [EmojiRanger]

    init(heros: [EmojiRanger]? = EmojiRanger.availableHeros) {
        self.heros = heros ?? EmojiRanger.availableHeros
    }
    var body: some View {
        VStack(spacing: 48) {
            ForEach(heros.sorted { $0.healthLevel > $1.healthLevel }, id: \.self) { hero in
                Link(destination: hero.url) {
                    HStack(content: {
                        Avatar(hero: hero)
                        VStack(alignment: .leading, content: {
                            Text(hero.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                            Text("Level \(hero.level)")
                                .foregroundStyle(.white)
                            HealthLevelShape(level: hero.healthLevel)
                                .frame(height: 10)
                        })
                    })
                }
            }
        }
    }
}

#Preview {
    AllCharactersView()
}