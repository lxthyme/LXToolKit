//
//  RepositoryModel.swift
//  test
//
//  Created by lxthyme on 2023/3/23.
//

import Foundation
import HandyJSON

struct RepositoryModel: HandyJSON {
    var archived: Bool?
    var cloneUrl: String?
    var createdAt: Date?  // Identifies the date and time when the object was created.
    var defaultBranch = "master"  // The Ref name associated with the repository's default branch.
    var descriptionField: String?  // The description of the repository.
    var fork: Bool?  // Identifies if the repository is a fork.
    var forks: Int?  // Identifies the total count of direct forked repositories
    var forksCount: Int?
    var fullname: String?  // The repository's name with owner.
    var hasDownloads: Bool?
    var hasIssues: Bool?
    var hasPages: Bool?
    var hasProjects: Bool?
    var hasWiki: Bool?
    var homepage: String?  // The repository's URL.
    var htmlUrl: String?
    var language: String?  // The name of the current language.
    var languageColor: String?  // The color defined for the current language.
    var languages: LanguagesModel?  // A list containing a breakdown of the language composition of the repository.
    var license: LicenseModel?
    var name: String?  // The name of the repository.
    var networkCount: Int?
    var nodeId: String?
    var openIssues: Int?
    var openIssuesCount: Int?  // Identifies the total count of issues that have been opened in the repository.
    var organization: UserModel?
    var owner: UserModel?  // The User owner of the repository.
    var privateField: Bool?
    var pushedAt: String?
    var size: Int?  // The number of kilobytes this repository occupies on disk.
    var sshUrl: String?
    var stargazersCount: Int?  // Identifies the total count of items who have starred this starrable.
    var subscribersCount: Int?  // Identifies the total count of users watching the repository
    var updatedAt: Date?  // Identifies the date and time when the object was last updated.
    var url: String?  // The HTTP URL for this repository
    var watchers: Int?
    var watchersCount: Int?
    var parentFullname: String?  // The parent repository's name with owner, if this is a fork.

    var commitsCount: Int?  // Identifies the total count of the commits
    var pullRequestsCount: Int?  // Identifies the total count of a list of pull requests that have been opened in the repository.
    var branchesCount: Int?
    var releasesCount: Int?  // Identifies the total count of releases which are dependent on this repository.
    var contributorsCount: Int?  // Identifies the total count of Users that can be mentioned in the context of the repository.

    var viewerHasStarred: Bool?  // Returns a boolean indicating whether the viewing user has starred this starrable.

    init() {}
    init(name: String?, fullname: String?, description: String?, language: String?, languageColor: String?, stargazers: Int?, viewerHasStarred: Bool?, ownerAvatarUrl: String?) {
        self.name = name
        self.fullname = fullname
        self.descriptionField = description
        self.language = language
        self.languageColor = languageColor
        self.stargazersCount = stargazers
        self.viewerHasStarred = viewerHasStarred
        owner = UserModel()
        owner?.avatarUrl = ownerAvatarUrl
    }
    init(repo: TrendingRepositoryModel) {
        self.init(name: repo.name, fullname: repo.fullname, description: repo.descriptionField,
                  language: repo.language, languageColor: repo.languageColor, stargazers: repo.stars,
                  viewerHasStarred: nil, ownerAvatarUrl: repo.builtBy?.first?.avatar)
    }

    func parentRepository() -> RepositoryModel? {
        guard let parentFullName = parentFullname else { return nil }
        var repository = RepositoryModel()
        repository.fullname = parentFullName
        return repository
    }

    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< cloneUrl <-- "clone_url"
        mapper <<< createdAt <-- ("created_at", ISO8601DateTransform())
        mapper <<< defaultBranch <-- "default_branch"
        mapper <<< descriptionField <-- "description"
        mapper <<< forksCount <-- "forks_count"
        mapper <<< fullname <-- "full_name"
        mapper <<< hasDownloads <-- "has_downloads"
        mapper <<< hasIssues <-- "has_issues"
        mapper <<< hasPages <-- "has_pages"
        mapper <<< hasProjects <-- "has_projects"
        mapper <<< hasWiki <-- "has_wiki"
        mapper <<< htmlUrl <-- "html_url"
        mapper <<< networkCount <-- "network_count"
        mapper <<< nodeId <-- "node_id"
        mapper <<< openIssues <-- "open_issues"
        mapper <<< openIssuesCount <-- "open_issues_count"
        mapper <<< privateField <-- "private"
        mapper <<< pushedAt <-- "pushed_at"
        mapper <<< sshUrl <-- "ssh_url"
        mapper <<< stargazersCount <-- "stargazers_count"
        mapper <<< subscribersCount <-- "subscribers_count"
        mapper <<< updatedAt <-- ("updated_at", ISO8601DateTransform())
        mapper <<< watchersCount <-- "watchers_count"
        mapper <<< parentFullname <-- "parent.full_name"
    }
}

