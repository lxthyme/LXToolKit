//
//  DJRepositoryCell.swift
//  test
//
//  Created by lxthyme on 2023/3/27.
//
import UIKit

class DJRepositoryCell: DJSearchDefaultCell {
    // MARK: 📌UI
    lazy var starButton: UIButton = {
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
extension DJRepositoryCell {
    override open func bind(to vm: LXBaseTableCellVM) {
        super.bind(to: vm)
        guard let vm = vm as? DJRepositoryCellVM else { return }

        vm.hidesStarButton.asDriver()
            .drive(starButton.rx.isHidden)
            .disposed(by: rx.disposeBag)
        vm.starring.asDriver()
            .map { starred -> UIImage? in
                let image = starred ? R.image.icon_button_unstar() : R.image.icon_button_star()
                return image?.template
            }
            .drive(starButton.rx.image())
            .disposed(by: rx.disposeBag)
        vm.starring
            .map { $0 ? 1.0 : 0.6 }
            .asDriver(onErrorJustReturn: 0)
            .drive(starButton.rx.alpha)
            .disposed(by: rx.disposeBag)
    }
}

// MARK: 👀Public Actions
extension DJRepositoryCell {}

// MARK: 🔐Private Actions
private extension DJRepositoryCell {}

// MARK: - 🍺UI Prepare & Masonry
private extension DJRepositoryCell {
    func prepareUI() {
        // self.contentView.backgroundColor = .white

        wrapperStackView.insertArrangedSubview(starButton, at: 2)
        // [<#table#>].forEach(self.contentView.addSubview)

        masonry()
    }

    func masonry() {}
}
