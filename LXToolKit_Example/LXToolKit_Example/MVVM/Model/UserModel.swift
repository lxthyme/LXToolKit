//
//  UserModel.swift
//  test
//
//  Created by lxthyme on 2023/3/23.
//

import Foundation
import HandyJSON
import MessageKit
import KeychainAccess

private let userKey = "CurrentUserKey"
private let keychain = Keychain(service: AppConfig.App.bundleIdentifier)

enum UserType: String {
    case user = "User"
    case organization = "Organization"
}

struct ContributionCalendarModel: HandyJSON {
    var totalContributions: Int?
    var months: [Month]?
    var weeks: [[ContributionDay]]?

    struct Month {
        var name: String?
    }

    struct ContributionDay {
        var color: String?
        var contributionCount: Int?
    }
}

extension ContributionCalendarModel {
    init(graph: ViewerQuery.Data.Viewer.ContributionsCollection?) {
        let calendar = graph?.contributionCalendar
        totalContributions = calendar?.totalContributions
        months = calendar?.months.map { Month(name: $0.name) }
        weeks = calendar?.weeks.map { $0.contributionDays.map { ContributionDay(color: $0.color, contributionCount: $0.contributionCount) } }
    }

    init(graph: UserQuery.Data.User.ContributionsCollection?) {
        let calendar = graph?.contributionCalendar
        totalContributions = calendar?.totalContributions
        months = calendar?.months.map { Month(name: $0.name) }
        weeks = calendar?.weeks.map { $0.contributionDays.map { ContributionDay(color: $0.color, contributionCount: $0.contributionCount) } }
    }
}

struct UserModel: HandyJSON, SenderType {
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
    var pinnedRepositories: [RepositoryModel]?  // A list of repositories this user has pinned to their profile
    var organizations: [UserModel]?  // A list of organizations the user belongs to.
    var contributionCalendar: ContributionCalendarModel? // A calendar of this user's contributions on GitHub.

    // Only for Organization type
    var descriptionField: String?

    // Only for User type
    var bio: String?  // The user's public profile bio.

    // SenderType
    var senderId: String { return login ?? "" }
    var displayName: String { return login ?? "" }

    init() {}
    init(login: String?, name: String?, avatarUrl: String?, followers: Int?, viewerCanFollow: Bool?, viewerIsFollowing: Bool?) {
        self.login = login
        self.name = name
        self.avatarUrl = avatarUrl
        self.followers = followers
        self.viewerCanFollow = viewerCanFollow
        self.viewerIsFollowing = viewerIsFollowing
    }

    init(user: TrendingUserModel) {
        self.init(login: user.username, name: user.name, avatarUrl: user.avatar, followers: nil, viewerCanFollow: nil, viewerIsFollowing: nil)
        switch user.type {
        case .user: self.type = .user
        case .organization: self.type = .organization
        }
    }

    // override func didFinishMapping() {
    //     super.didFinishMapping()
    // }
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< avatarUrl <-- "avatar_url"
        mapper <<< blog <-- "blog"
        mapper <<< company <-- "company"
        mapper <<< contributions <-- "contributions"
        mapper <<< createdAt <-- ("created_at", ISO8601DateTransform())
        mapper <<< descriptionField <-- "description"
        mapper <<< email <-- "email"
        mapper <<< followers <-- "followers"
        mapper <<< following <-- "following"
        mapper <<< htmlUrl <-- "html_url"
        mapper <<< location <-- "location"
        mapper <<< login <-- "login"
        mapper <<< name <-- "name"
        mapper <<< repositoriesCount <-- "public_repos"
        mapper <<< type <-- "type"
        mapper <<< updatedAt <-- ("updated_at", ISO8601DateTransform())
        mapper <<< bio <-- "bio"
    }
    var debugDescription: String { return toJSONString(prettyPrint: true) ?? "---" }
}

/// GraphQL initializators for User model
extension UserModel {
    init(graph: ViewerQuery.Data.Viewer?) {
        self.init(login: graph?.login, name: graph?.name, avatarUrl: graph?.avatarUrl, followers: graph?.followers.totalCount,
                  viewerCanFollow: graph?.viewerCanFollow, viewerIsFollowing: graph?.viewerIsFollowing)
        htmlUrl = graph?.url
        blog = graph?.websiteUrl
        bio = graph?.bio
        company = graph?.company
        email = graph?.email
        location = graph?.location
        createdAt = graph?.createdAt.toISODate()?.date
        updatedAt = graph?.updatedAt.toISODate()?.date
        isViewer = graph?.isViewer
        following = graph?.following.totalCount
        starredRepositoriesCount = graph?.starredRepositories.totalCount
        repositoriesCount = graph?.repositories.totalCount
        issuesCount = graph?.issues.totalCount
        watchingCount = graph?.watching.totalCount
        pinnedRepositories = graph?.pinnedItems.nodes?.map { RepositoryModel(graph: $0?.asRepository) }
        organizations = graph?.organizations.nodes?.map { UserModel(graph: $0) }
        contributionCalendar = ContributionCalendarModel(graph: graph?.contributionsCollection)
    }

