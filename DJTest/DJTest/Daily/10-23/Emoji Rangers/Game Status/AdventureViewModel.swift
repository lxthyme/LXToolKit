//
//  AdventureViewModel.swift
//  DJTest
//
//  Created by lxthyme on 2023/10/25.
//

import SwiftUI
import ActivityKit
// import LXToolKit

// MARK: - 👀
@available(iOS 16.2, *)
extension AdventureViewModel {
    typealias ServerManager = AdventureViewModel

    func startActivity(hero: EmojiRanger) throws {
        let adventure = AdventureAttributes(hero: hero)
        let initialState = AdventureAttributes.ContentState(
            currentHealthLevel: hero.healthLevel,
            eventDescription: "Adventure has begun!"
        )

        let activity = try Activity.request(
            attributes: adventure,
            content: .init(state: initialState, staleDate: nil),
            pushType: .token
        )

        Task {
            for await pushToken in activity.pushTokenUpdates {
                let pushTokenString = pushToken.reduce("") { $0 + String(format: "%02x", $1) }

                print("New push token: \(pushTokenString)")

                try await self.sendPushToken(hero: hero, pushTokenString: pushTokenString)
            }
        }
    }

    func printEncoded() {
        let contentState = AdventureAttributes.ContentState(
            currentHealthLevel: 0.941,
            eventDescription: "Power Panda found a sword!"
        )

        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.keyEncodingStrategy = .convertToSnakeCase

        let json = try! encoder.encode(contentState)
        print("\(String(data: json, encoding: .utf8)!)")
    }

    func showWarningBadge(_ shouldShow: Bool) {
    }

    func observeFrequentUpdate() {
        Task {
            for await isEnabled in ActivityAuthorizationInfo().frequentPushEnablementUpdates {
                self.showWarningBadge(!isEnabled)
            }
        }
    }

    func updateAdventureView(content: ActivityContent<AdventureAttributes.ContentState>) {
    }

    func observeActivityUpdates(_ activity: Activity<AdventureAttributes>) {
        Task {
            for await content in activity.contentUpdates {
                self.updateAdventureView(content: content)
            }
        }
    }
}

@available(iOS 16.2, *)
extension AdventureViewModel {
    struct ActivityViewState: Sendable {
        var activityState: ActivityState
        var contentState: AdventureAttributes.ContentState
        var pushToken: String? = nil

        var shouldShowEndControls: Bool {
            switch activityState {
            case .active, .stale:
                return true
            case .ended, .dismissed:
                return false
            @unknown default:
                return false
            }
        }

        var updateControlDisabled: Bool = false

        var shouldShowUpdateControls: Bool {
            switch activityState {
            case .active, .stale:
                return true
            case .ended, .dismissed:
                return false
            @unknown default:
                return false
            }
        }

        var isStale: Bool {
            return activityState == .stale
        }
    }
}

@available(iOS 16.2, *)
final class AdventureViewModel: ObservableObject {
    @Published var activityViewState: ActivityViewState? = nil
    @Published var errorMessage: String? = nil

    private var currentActivity: Activity<AdventureAttributes>? = nil

    func loadAdventrue(hero: EmojiRanger) {
        let activitiesForHero = Activity<AdventureAttributes>.activities.filter { $0.attributes.hero == hero
        }

        guard let activity = activitiesForHero.first else {
            return
        }

        self.setup(withActivity: activity)
    }

    func startAdventureButtonTapped(hero: EmojiRanger) {
        do {
            let adventure = AdventureAttributes(hero: hero)
            let initialState = AdventureAttributes.ContentState(
                currentHealthLevel: hero.healthLevel,
                eventDescription: "Adventure has begun!"
            )

            let activity = try Activity.request(
                attributes: adventure,
                content: .init(state: initialState, staleDate: nil),
                pushType: .token
            )

            self.setup(withActivity: activity)
        } catch {
            errorMessage = """
            Couldn't start activity
            ------------------------
            \(String(describing: error))
            """

            self.errorMessage = errorMessage
        }
    }

    func updateAdventureButtonTapped(shouldAlert: Bool) {
        Task {
            defer {
                self.activityViewState?.updateControlDisabled = false
            }

            self.activityViewState?.updateControlDisabled = true
            try await self.updateAdventure(alert: shouldAlert)
        }
    }

    func endAdventureButtonTapped(dismissTimeInterval: Double?) {
        Task {
            await self.endActivity(dismissTimeInterval: dismissTimeInterval)
        }
    }
}