extension RepositoryModel {
    init(graph: RepositoryQuery.Data.Repository?) {
        self.init(name: graph?.name, fullname: graph?.nameWithOwner, description: graph?.description,
                  language: graph?.primaryLanguage?.name, languageColor: graph?.primaryLanguage?.color,
                  stargazers: graph?.stargazers.totalCount, viewerHasStarred: graph?.viewerHasStarred, ownerAvatarUrl: graph?.owner.avatarUrl)
        htmlUrl = graph?.url
        homepage = graph?.homepageUrl
        createdAt =  graph?.createdAt.toISODate()?.date
        updatedAt = graph?.updatedAt.toISODate()?.date
        size = graph?.diskUsage
        fork = graph?.isFork
        parentFullname = graph?.parent?.nameWithOwner
        defaultBranch = graph?.defaultBranchRef?.name ?? "master"
        subscribersCount = graph?.watchers.totalCount
        forks = graph?.forks.totalCount
        openIssuesCount = graph?.issues.totalCount
        commitsCount = graph?.ref?.target.asCommit?.history.totalCount
        pullRequestsCount = graph?.pullRequests.totalCount
        releasesCount = graph?.releases.totalCount
        contributorsCount = graph?.mentionableUsers.totalCount
        owner?.login = graph?.owner.login
        owner?.type = graph?.owner.asOrganization != nil ? UserType.organization: UserType.user
        languages = LanguagesModel(graph: graph?.languages)
        if languages?.totalCount == 0 {
            languages = nil
        }
    }

    init(graph: SearchRepositoriesQuery.Data.Search.Node.AsRepository?) {
        self.init(name: graph?.name, fullname: graph?.nameWithOwner, description: graph?.description,
                  language: graph?.primaryLanguage?.name, languageColor: graph?.primaryLanguage?.color,
                  stargazers: graph?.stargazers.totalCount, viewerHasStarred: graph?.viewerHasStarred, ownerAvatarUrl: graph?.owner.avatarUrl)
    }

    init(graph: UserQuery.Data.User.PinnedItem.Node.AsRepository?) {
        self.init(name: graph?.name, fullname: graph?.nameWithOwner, description: graph?.description,
                  language: graph?.primaryLanguage?.name, languageColor: graph?.primaryLanguage?.color,
                  stargazers: graph?.stargazers.totalCount, viewerHasStarred: graph?.viewerHasStarred, ownerAvatarUrl: graph?.owner.avatarUrl)
    }

    init(graph: ViewerQuery.Data.Viewer.PinnedItem.Node.AsRepository?) {
        self.init(name: graph?.name, fullname: graph?.nameWithOwner, description: graph?.description,
                  language: graph?.primaryLanguage?.name, languageColor: graph?.primaryLanguage?.color,
                  stargazers: graph?.stargazers.totalCount, viewerHasStarred: graph?.viewerHasStarred, ownerAvatarUrl: graph?.owner.avatarUrl)
    }
}


extension RepositoryModel: Equatable {
    static func == (lhs: RepositoryModel, rhs: RepositoryModel) -> Bool {
        return lhs.fullname == rhs.fullname
    }
}

public struct RepositorySearchModel: HandyJSON {
    // MARK: 🔗Vaiables
    var items: [RepositoryModel] = []
    var totalCount: Int = 0
    var incompleteResults: Bool = false
    var hasNextPage: Bool = false
    var endCursor: String?
    // MARK: 🛠Life Cycle
    public init() {}
    mutating public func didFinishMapping() {
        hasNextPage = items.isNotEmpty
    }
    mutating public func mapping(mapper: HelpingMapper) {
        mapper <<< totalCount <-- "total_count"
        mapper <<< incompleteResults <-- "incomplete_results"
    }
}

public extension RepositorySearchModel {
    init(graph: SearchRepositoriesQuery.Data.Search) {
        if let repos = graph.nodes?.map({ RepositoryModel(graph: $0?.asRepository) }) {
            items = repos
        }
        totalCount = graph.repositoryCount
        hasNextPage = graph.pageInfo.hasNextPage
        endCursor = graph.pageInfo.endCursor
    }
}

public struct TrendingRepositoryModel: HandyJSON {
    var author: String?
    var name: String?
    var url: String?
    var descriptionField: String?
    var language: String?
    var languageColor: String?
    var stars: Int?
    var forks: Int?
    var currentPeriodStars: Int?
    var builtBy: [TrendingUserModel]?

    var fullname: String? {
        return "\(author ?? "")/\(name ?? "")"
    }

    var avatarUrl: String? {
        return builtBy?.first?.avatar
    }
    // MARK: 🛠Life Cycle
    public init() {}
    mutating public func mapping(mapper: HelpingMapper) {
        mapper <<< descriptionField <-- "description"
    }
}

extension TrendingRepositoryModel: Equatable {
    public static func == (lhs: TrendingRepositoryModel, rhs: TrendingRepositoryModel) -> Bool {
        return lhs.fullname == rhs.fullname
    }
}
