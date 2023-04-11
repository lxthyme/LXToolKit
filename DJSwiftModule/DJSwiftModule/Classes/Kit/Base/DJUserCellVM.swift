//
//  DJUserCellVM.swift
//  test
//
//  Created by lxthyme on 2023/3/26.
//
import UIKit
import BonMot

private extension UserModel {
    func attributetDetail() -> NSAttributedString? {
        var texts: [NSAttributedString] = []
        if let repositoriesString = repositoriesCount?.string.styled( with: .color(UIColor.text())) {
            let repositoriesImage = R.image.icon_cell_badge_repository()?.filled(withColor: UIColor.text()).scaled(toHeight: 15)?.styled(with: .baselineOffset(-3)) ?? NSAttributedString()
            texts.append(NSAttributedString.composed(of: [
                repositoriesImage, Special.space, repositoriesString, Special.space, Special.tab
            ]))
        }
        if let followersString = followers?.kFormatted().styled( with: .color(UIColor.text())) {
            let followersImage = R.image.icon_cell_badge_collaborator()?.filled(withColor: UIColor.text()).scaled(toHeight: 15)?.styled(with: .baselineOffset(-3)) ?? NSAttributedString()
            texts.append(NSAttributedString.composed(of: [
                followersImage, Special.space, followersString
            ]))
        }
        return NSAttributedString.composed(of: texts)
    }
}

class DJUserCellVM: DJSearchDefaultCellVM {
    // MARK: 🔗Vaiables
    let following = BehaviorRelay(value: false)
    let hidesFollowButton = BehaviorRelay(value: true)

    let user: UserModel
    // MARK: 🛠Life Cycle
    init(user: UserModel) {
        self.user = user
        super.init()
        title.accept(user.login)
        detail.accept("\((user.contributions != nil) ? "\(user.contributions ?? 0) commits" : (user.name ?? ""))")
        attributedDetail.accept(user.attributetDetail())
        imageUrl.accept(user.avatarUrl)
        badge.accept(R.image.icon_cell_badge_user()?.template)
        badgeColor.accept(.Material.green900)

        following.accept(user.viewerIsFollowing ?? false)
        loggedIn.map { loggedIn -> Bool in
            if !loggedIn { return true }
            if let viewerCanFollow = user.viewerCanFollow {
                return !viewerCanFollow
            }
            return true
        }
        .bind(to: hidesFollowButton)
        .disposed(by: rx.disposeBag)
    }
}

// MARK: 👀Public Actions
extension DJUserCellVM {
    static func == (lhs: DJUserCellVM, rhs: DJUserCellVM) -> Bool {
        return lhs.user == rhs.user
    }
}

// MARK: 🔐Private Actions
private extension DJUserCellVM {}
