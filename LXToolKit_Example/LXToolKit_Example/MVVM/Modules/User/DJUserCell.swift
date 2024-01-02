//
//  DJUserCell.swift
//  test
//
//  Created by lxthyme on 2023/3/27.
//
import UIKit

class DJUserCell: DJSearchDefaultCell {
    // MARK: 📌UI
    lazy var followButton: UIButton = {
        let view = UIButton()
        view.layerBorderColor = .white
        view.layerBorderWidth = AppConfig.BaseDimensions.borderWidth
        view.tintColor = .white
        view.layerCornerRadius = 17
        view.snp.remakeConstraints({ (make) in
            make.size.equalTo(34)
        })
        return view
    }()
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        prepareUI()
        // prepareVM()
    }
}

// MARK: 🌎LoadData
extension DJUserCell {
    override open func bind(to vm: LXBaseTableCellVM) {
        super.bind(to: vm)

        guard let vm = vm as? DJUserCellVM else { return }

        vm.hidesFollowButton.asDriver()
            .drive(followButton.rx.isHidden)
            .disposed(by: rx.disposeBag)
        vm.following.asDriver()
            .map { (followed) -> UIImage? in
                let image = followed ? R.image.icon_button_user_x() : R.image.icon_button_user_plus()
                return image?.template
            }
            .drive(followButton.rx.image())
            .disposed(by: rx.disposeBag)
        vm.following
            .map { $0 ? 1.0: 0.6 }
            .asDriver(onErrorJustReturn: 0)
            .drive(followButton.rx.alpha)
            .disposed(by: rx.disposeBag)
    }
}

// MARK: 👀Public Actions
extension DJUserCell {}

// MARK: 🔐Private Actions
private extension DJUserCell {}

private extension DJUserCell {
    // MARK: - 🍺UI Prepare & Masonry
    func prepareUI() {
        // self.contentView.backgroundColor = .white

        wrapperStackView.insertArrangedSubview(followButton, at: 2)
        // [<#table#>].forEach(self.contentView.addSubview)

        masonry()
    }

    func masonry() {}
}
