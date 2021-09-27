//
//  XLRepositoryModel.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//
import Foundation
import HandyJSON

class XLRepositoryModel: NSObject, HandyJSON {
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
    var languages: XLLanguagesModel?  // A list containing a breakdown of the language composition of the repository.
    var license: XLLicenseModel?
    var name: String?  // The name of the repository.
    var networkCount: Int?
    var nodeId: String?
    var openIssues: Int?
    var openIssuesCount: Int?  // Identifies the total count of issues that have been opened in the repository.
    var organization: XLUserModel?
    var owner: XLUserModel?  // The User owner of the repository.
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
    required override init() {}
    init(name: String?, fullname: String?, description: String?, language: String?, languageColor: String?, stargazers: Int?, viewerHasStarred: Bool?, ownerAvatarUrl: String?) {
        self.name = name
        self.fullname = fullname
        self.descriptionField = description
        self.language = language
        self.languageColor = languageColor
        self.stargazersCount = stargazers
        self.viewerHasStarred = viewerHasStarred
        owner = XLUserModel()
        owner?.avatarUrl = ownerAvatarUrl
    }

    convenience init(repo: XLTrendingRepositoryModel) {
        self.init(name: repo.name, fullname: repo.fullname, description: repo.descriptionField,
                  language: repo.language, languageColor: repo.languageColor, stargazers: repo.stars,
                  viewerHasStarred: nil, ownerAvatarUrl: repo.builtBy?.first?.avatar)
    }
    func parentRepository() -> XLRepositoryModel? {
        guard let parentFullName = parentFullname else { return nil }
        var repository = XLRepositoryModel()
        repository.fullname = parentFullName
        return repository
    }
     func mapping(mapper: HelpingMapper) {
    //     super.mapping(mapper: mapper)
        mapper <<< cloneUrl <-- "clone_url"
        mapper <<< createdAt <-- "created_at"
        mapper <<< defaultBranch <-- "default_branch"
        mapper <<< descriptionField <-- "description_field"
        mapper <<< forksCount <-- "forks_count"
        mapper <<< hasDownloads <-- "has_downloads"
        mapper <<< hasIssues <-- "has_issues"
        mapper <<< hasPages <-- "has_pages"
        mapper <<< hasProjects <-- "has_projects"
        mapper <<< hasWiki <-- "has_wiki"
        mapper <<< htmlUrl <-- "html_url"
        mapper <<< languageColor <-- "language_color"
        mapper <<< networkCount <-- "network_count"
        mapper <<< nodeId <-- "node_id"
        mapper <<< openIssues <-- "open_issues"
        mapper <<< openIssuesCount <-- "open_issues_count"
        mapper <<< privateField <-- "private_field"
        mapper <<< pushedAt <-- "pushed_at"
        mapper <<< sshUrl <-- "ssh_url"
        mapper <<< stargazersCount <-- "stargazers_count"
        mapper <<< subscribersCount <-- "subscribers_count"
        mapper <<< updatedAt <-- "updated_at"
        mapper <<< watchersCount <-- "watchers_count"
        mapper <<< parentFullname <-- "parent_fullname"
        mapper <<< commitsCount <-- "commits_count"
        mapper <<< pullRequestsCount <-- "pull_requests_count"
        mapper <<< branchesCount <-- "branches_count"
        mapper <<< releasesCount <-- "releases_count"
        mapper <<< contributorsCount <-- "contributors_count"
        mapper <<< viewerHasStarred <-- "viewer_has_starred"
     }
    // override func didFinishMapping() {
    //     super.didFinishMapping()
    // }
    override var debugDescription: String { return toJSONString(prettyPrint: true) ?? "---" }
}

struct XLRepositorySearchModel: HandyJSON {
    var items: [XLRepositoryModel] = []
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

struct XLTrendingRepositoryModel: HandyJSON {
    var author: String?
    var name: String?
    var url: String?
    var descriptionField: String?
    var language: String?
    var languageColor: String?
    var stars: Int?
    var forks: Int?
    var currentPeriodStars: Int?
    var builtBy: [XLTrendingUserModel]?

    var fullname: String? {
        return "\(author ?? "")/\(name ?? "")"
    }

    var avatarUrl: String? {
        return builtBy?.first?.avatar
    }
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< descriptionField <-- "description_field"
        mapper <<< languageColor <-- "language_color"
        mapper <<< currentPeriodStars <-- "current_period_stars"
        mapper <<< builtBy <-- "built_by"
    }
}