    init(graph: UserQuery.Data.User?) {
        self.init(login: graph?.login, name: graph?.name, avatarUrl: graph?.avatarUrl, followers: graph?.followers.totalCount,
                  viewerCanFollow: graph?.viewerCanFollow, viewerIsFollowing: graph?.viewerIsFollowing)
        htmlUrl = graph?.url
        blog = graph?.websiteUrl
        bio = graph?.bio
        company = graph?.company
        email = graph?.email
        location = graph?.location
        createdAt = graph?.createdAt.toISODate()?.date
        updatedAt = graph?.updatedAt.toISODate()?.date
        isViewer = graph?.isViewer
        following = graph?.following.totalCount
        starredRepositoriesCount = graph?.starredRepositories.totalCount
        repositoriesCount = graph?.repositories.totalCount
        issuesCount = graph?.issues.totalCount
        watchingCount = graph?.watching.totalCount
        pinnedRepositories = graph?.pinnedItems.nodes?.map { RepositoryModel(graph: $0?.asRepository) }
        organizations = graph?.organizations.nodes?.map { UserModel(graph: $0) }
        contributionCalendar = ContributionCalendarModel(graph: graph?.contributionsCollection)
    }

    init(graph: SearchUsersQuery.Data.Search.Node.AsUser?) {
        self.init(login: graph?.login, name: graph?.name, avatarUrl: graph?.avatarUrl, followers: graph?.followers.totalCount,
                  viewerCanFollow: graph?.viewerCanFollow, viewerIsFollowing: graph?.viewerIsFollowing)
        repositoriesCount = graph?.repositories.totalCount
    }

    init(graph: UserQuery.Data.User.Organization.Node?) {
        self.init(login: graph?.login, name: graph?.name, avatarUrl: graph?.avatarUrl,
                  followers: nil, viewerCanFollow: nil, viewerIsFollowing: nil)
        descriptionField = graph?.description
        type = UserType.organization
    }

    init(graph: ViewerQuery.Data.Viewer.Organization.Node?) {
        self.init(login: graph?.login, name: graph?.name, avatarUrl: graph?.avatarUrl,
                  followers: nil, viewerCanFollow: nil, viewerIsFollowing: nil)
        descriptionField = graph?.description
        type = UserType.organization
    }
}

extension UserModel {
    func isMine() -> Bool {
        if let isViewer = isViewer {
            return isViewer
        }
        return self == UserModel.currentUser()
    }

    func save() {
        if let json = self.toJSONString() {
            keychain[userKey] = json
        } else {
            logError("User can't be saved")
        }
    }

    static func currentUser() -> UserModel? {
        if let json = keychain[userKey], let user = UserModel.deserialize(from: json) {
            return user
        }
        return nil
    }

    static func removeCurrentUser() {
        keychain[userKey] = nil
    }
}

extension UserModel: Equatable {
    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
        return lhs.login == rhs.login
    }
}

struct UserSearchModel: HandyJSON {
    var items: [UserModel] = []
    var totalCount: Int = 0
    var incompleteResults: Bool = false
    var hasNextPage: Bool = false
    var endCursor: String?

    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< self.totalCount <-- "total_count"
        mapper <<< self.incompleteResults <-- "incomplete_results"
    }
    // override func didFinishMapping() {
    //     super.didFinishMapping()
    // }
    var debugDescription: String { return toJSONString(prettyPrint: true) ?? "---" }
}

/// GraphQL initializators for UserSearch model
extension UserSearchModel {
    init(graph: SearchUsersQuery.Data.Search) {
        if let users = graph.nodes?.map({ UserModel(graph: $0?.asUser) }) {
            items = users
        }
        totalCount = graph.userCount
        hasNextPage = graph.pageInfo.hasNextPage
        endCursor = graph.pageInfo.endCursor
    }
}

enum TrendingUserType: String {
    case user
    case organization
}

struct TrendingUserModel: HandyJSON {
    var username: String?
    var name: String?
    var url: String?
    var avatar: String?
    var repo: TrendingRepositoryModel?
    var type: TrendingUserType = .user

    // func mapping(mapper: HelpingMapper) {
    //     super.mapping(mapper: mapper)
    // }
    mutating func didFinishMapping() {
        repo?.author = username
    }
    var debugDescription: String { return toJSONString(prettyPrint: true) ?? "---" }
}

extension TrendingUserModel: Equatable {
    static func == (lhs: TrendingUserModel, rhs: TrendingUserModel) -> Bool {
        return lhs.username == rhs.username
    }
}
