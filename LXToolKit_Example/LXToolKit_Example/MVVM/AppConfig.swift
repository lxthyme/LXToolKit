//
//  AppConfig.swift
//  test
//
//  Created by lxthyme on 2023/3/23.
//

import Foundation

enum Keys {
    case github, mixpanel, adMob

    var apiKey: String {
        switch self {
        case .github: return "5a39979251c0452a9476bd45c82a14d8e98c3fb3"
        case .mixpanel: return "7e428bc407e3612f6d3a4c8f50fd4643"
        case .adMob: return "ca-app-pub-3940256099942544/2934735716"
        }
    }

    var appId: String {
        switch self {
        case .github: return "00cbdbffb01ec72e280a"
        case .mixpanel: return ""
        case .adMob: return ""  // See GADApplicationIdentifier in Info.plist
        }
    }
}

public enum AppConfig {
    enum App {
        static let githubUrl = "https://github.com/khoren93/SwiftHub"
        static let githubScope = "user+repo+notifications+read:org"
        static let bundleIdentifier = "com.public.SwiftHub"
    }

    enum Network {
        static let useStaging = false  // set true for tests and generating screenshots with fastlane
        static let loggingEnabled = true
        static let localHost = "http://10.199.5.27:3003"
        // static let localHost = "http://10.199.5.49:3003"
        static let githubBaseUrl = "https://api.github.com"
        static let trendingGithubBaseUrl = "https://gtrend.yapie.me"
        static let codetabsBaseUrl = "https://api.codetabs.com/v1"
        static let githistoryBaseUrl = "https://github.githistory.xyz"
        static let starHistoryBaseUrl = "https://star-history.t9t.io"
        static let profileSummaryBaseUrl = "https://profile-summary-for-github.com"
        static let githubSkylineBaseUrl = "https://skyline.github.com"
    }

    enum BaseDimensions {
        static let inset: CGFloat = 8
        static let tabBarHeight: CGFloat = 58
        static let toolBarHeight: CGFloat = 66
        static let navBarWithStatusBarHeight: CGFloat = 64
        static let cornerRadius: CGFloat = 5
        static let borderWidth: CGFloat = 1
        static let buttonHeight: CGFloat = 40
        static let textFieldHeight: CGFloat = 40
        static let tableRowHeight: CGFloat = 36
        static let segmentedControlHeight: CGFloat = 40
    }
    public enum TingYun {
        public static let AppKey = "d3dce7e7bc664cea81e4b7fd7c12fad1"
    }

    enum UserDefaultsKeys {
        static let bannersEnabled = "BannersEnabled"
    }
}
