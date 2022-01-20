//
//  XLEventCellVM.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/23.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftDate

class XLEventCellVM: XLBaseTableViewCellVM {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    let title = BehaviorRelay<String?>(value: nil)
    let detail = BehaviorRelay<String?>(value: nil)
    let secondDetail = BehaviorRelay<String?>(value: nil)
    let attributedDetail = BehaviorRelay<NSAttributedString?>(value: nil)
    let image = BehaviorRelay<UIImage?>(value: nil)
    let imageUrl = BehaviorRelay<String?>(value: nil)
    let badge = BehaviorRelay<UIImage?>(value: nil)
    let badgeColor = BehaviorRelay<UIColor?>(value: nil)
    let hideDisclosure = BehaviorRelay<Bool>(value: false)
    /// XLEventCellVM
    let event: XLEventsModel
    let userSelected = PublishSubject<XLUserModel>()
    init(with event: XLEventsModel) {
        self.event = event
        super.init()

        let actorName = event.actor?.login ?? ""
        var badgeImage: UIImage?
        var actionText = ""
        var body = ""

        switch event.type {
        case .fork:
            actionText = "forked"
            badgeImage = R.image.icon_cell_badge_fork()
        case .create:
            let payload = event.payload as? XLPayloadModel.CreatePayload
            actionText = ["created", (payload?.refType.rawValue ?? ""), (payload?.ref ?? ""), "in"].joined(separator: " ")
            badgeImage = payload?.refType.image()
        case .delete:
            let payload = event.payload as? XLPayloadModel.DeletePayload
            actionText = ["deleted", (payload?.refType.rawValue ?? ""), (payload?.ref ?? ""), "in"].joined(separator: " ")
            badgeImage = payload?.refType.image()
        case .issueComment:
            let payload = event.payload as? XLPayloadModel.IssueCommentPayload
            actionText = ["commented on issue", "#\(payload?.issue?.number ?? 0)", "at"].joined(separator: " ")
            body = payload?.comment?.body ?? ""
            badgeImage = R.image.icon_cell_badge_comment()
        case .issues:
            let payload = event.payload as? XLPayloadModel.IssuesPayload
            actionText = [(payload?.action ?? ""), "issue", "in"].joined(separator: " ")
            body = payload?.issue?.title ?? ""
            badgeImage = R.image.icon_cell_badge_issue()
        case .member:
            let payload = event.payload as? XLPayloadModel.MemberPayload
            actionText = [(payload?.action ?? ""), "\(payload?.member?.login ?? "")", "as a collaborator to"].joined(separator: " ")
            badgeImage = R.image.icon_cell_badge_collaborator()
        case .pullRequest:
            let payload = event.payload as? XLPayloadModel.PullRequestPayload
            actionText = [(payload?.action ?? ""), "pull request", "#\(payload?.number ?? 0)", "in"].joined(separator: " ")
            body = payload?.pullRequest?.title ?? ""
            badgeImage = R.image.icon_cell_badge_pull_request()
        case .pullRequestReviewComment:
            let payload = event.payload as? XLPayloadModel.PullRequestReviewCommentPayload
            actionText = ["commented on pull request", "#\(payload?.pullRequest?.number ?? 0)", "in"].joined(separator: " ")
            body = payload?.comment?.body ?? ""
            badgeImage = R.image.icon_cell_badge_comment()
        case .push:
            let payload = event.payload as? XLPayloadModel.PushPayload
            actionText = ["pushed to", payload?.ref ?? "", "at"].joined(separator: " ")
            badgeImage = R.image.icon_cell_badge_push()
        case .release:
            let payload = event.payload as? XLPayloadModel.ReleasePayload
            actionText = [payload?.action ?? "", "release", payload?.release?.name ?? "", "in"].joined(separator: " ")
            body = payload?.release?.body ?? ""
            badgeImage = R.image.icon_cell_badge_tag()
        case .star:
            actionText = "starred"
            badgeImage = R.image.icon_cell_badge_star()
        default: break
        }

        let repoName = event.repository?.fullname ?? ""

        title.accept([actorName, actionText, repoName].joined(separator: " "))
        detail.accept(event.createdAt)
        secondDetail.accept(body)
        imageUrl.accept(event.actor?.avatarUrl)
        badge.accept(badgeImage?.template)
        badgeColor.accept(UIColor.Material.green)
    }
}

// MARK: 👀Public Actions
extension XLEventCellVM {}

// MARK: 🔐Private Actions
private extension XLEventCellVM {}

private extension XLEventCellVM {
    static func == (lhs: XLEventCellVM, rhs: XLEventCellVM) -> Bool {
        return lhs.event == rhs.event
    }
}

private extension CreateEventType {
    func image() -> UIImage? {
        switch self {
        case .repository: return R.image.icon_cell_badge_repository()
        case .branch: return R.image.icon_cell_badge_branch()
        case .tag: return R.image.icon_cell_badge_tag()
        }
    }
}

private extension DeleteEventType {
    func image() -> UIImage? {
        switch self {
        case .repository: return R.image.icon_cell_badge_repository()
        case .branch: return R.image.icon_cell_badge_branch()
        case .tag: return R.image.icon_cell_badge_tag()
        }
    }
}
