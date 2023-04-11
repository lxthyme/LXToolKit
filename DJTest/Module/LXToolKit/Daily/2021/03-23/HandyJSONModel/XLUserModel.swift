//
//  XLUserModel.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//
import Foundation
import HandyJSON
import KeychainAccess
import MessageKit

private let userKey = "CurrentUserKey"
private let keychain = Keychain(service: Configs.App.bundleIdentifier)

// enum UserType: String, HandyJSONEnum {
//     case user = "User"
//     case organization = "Organization"
// }
//
// enum TrendingUserType: String, HandyJSONEnum {
//     case user
//     case organization
// }

class XLUserModel: NSObject, SenderType, HandyJSON {
    var avatarUrl: String?  // A URL pointing to the user's public avatar.
    var blog: String?  // A URL pointing to the user's public website/blog.
    var company: String?  // The user's public profile company.
    var contributions: Int?
    var createdAt: Date?  // Identifies the date and time when the object was created.
    var email: String?  // The user's publicly visible profile email.
    var followers: Int?  // Identifies the total count of followers.
    var following: Int? // Identifies the total count of following.
    var htmlUrl: String?  // The HTTP URL for this user
    var location: String?  // The user's public profile location.
    var login: String?  // The username used to login.
    var name: String?  // The user's public profile name.
    var type: UserType = .user
    var updatedAt: Date?  // Identifies the date and time when the object was last updated.
    var starredRepositoriesCount: Int?  // Identifies the total count of repositories the user has starred.
    var repositoriesCount: Int?  // Identifies the total count of repositories that the user owns.
    var issuesCount: Int?  // Identifies the total count of issues associated with this user
    var watchingCount: Int?  // Identifies the total count of repositories the given user is watching
    var viewerCanFollow: Bool?  // Whether or not the viewer is able to follow the user.
    var viewerIsFollowing: Bool?  // Whether or not this user is followed by the viewer.
    var isViewer: Bool?  // Whether or not this user is the viewing user.
    var pinnedRepositories: [XLRepositoryModel]?  // A list of repositories this user has pinned to their profile
    var organizations: [XLUserModel]?  // A list of organizations the user belongs to.
    var contributionCalendar: XLContributionCalendarModel? // A calendar of this user's contributions on GitHub.

    // Only for Organization type
    var descriptionField: String?

    // Only for User type
    var bio: String?  // The user's public profile bio.

    // SenderType
    var senderId: String { return login ?? "" }
    var displayName: String { return login ?? "" }
    required override init() {}
    init(login: String?, name: String?, avatarUrl: String?, followers: Int?, viewerCanFollow: Bool?, viewerIsFollowing: Bool?) {
        self.login = login
        self.name = name
        self.avatarUrl = avatarUrl
        self.followers = followers
        self.viewerCanFollow = viewerCanFollow
        self.viewerIsFollowing = viewerIsFollowing
    }

    convenience init(user: XLTrendingUserModel) {
        self.init(login: user.username, name: user.name, avatarUrl: user.avatar, followers: nil, viewerCanFollow: nil, viewerIsFollowing: nil)
        switch user.type {
        case .user: self.type = .user
        case .organization: self.type = .organization
        }
    }
    func mapping(mapper: HelpingMapper) {
    //     super.mapping(mapper: mapper)
        mapper <<< avatarUrl <-- "avatar_url"
        mapper <<< createdAt <-- "created_at"
        mapper <<< htmlUrl <-- "html_url"
        mapper <<< updatedAt <-- "updated_at"
        mapper <<< starredRepositoriesCount <-- "starred_repositories_count"
        mapper <<< repositoriesCount <-- "repositories_count"
        mapper <<< issuesCount <-- "issues_count"
        mapper <<< watchingCount <-- "watching_count"
        mapper <<< viewerCanFollow <-- "viewer_can_follow"
        mapper <<< viewerIsFollowing <-- "viewer_is_following"
        mapper <<< isViewer <-- "is_viewer"
        mapper <<< pinnedRepositories <-- "pinned_repositories"
        mapper <<< contributionCalendar <-- "contribution_calendar"
        mapper <<< descriptionField <-- "description_field"
     }
    // override func didFinishMapping() {
    //     super.didFinishMapping()
    // }
    override var debugDescription: String { return toJSONString(prettyPrint: true) ?? "---" }
}

struct XLContributionCalendarModel: HandyJSON {
    var totalContributions: Int?
    var months: [Month]?
    var weeks: [[ContributionDay]]?

    struct Month: HandyJSON {
        var name: String?
    }

    struct ContributionDay: HandyJSON {
        var color: String?
        var contributionCount: Int?
        mutating func mapping(mapper: HelpingMapper) {
            mapper <<< contributionCount <-- "contribution_count"
        }
    }
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< totalContributions <-- "total_contributions"
    }
}

extension XLUserModel {
    func isMine() -> Bool {
        if let isViewer = isViewer {
            return isViewer
        }
        return self == XLUserModel.currentUser()
    }

    func save() {
        if let json = self.toJSONString() {
            keychain[userKey] = json
        } else {
            Logger.error("User can't be saved")
        }
    }

    static func currentUser() -> XLUserModel? {
//        if let json = keychain[userKey], let user = User(JSONString: json) {
//            return user
//        }
//        return nil
        return XLUserModel.deserialize(from: """
{\"updated_at\":\"2021-03-11T07:09:40Z\",\"public_repos\":40,\"created_at\":\"2014-08-05T09:48:33Z\",
\"email\":\"lx314333@gmail.com\",\"blog\":\"http:\\/\\/lxthyme.com\",
\"avatar_url\":\"https:\\/\\/avatars.githubusercontent.com\\/u\\/8361463?v=4\",
\"followers\":16,\"name\":\"lxthyme\",\"following\":20,
\"html_url\":\"https:\\/\\/github.com\\/lxthyme\",
\"login\":\"lxthyme\",\"type\":\"User\"}
""")
    }

    static func removeCurrentUser() {
        keychain[userKey] = nil
    }
}

/// UserSearch model
struct XLUserSearchModel: HandyJSON {

    var items: [XLUserModel] = []
    var totalCount: Int = 0
    var incompleteResults: Bool = false
    var hasNextPage: Bool = false
    var endCursor: String?
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< totalCount <-- "total_count"
        mapper <<< incompleteResults <-- "incomplete_results"
        mapper <<< hasNextPage <-- "has_next_page"
        mapper <<< endCursor <-- "end_cursor"
    }
}

/// TrendingUser model
struct XLTrendingUserModel: HandyJSON {
    var username: String?
    var name: String?
    var url: String?
    var avatar: String?
    var repo: XLTrendingRepositoryModel?
    var type: TrendingUserType = .user
}
