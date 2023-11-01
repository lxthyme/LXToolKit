//
//  AdventureView.swift
//  DJTest
//
//  Created by lxthyme on 2023/10/25.
//

import SwiftUI

@available(iOS 16.2, *)
struct AdventureView: View {
    let hero: EmojiRanger
    @StateObject private var viewModel = AdventureViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            Text("Adventure Live Activity")
                .font(.title)

            if let activityViewState = viewModel.activityViewState {
                AdventureLiveActivityView(
                    hero: hero,
                    isStale: activityViewState.isStale,
                    contentState: activityViewState.contentState
                )
                .containerShape(RoundedRectangle(cornerRadius: 20, style: .continuous))

                if activityViewState.shouldShowUpdateControls {
                    VStack(alignment: .leading) {
                        Text("Update adventure")
                            .font(.title2)
                        Text("Choose the type of event")

                        HStack {
                            Button("Normal") {
                                viewModel.updateAdventureButtonTapped(shouldAlert: false)
                            }

                            Button("Alert critical") {
                                viewModel.updateAdventureButtonTapped(shouldAlert: true)
                            }
                        }
                    }
                    .foregroundStyle(Color.textColor)
                    .padding()
                    .buttonStyle(.borderedProminent)
                    .background(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(Color.liveActivityBackground)
                    )
                    .disabled(activityViewState.updateControlDisabled)
                }

                if activityViewState.shouldShowEndControls {
                    VStack(alignment: .leading) {
                        Text("End adventure")
                            .font(.title2)
                        Text("Choose when to dismiss")

                        HStack {
                            Button("Now") {
                                viewModel.endAdventureButtonTapped(dismissTimeInterval: 0)
                            }
                            Button("In 10 sec") {
                                viewModel.endAdventureButtonTapped(dismissTimeInterval: 10)
                            }
                            Button("By system") {
                                viewModel.endAdventureButtonTapped(dismissTimeInterval: nil)
                            }
                        }
                    }
                    .foregroundStyle(Color.textColor)
                    .padding()
                    .buttonStyle(.borderedProminent)
                    .background(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(Color.liveActivityBackground)
                    )
                }
            } else {
                Button("Go on adventure!") {
                    viewModel.startAdventureButtonTapped(hero: hero)
                }
                .buttonStyle(.borderedProminent)
                .onAppear {
                    viewModel.loadAdventrue(hero: hero)
                }
            }

            if let errorMessage = viewModel.errorMessage {
                Section {
                    Text(errorMessage)
                        .foregroundStyle(Color.red)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.appBackground)
        .onAppear {
            viewModel.printEncoded()
        }
    }
}

@available(iOS 16.2, *)
#Preview {
    AdventureView(hero: .spouty)
}