// MARK: - 🔐
@available(iOS 16.2, *)
private extension AdventureViewModel {
    func endActivity(dismissTimeInterval: Double?) async {
        guard let activity = currentActivity else {
            return
        }

        let hero = activity.attributes.hero

        let finalContent = AdventureAttributes.ContentState(
            currentHealthLevel: 1.0,
            eventDescription: "Adventure over! \(hero.name) is taking a nap."
        )

        let dismissPolicy: ActivityUIDismissalPolicy
        if let dismissTimeInterval {
            if dismissTimeInterval <= 0 {
                dismissPolicy = .immediate
            } else {
                dismissPolicy = .after(.now + dismissTimeInterval)
            }
        } else {
            dismissPolicy = .default
        }
        await activity.end(ActivityContent(state: finalContent, staleDate: nil), dismissalPolicy: dismissPolicy)
    }

    func setup(withActivity activity: Activity<AdventureAttributes>) {
        self.currentActivity = activity

        self.activityViewState = .init(
            activityState: activity.activityState,
            contentState: activity.content.state,
            pushToken: activity.pushToken?.hexadecimalString)

        observeActivity(activity: activity)
    }

    func observeActivity(activity: Activity<AdventureAttributes>) {
        Task {
            await withTaskGroup(of: Void.self) { group in
                group.addTask {@MainActor in
                    for await activityState in activity.activityStateUpdates {
                        if activityState == .dismissed {
                            self.cleanUpDismissedActivity()
                        } else {
                            self.activityViewState?.activityState = activityState
                        }
                    }
                }

                group.addTask { @MainActor in
                    for await contentState in activity.contentUpdates {
                        self.activityViewState?.contentState = contentState.state
                    }
                }

                group.addTask { @MainActor in
                    for await pushToken in activity.pushTokenUpdates {
                        let pushTokenString = pushToken.hexadecimalString

                        print("New push token: \(pushTokenString)")

                        do {
                            let frequentUpdateEnabled = ActivityAuthorizationInfo().frequentPushesEnabled

                            try await self.sendPushToken(
                                hero: activity.attributes.hero,
                                pushTokenString: pushTokenString,
                                frequentUpdateEnabled: frequentUpdateEnabled
                            )
                        } catch {
                            self.errorMessage = """
                            Failed to send push token to server
                            ------------------------
                            \(String(describing: error))
                            """
                        }
                    }
                }
            }
        }
    }

    func updateAdventure(alert: Bool) async throws {
        try await Task.sleep(for: .seconds(2))

        guard let activity = currentActivity else {
            return
        }

        var alertConfig: AlertConfiguration? = nil
        let contentState: AdventureAttributes.ContentState
        if alert {
            let heroName = activity.attributes.hero.name

            alertConfig = AlertConfiguration(
                title: "\(heroName) has been knocked down!",
                body: "Open the app and use a potion to heal \(heroName).",
                sound: .default
            )

            contentState = AdventureAttributes.ContentState(
                currentHealthLevel: 0,
                eventDescription: "\(heroName) has been knocked down!"
            )
        } else {
            contentState = AdventureAttributes.ContentState(
                currentHealthLevel: Double.random(in: 0...1),
                eventDescription: self.getEventDescription(hero: activity.attributes.hero)
            )
        }

        await activity.update(
            ActivityContent<AdventureAttributes.ContentState>(
                state: contentState,
                staleDate: .now + 15,
                relevanceScore: alert ? 100 : 50
            ),
            alertConfiguration: alertConfig
        )
    }

    func cleanUpDismissedActivity() {
        self.currentActivity = nil
        self.activityViewState = nil
    }
}

// MARK: - 🔐
@available(iOS 16.2, *)
extension AdventureViewModel {
    func sendPushToken(hero: EmojiRanger, pushTokenString: String, frequentUpdateEnabled: Bool = false) async throws {

    }

    func getEventDescription(hero: EmojiRanger) -> String {
        let heroName = hero.name
        let randomNumber = Int.random(in: 0...3)

        switch randomNumber {
        case 0:
            return "\(heroName) found 3 arrows."
        case 1:
            return "\(heroName) defeated 2 horses."
        case 2:
            return "A villager offered \(heroName) a gift!"
        case 3:
            return "Companion healed \(heroName). 20 points."
        default:
            return "\(heroName) rested for a few minutes."
        }
    }
}

// MARK: - 🔐
private extension Data {
    var hexadecimalString: String {
        self.reduce("") { $0 + String(format: "%02x", $1) }
    }
}
