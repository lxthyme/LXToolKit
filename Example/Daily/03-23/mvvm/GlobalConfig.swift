//
//  GlobalConfig.swift
//  LXToolKit2
//
//  Created by LXThyme Jason on 2021/3/11.
//

import Foundation
import RxSwift
import RxCocoa
import YYCache

struct XLMacro {
    static let ScreenBounds: CGRect = UIScreen.main.bounds
    static let ScreenWidth: CGFloat = ScreenBounds.width
    static let ScreenHeight: CGFloat = ScreenBounds.height
}
struct GlobalConfig {
    static var yyCache: YYCache? = {
        let cache = YYCache(name: GlobalConfig.App.bundleIdentifier)
        return cache
    }()
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
    struct App {
        static let statusBarStyle = BehaviorRelay<UIStatusBarStyle>(value: .default)
        static let bundleIdentifier = Bundle.main.bundleIdentifier ?? "com.lx.hs"
        static let githubUrl = "https://github.com/khoren93/SwiftHub"
    }
    struct Api {
        static let baseURL = ""
    }
    struct Network {
        /// set true for tests and generating screenshots with fastlane
        static let useStaging = false
        static let loggingEnabled = false
        static let githubBaseUrl = "https://api.github.com"
        static let trendingGithubBaseUrl = "https://gtrend.yapie.me"
        static let codetabsBaseUrl = "https://api.codetabs.com/v1"
        static let githistoryBaseUrl = "https://github.githistory.xyz"
        static let starHistoryBaseUrl = "https://star-history.t9t.io"
        static let profileSummaryBaseUrl = "https://profile-summary-for-github.com"
    }
    struct BaseDimensions {
        static let cornerRadius: CGFloat = 6
        static let borderWidth: CGFloat = 1
        static let inset: CGFloat = 8
        static let tabBarHeight: CGFloat = 58
        static let toolBarHeight: CGFloat = 66
        static let navBarWithStatusBarHeight: CGFloat = 64
        static let buttonHeight: CGFloat = 40
        static let textFieldHeight: CGFloat = 40
        static let tableRowHeight: CGFloat = 36
        static let segmentedControlHeight: CGFloat = 40
    }
    struct Path {
        static let Documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        static let Tmp = NSTemporaryDirectory()
    }
    struct UserDefaultsKeys {
        static let bannersEnabled = "BannersEnabled"
    }
}
