//
//  EmojiRangersApp.swift
//  DJTest
//
//  Created by lxthyme on 2023/10/25.
//

import SwiftUI
import SpriteKit

// @main
struct EmojiRangersApp: App {
    // @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            EmojiRangersView()
                .onOpenURL { url in
                    print("-->url: \(url)")
                }
        }
    }
}

struct EmojiRangersView: View {
    @State private var selection: EmojiRanger?
    @State private var navigationPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $navigationPath) {
            List(EmojiRanger.availableHeros, id: \.self) { hero in
                NavigationLink(value: hero) {
                    TableRow(hero: hero)
                }
            }
            .onAppear(perform: {
                if let hero = EmojiRanger.getLastSelectedHero() {
                    print("Last character selection: \(hero)")
                }
            })
            .navigationTitle("Your Characters")
            .onOpenURL(perform: { url in
                if let match = EmojiRanger.allHeros
                    .compactMap({ hero in
                        url == hero.url ? hero : nil
                    })
                        .first {
                    navigationPath = NavigationPath([match])
                }
            })
            .navigationDestination(for: EmojiRanger.self) { hero in
                DetailView(hero: hero)
            }
        }
    }
}

private struct TableRow: View {
    let hero: EmojiRanger

    var body: some View {
        HStack {
            Avatar(hero: hero)
            HeroNameView(hero)
                .padding()
        }
    }
}

#Preview {
    EmojiRangersView()
}
