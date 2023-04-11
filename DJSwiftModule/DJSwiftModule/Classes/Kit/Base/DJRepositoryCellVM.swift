//
//  DJRepositoryCellVM.swift
//  test
//
//  Created by lxthyme on 2023/3/26.
//
import UIKit
import BonMot

private extension RepositoryModel {
    func attributetDetail() -> NSAttributedString? {
        var texts: [NSAttributedString] = []

        let starsString = (stargazersCount ?? 0).kFormatted().styled( with: .color(UIColor.text()))
        let starsImage = R.image.icon_cell_badge_star()?.filled(withColor: UIColor.text()).scaled(toHeight: 15)?.styled(with: .baselineOffset(-3)) ?? NSAttributedString()
        texts.append(NSAttributedString.composed(of: [
            starsImage, Special.space, starsString, Special.space, Special.tab
            ]))

        if let languageString = language?.styled( with: .color(UIColor.text())) {
            let languageColorShape = "●".styled(with: StringStyle([.color(UIColor(hexString: languageColor ?? "") ?? .clear)]))
            texts.append(NSAttributedString.composed(of: [
                languageColorShape, Special.space, languageString
                ]))
        }

        return NSAttributedString.composed(of: texts)
    }
}

class DJRepositoryCellVM: DJSearchDefaultCellVM {
    // MARK: 🔗Vaiables
    let starring = BehaviorRelay(value: false)
    let hidesStarButton = BehaviorRelay(value: true)

    let repository: RepositoryModel
    // MARK: 🛠Life Cycle
    init(repository: RepositoryModel) {
        self.repository = repository
        super.init()
        title.accept(repository.fullname)
        detail.accept(repository.descriptionField)
        attributedDetail.accept(repository.attributetDetail())
        imageUrl.accept(repository.owner?.avatarUrl)
        badge.accept(R.image.icon_cell_badge_repository()?.template)
        badgeColor.accept(.Material.green900)

        starring.accept(repository.viewerHasStarred ?? false)
        loggedIn.map { !$0 || repository.viewerHasStarred == nil }
            .bind(to: hidesStarButton)
            .disposed(by: rx.disposeBag)
    }
}

// MARK: 👀Public Actions
extension DJRepositoryCellVM {
    static func == (lhs: DJRepositoryCellVM, rhs: DJRepositoryCellVM) -> Bool {
        return lhs.repository == rhs.repository
    }
}

// MARK: 🔐Private Actions
private extension DJRepositoryCellVM {}
