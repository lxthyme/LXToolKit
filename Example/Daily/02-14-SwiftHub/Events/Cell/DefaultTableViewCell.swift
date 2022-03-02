//
//  DefaultTableViewCell.swift
//  SwiftHub
//
//  Created by Khoren Markosyan on 6/30/18.
//  Copyright © 2018 Khoren Markosyan. All rights reserved.
//

import UIKit
import LXToolKit

class DefaultTableViewCell: LXBaseMVVMTableCell {
    lazy var leftImageView: UIImageView = {
        let view = UIImageView(frame: CGRect())
        view.contentMode = .scaleAspectFit
        view.cornerRadius = 25
        view.snp.makeConstraints({ (make) in
            make.size.equalTo(50)
        })
        return view
    }()

    lazy var badgeImageView: UIImageView = {
        let view = UIImageView(frame: CGRect())
        view.backgroundColor = .white
        view.cornerRadius = 10
        view.borderColor = .white
        view.borderWidth = 1
        wrapperView.addSubview(view)
        view.snp.makeConstraints({ (make) in
            make.bottom.left.equalTo(self.leftImageView)
            make.size.equalTo(20)
        })
        return view
    }()

    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = view.font.withSize(14)
        return view
    }()

    lazy var detailLabel: UILabel = {
        let view = UILabel()
        view.font = view.font.withSize(12)
        view.xl.setPriority(UILayoutPriority.defaultLow, for: NSLayoutConstraint.Axis.vertical)
        return view
    }()

    lazy var secondDetailLabel: UILabel = {
        let view = UILabel()
        view.font = view.font.bold.withSize(11)
        return view
    }()

    lazy var attributedDetailLabel: UILabel = {
        let view = UILabel()
        view.font = view.font.bold.withSize(11)
        return view
    }()

    lazy var textsStackView: UIStackView = {
        let views: [UIView] = [self.titleLabel, self.detailLabel, self.secondDetailLabel, self.attributedDetailLabel]
        let view = UIStackView(arrangedSubviews: views)
        view.spacing = 2
        return view
    }()

    lazy var rightImageView: UIImageView = {
        let view = UIImageView(frame: CGRect())
        view.image = R.image.icon_cell_disclosure()?.template
        view.snp.makeConstraints({ (make) in
            make.width.equalTo(20)
        })
        return view
    }()

    override func bind(to viewModel: LXBaseMVVMTableCellVM) {
        super.bind(to: viewModel)
        guard let viewModel = viewModel as? DefaultTableViewCellViewModel else { return }

        viewModel.title.asDriver().drive(titleLabel.rx.text).disposed(by: rx.disposeBag)
        viewModel.title.asDriver().replaceNilWith("").map { $0.isEmpty }.drive(titleLabel.rx.isHidden).disposed(by: rx.disposeBag)

        viewModel.detail.asDriver().drive(detailLabel.rx.text).disposed(by: rx.disposeBag)
        viewModel.detail.asDriver().replaceNilWith("").map { $0.isEmpty }.drive(detailLabel.rx.isHidden).disposed(by: rx.disposeBag)

        viewModel.secondDetail.asDriver().drive(secondDetailLabel.rx.text).disposed(by: rx.disposeBag)
        viewModel.secondDetail.asDriver().replaceNilWith("").map { $0.isEmpty }.drive(secondDetailLabel.rx.isHidden).disposed(by: rx.disposeBag)

        viewModel.attributedDetail.asDriver().drive(attributedDetailLabel.rx.attributedText).disposed(by: rx.disposeBag)
        viewModel.attributedDetail.asDriver().map { $0 == nil }.drive(attributedDetailLabel.rx.isHidden).disposed(by: rx.disposeBag)

        viewModel.badge.asDriver().drive(badgeImageView.rx.image).disposed(by: rx.disposeBag)
        viewModel.badge.map { $0 == nil }.asDriver(onErrorJustReturn: true).drive(badgeImageView.rx.isHidden).disposed(by: rx.disposeBag)

        viewModel.badgeColor.asDriver().drive(badgeImageView.rx.tintColor).disposed(by: rx.disposeBag)

        viewModel.hidesDisclosure.asDriver().drive(rightImageView.rx.isHidden).disposed(by: rx.disposeBag)

        viewModel.image.asDriver().filterNil()
            .drive(leftImageView.rx.image).disposed(by: rx.disposeBag)

        viewModel.imageUrl.map { $0?.url }.asDriver(onErrorJustReturn: nil).filterNil()
            .drive(leftImageView.rx.imageURL).disposed(by: rx.disposeBag)

        viewModel.imageUrl.asDriver().filterNil()
            .drive(onNext: { [weak self] (url) in
                self?.leftImageView.hero.id = url
            }).disposed(by: rx.disposeBag)
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension DefaultTableViewCell {
    func prepareUI() {
        titleLabel.theme.textColor = themeService.attribute { $0.text }
        detailLabel.theme.textColor = themeService.attribute { $0.textGray }
        secondDetailLabel.theme.textColor = themeService.attribute { $0.text }
        leftImageView.theme.tintColor = themeService.attribute { $0.secondary }
        rightImageView.theme.tintColor = themeService.attribute { $0.secondary }

        // [<#table#>].forEach(self.<#view#>.addSubview)
        [leftImageView, textsStackView, rightImageView].forEach(wrapperStackView.addArrangedSubview)
        masonry()
    }
    func masonry() {
        wrapperStackView.snp.remakeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8))
            $0.height.greaterThanOrEqualTo(Configs.BaseDimensions.tableRowHeight)
        }
    }
}
