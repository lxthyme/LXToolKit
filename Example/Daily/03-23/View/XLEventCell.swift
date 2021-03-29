//
//  XLEventCell.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/23.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxOptional
import Hero
import LXToolKit

class XLEventCell: XLBaseTableViewCell {
    // MARK: 📌UI
    private lazy var middleStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.alignment = .fill
        return v
    }()
    lazy var leftImageView: UIImageView = {
        let view = UIImageView(frame: CGRect())
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 25
        return view
    }()

    lazy var badgeImageView: UIImageView = {
        let view = UIImageView(frame: CGRect())
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
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
        view.setPriority(UILayoutPriority.defaultLow, for: NSLayoutConstraint.Axis.vertical)
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
        view.axis = .vertical
        view.spacing = 8
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
    // MARK: 🔗Vaiables
    override var reuseIdentifier: String? {
        return "AAA"
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareUI()
    }
}

// MARK: 👀Public Actions
extension XLEventCell {
    override func bind(to viewModel: XLBaseTableViewCellVM) {
        super.bind(to: viewModel)
        guard let vm = viewModel as? XLEventCellVM else { return }

        vm.title.asDriver()
            .drive(titleLabel.rx.text)
            .disposed(by: rx.disposeBag)
        vm.title.asDriver()
            .replaceNilWith("")
            .map { $0.isEmpty }
            .drive(titleLabel.rx.isHidden)
            .disposed(by: rx.disposeBag)

        vm.detail.asDriver()
            .drive(detailLabel.rx.text)
            .disposed(by: rx.disposeBag)
        vm.detail.asDriver()
            .replaceNilWith("")
            .map { $0.isEmpty }
            .drive(detailLabel.rx.isHidden)
            .disposed(by: rx.disposeBag)

        vm.secondDetail.asDriver()
            .drive(secondDetailLabel.rx.text)
            .disposed(by: rx.disposeBag)
        vm.secondDetail.asDriver()
            .replaceNilWith("")
            .map { $0.isEmpty }
            .drive(secondDetailLabel.rx.isHidden)
            .disposed(by: rx.disposeBag)

        vm.attributedDetail.asDriver()
            .drive(attributedDetailLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        vm.attributedDetail.asDriver()
            .map { $0 == nil }
            .drive(attributedDetailLabel.rx.isHidden)
            .disposed(by: rx.disposeBag)

        vm.badge.asDriver()
            .drive(badgeImageView.rx.image)
            .disposed(by: rx.disposeBag)
        vm.badge
            .map { $0 == nil }
            .asDriver(onErrorJustReturn: true)
            .drive(badgeImageView.rx.isHidden)
            .disposed(by: rx.disposeBag)

        vm.badgeColor.asDriver()
            .drive(badgeImageView.rx.tintColor)
            .disposed(by: rx.disposeBag)

        vm.hideDisclosure.asDriver()
            .drive(rightImageView.rx.isHidden)
            .disposed(by: rx.disposeBag)

        vm.image.asDriver()
            .filterNil()
            .drive(leftImageView.rx.image)
            .disposed(by: rx.disposeBag)

        vm.imageUrl
            .map { $0?.url }
            .asDriver(onErrorJustReturn: nil)
            .filterNil()
            .drive(leftImageView.rx.imageURL)
            .disposed(by: rx.disposeBag)

        vm.imageUrl.asDriver()
            .filterNil()
            .drive(onNext: {[weak self] url in
                guard let `self` = self else { return }
                self.leftImageView.hero.id = url
            })
            .disposed(by: rx.disposeBag)
    }
}

// MARK: 🔐Private Actions
private extension XLEventCell {}

// MARK: - 🍺UI Prepare & Masonry
private extension XLEventCell {
    func prepareUI() {
        contentStackView.axis = .horizontal
        contentStackView.alignment = .center
        contentStackView.spacing = 8
        rightImageView.tintColor = .gray
        [titleLabel, detailLabel, secondDetailLabel, attributedDetailLabel].forEach(textsStackView.addArrangedSubview)
        [badgeImageView].forEach(leftImageView.addSubview)
        [leftImageView, textsStackView, rightImageView].forEach(contentStackView.addArrangedSubview)
        masonry()
    }
    func masonry() {
        contentStackView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
                .inset(UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
        }
        leftImageView.snp.makeConstraints({ (make) in
            make.size.equalTo(50)
        })
        badgeImageView.snp.makeConstraints({ (make) in
            make.bottom.left.equalTo(self.leftImageView)
            make.size.equalTo(20)
        })
        rightImageView.snp.makeConstraints({ (make) in
            make.width.equalTo(20)
        })
//        middleStackView.snp.makeConstraints {
//            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8))
//            $0.height.greaterThanOrEqualTo(40)
//        }
    }
}
