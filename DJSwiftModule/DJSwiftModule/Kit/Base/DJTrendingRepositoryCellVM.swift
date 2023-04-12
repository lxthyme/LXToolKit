//
//  DJTrendingRepositoryCellVM.swift
//  test
//
//  Created by lxthyme on 2023/3/26.
//
import UIKit
import BonMot

private extension TrendingRepositoryModel {
    func attributetDetail(since: String) -> NSAttributedString {
        let starImage = R.image.icon_cell_badge_star()?.filled(withColor: .text()).scaled(toHeight: 15)?.styled(with: .baselineOffset(-3)) ?? NSAttributedString()
        let starsString = (stars ?? 0).kFormatted().styled( with: .color(UIColor.text()))
        let currentPeriodStarsString = "\((currentPeriodStars ?? 0).kFormatted()) \(since.lowercased())".styled( with: .color(UIColor.text()))
        let languageColorShape = "●".styled(with: StringStyle([.color(UIColor(hexString: languageColor ?? "") ?? .clear)]))
        let languageString = (language ?? "").styled( with: .color(UIColor.text()))
        return NSAttributedString.composed(of: [
            starImage, Special.space, starsString, Special.space, Special.tab,
            starImage, Special.space, currentPeriodStarsString, Special.space, Special.tab,
            languageColorShape, Special.space, languageString
        ])
    }
}

class DJTrendingRepositoryCellVM: DJSearchDefaultCellVM {
    // MARK: 🔗Vaiables
    let repository: TrendingRepositoryModel
    // MARK: 🛠Life Cycle
    init(repository: TrendingRepositoryModel, since: TrendingPeriodSegments) {
        self.repository = repository
        super.init()
        title.accept(repository.fullname)
        detail.accept(repository.descriptionField)
        attributedDetail.accept(repository.attributetDetail(since: since.title))
        imageUrl.accept(repository.avatarUrl)
        badge.accept(R.image.icon_cell_badge_repository()?.template)
        badgeColor.accept(.Material.green900)
    }
}

// MARK: 👀Public Actions
extension DJTrendingRepositoryCellVM {
    static func == (lhs: DJTrendingRepositoryCellVM, rhs: DJTrendingRepositoryCellVM) -> Bool {
        return lhs.repository == rhs.repository
    }
}

// MARK: 🔐Private Actions
private extension DJTrendingRepositoryCellVM {}
