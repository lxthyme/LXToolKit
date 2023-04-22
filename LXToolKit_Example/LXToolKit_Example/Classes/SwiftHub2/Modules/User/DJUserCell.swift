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
        view.borderColor = .white
        view.borderWidth = AppConfig.BaseDimensions.borderWidth
        view.tintColor = .white
        view.cornerRadius = 17
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
        prepareVM()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    open override func prepareForReuse() {
        super.prepareForReuse()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

// MARK: 🌎LoadData
extension DJUserCell {
    override func bind(to vm: LXBaseTableViewCellVM) {
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

// MARK: - 🍺UI Prepare & Masonry
extension DJUserCell {
    override func prepareUI() {
        super.prepareUI()
        // self.contentView.backgroundColor = .white

        containerStackView.insertArrangedSubview(followButton, at: 2)
        // [<#table#>].forEach(self.contentView.addSubview)

        masonry()
    }

    override func masonry() {
        super.masonry()
    }
}
