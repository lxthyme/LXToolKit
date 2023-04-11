//
//  DJTrendingUserCellVM.swift
//  test
//
//  Created by lxthyme on 2023/3/26.
//
import UIKit

class DJTrendingUserCellVM: DJSearchDefaultCellVM {
    // MARK: 🔗Vaiables
    let user: TrendingUserModel
    // MARK: 🛠Life Cycle
    init(user: TrendingUserModel) {
        self.user = user
        super.init()
        title.accept("\(user.username ?? "") \(user.name ?? "")")
        detail.accept(user.repo?.fullname)
        imageUrl.accept(user.avatar)
        badge.accept(R.image.icon_cell_badge_user()?.template)
        badgeColor.accept(.Material.green900)
    }
}

// MARK: 👀Public Actions
extension DJTrendingUserCellVM {
    static func == (lhs: DJTrendingUserCellVM, rhs: DJTrendingUserCellVM) -> Bool {
        return lhs.user == rhs.user
    }
}

// MARK: 🔐Private Actions
private extension DJTrendingUserCellVM {}
