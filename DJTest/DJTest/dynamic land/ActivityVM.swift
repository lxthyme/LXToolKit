//
//  ActivityVM.swift
//  DJTest
//
//  Created by lxthyme on 2024/3/15.
//
import Foundation
import LXToolKit

#if canImport(ActivityKit)

import ActivityKit

// MARK: - 👀
@available(iOS 16.2, *)
extension ActivityVM {
    struct ActivityViewState {
        var activityState: ActivityState
        var contentState: DynamicLandExtensionAttributes.ContentState
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
@MainActor
class ActivityVM {
    static let shareInstance = ActivityVM()
    private var currentActivity: Activity<DynamicLandExtensionAttributes>? = nil
    @Published var activityViewState: ActivityViewState? = nil
    @Published var errorMessage: String? = nil;
    private init() {}
}

// MARK: - 👀
@available(iOS 16.2, *)
extension ActivityVM {
    func loadActivity(hero: EmojiRanger) {
        let activitiesForHero = Activity<DynamicLandExtensionAttributes>.activities.filter { $0.attributes.hero == hero }
        guard let activity = activitiesForHero.first else { return }

        setup(with: activity)
    }
    func startActivity() {
        if(self.currentActivity != nil) {
            let healthLevel = self.currentActivity?.content.state.currentHealthLevel ?? 0
            Task {
                await self.currentActivity?.update(using: .init(currentHealthLevel: healthLevel + 0.2, eventDescription: "\(self.currentActivity?.attributes.hero.name ?? "--") updated."),
                                                   alertConfiguration: .init(title: "title", body: "body", sound: .default))
            }
            return
        }
        if(self.currentActivity == nil) {
            let activities = Activity<DynamicLandExtensionAttributes>.activities
            dlog("-->activities: \(activities)")
        }
        let attributes = DynamicLandExtensionAttributes(hero: EmojiRanger.spouty)
        let initialState = DynamicLandExtensionAttributes.ContentState(currentHealthLevel: 0.8, eventDescription: "event description")
        do {
            let activity = try Activity.request(attributes: attributes,
                                                content: .init(state: initialState, staleDate: nil),
                                                pushType: .token)
            setup(with: activity)
        } catch {
            self.errorMessage = """
            Couldn't start activity
            ------------------------
            \(String(describing: error))
            """
            dlog("\(self.errorMessage ?? "--Error--")")
        }
    }
    func updateActivityAction(showAlert: Bool) {
        Task {
            defer {
                self.activityViewState?.updateControlDisabled = false
            }
            self.activityViewState?.updateControlDisabled = true
            try await self.updateActivity(alert: showAlert)
        }
    }
    func endActivityAction(dismissTimeInterval: Double?) {
        Task {
            await self.endActivity(dismissTimeInterval: dismissTimeInterval)
        }
    }
}
// MARK: - 👀
@available(iOS 16.2, *)
private extension ActivityVM {
    func setup(with activity: Activity<DynamicLandExtensionAttributes>) {
        self.currentActivity = activity

        self.activityViewState = .init(activityState: activity.activityState,
                                       contentState: activity.content.state,
                                       pushToken: activity.pushToken?.hexString)

        observeActivity(activity: activity)
    }
    func observeActivity(activity: Activity<DynamicLandExtensionAttributes>) {
        Task {
            await withTaskGroup(of: Void.self) { group in
                group.addTask { @MainActor in
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
                        let pushTokenString = pushToken.hexString
                        dlog("-->New push token: \(pushTokenString)")

                        do {
                            let frequentUpdateEnabled = ActivityAuthorizationInfo().frequentPushesEnabled
                            try await self.sendPushToken(hero: activity.attributes.hero,
                                                         pushTokenString: pushTokenString,
                                                         frequentUpdateEnabled: frequentUpdateEnabled)
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
    func updateActivity(alert: Bool) async throws {
        try await Task.sleep(for: .seconds(2))

        guard let activity = currentActivity else { return }
        var alertConfig: AlertConfiguration? = nil
        let contentState: DynamicLandExtensionAttributes.ContentState
        if alert {
            let heroName = activity.attributes.hero.name

            alertConfig = .init(title: "\(heroName) has been knocked down!",
                                body: "Open the app and use a potion to heal \(heroName).",
                                sound: .default)
            contentState = .init(currentHealthLevel: 0,
                                 eventDescription: "\(heroName) has been knocked down!")
        } else {
            contentState = .init(currentHealthLevel: Double.random(in: 0...1),
                                 eventDescription: self.getEventDescription(hero: activity.attributes.hero))
        }

        await activity.update(ActivityContent<DynamicLandExtensionAttributes.ContentState>(state: contentState,
                                                                                           staleDate: Date.now + 15,
                                                                                           relevanceScore: alert ? 100 : 50),
                              alertConfiguration: alertConfig)
    }
    func endActivity(dismissTimeInterval: Double?) async {
        guard let activity = currentActivity else { return }
        let hero = activity.attributes.hero
        let finalContent = DynamicLandExtensionAttributes.ContentState(currentHealthLevel: 1.0, eventDescription: "Adventure over! \(hero.name) is taking a nap.")

        let dismissalPolicy: ActivityUIDismissalPolicy
        if let dismissTimeInterval {
            if dismissTimeInterval <= 0 {
                dismissalPolicy = .immediate
            } else {
                dismissalPolicy = .after(.now + dismissTimeInterval)
            }
        } else {
            dismissalPolicy = .default
        }

        await activity.end(ActivityContent(state: finalContent, staleDate: nil),
                           dismissalPolicy: dismissalPolicy)
    }
    func cleanUpDismissedActivity() {
        self.currentActivity = nil
        self.activityViewState = nil
    }
}

// MARK: - 🔐
@available(iOS 16.2, *)
private extension ActivityVM {
    func sendPushToken(hero: EmojiRanger, pushTokenString: String, frequentUpdateEnabled: Bool = false) async throws {}
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

#endif
