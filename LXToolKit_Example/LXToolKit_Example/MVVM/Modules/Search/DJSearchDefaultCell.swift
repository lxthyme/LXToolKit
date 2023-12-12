//
//  DJSearchDefaultCell.swift
//  test
//
//  Created by lxthyme on 2023/3/27.
//
import UIKit

class DJSearchDefaultCell: LXBaseTableViewCell {
    // MARK: 📌UI
    lazy var leftImageView: UIImageView = {
        let view = UIImageView(frame: CGRect())
        view.contentMode = .scaleAspectFit
        view.layerCornerRadius = 25
        return view
    }()

    lazy var badgeImageView: UIImageView = {
        let view = UIImageView(frame: CGRect())
        view.contentMode = .center
        view.backgroundColor = .white
        view.layerCornerRadius = 10
        view.layerBorderColor = .white
        view.layerBorderWidth = 1
        wrapperView.addSubview(view)
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
        view.numberOfLines = 0
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
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 2
        return view
    }()

    lazy var rightImageView: UIImageView = {
        let view = UIImageView(frame: CGRect())
        view.contentMode = .center
        view.image = R.image.icon_cell_disclosure()?.template
        return view
    }()
    // MARK: 🔗Vaiables
    // var inset: CGFloat = AppConfig.BaseDimensions.inset
    public var inset: CGFloat = 6
    // MARK: 🛠Life Cycle
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // prepareUI()
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
extension DJSearchDefaultCell {
    override open func bind(to vm: LXBaseTableViewCellVM) {
        super.bind(to: vm)
        guard let vm = vm as? DJSearchDefaultCellVM  else { return }

        vm.title.asDriver()
            .drive(titleLabel.rx.text)
            .disposed(by: rx.disposeBag)
        vm.title.asDriver()
            .replaceNilWith("")
            .map { $0.isEmpty }
            .drive(titleLabel.rx.isHidden)
            .disposed(by: rx.disposeBag)

        vm.detail.asDriver().drive(detailLabel.rx.text).disposed(by: rx.disposeBag)
        vm.detail.asDriver().replaceNilWith("").map { $0.isEmpty }.drive(detailLabel.rx.isHidden).disposed(by: rx.disposeBag)

        vm.secondDetail.asDriver().drive(secondDetailLabel.rx.text).disposed(by: rx.disposeBag)
        vm.secondDetail.asDriver().replaceNilWith("").map { $0.isEmpty }.drive(secondDetailLabel.rx.isHidden).disposed(by: rx.disposeBag)

        vm.attributedDetail.asDriver().drive(attributedDetailLabel.rx.attributedText).disposed(by: rx.disposeBag)
        vm.attributedDetail.asDriver().map { $0 == nil }.drive(attributedDetailLabel.rx.isHidden).disposed(by: rx.disposeBag)

        vm.badge.asDriver().drive(badgeImageView.rx.image).disposed(by: rx.disposeBag)
        vm.badge.map { $0 == nil }.asDriver(onErrorJustReturn: true).drive(badgeImageView.rx.isHidden).disposed(by: rx.disposeBag)

        vm.badgeColor.asDriver().drive(badgeImageView.rx.tintColor).disposed(by: rx.disposeBag)

        vm.hidesDisclosure.asDriver().drive(rightImageView.rx.isHidden).disposed(by: rx.disposeBag)

        vm.image.asDriver().filterNil()
            .drive(leftImageView.rx.image).disposed(by: rx.disposeBag)

        vm.imageUrl.map { $0?.url }.asDriver(onErrorJustReturn: nil).filterNil()
            .drive(leftImageView.rx.imageURL).disposed(by: rx.disposeBag)

        vm.imageUrl.asDriver().filterNil()
            .drive(onNext: { [weak self] (url) in
                self?.leftImageView.hero.id = url
            }).disposed(by: rx.disposeBag)
    }
}

// MARK: 👀Public Actions
extension DJSearchDefaultCell {}

// MARK: 🔐Private Actions
private extension DJSearchDefaultCell {}

private extension DJSearchDefaultCell {
    // MARK: - 🍺UI Prepare & Masonry
    func prepareVM() {
        titleLabel.theme.textColor = themeService.attribute { $0.text }
        detailLabel.theme.textColor = themeService.attribute { $0.textGray }
        secondDetailLabel.theme.textColor = themeService.attribute { $0.text }
        leftImageView.theme.tintColor = themeService.attribute { $0.secondary }
        rightImageView.theme.tintColor = themeService.attribute { $0.secondary }
    }
    func prepareUI() {
        self.contentView.backgroundColor = .clear

        wrapperStackView.spacing = self.inset
        [titleLabel, detailLabel, secondDetailLabel, self.attributedDetailLabel].forEach(textsStackView.addArrangedSubview)
        [leftImageView, textsStackView, rightImageView].forEach(wrapperStackView.addArrangedSubview)
        wrapperView.addSubview(wrapperStackView)

        // masonry()

        detailLabel.xl.setPriority(UILayoutPriority.defaultLow, for: NSLayoutConstraint.Axis.vertical)
    }

    func masonry() {
        wrapperStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: self.inset / 2, left: self.inset, bottom: self.inset / 2, right: self.inset))
            $0.height.greaterThanOrEqualTo(AppConfig.BaseDimensions.tableRowHeight)
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
    }
}
