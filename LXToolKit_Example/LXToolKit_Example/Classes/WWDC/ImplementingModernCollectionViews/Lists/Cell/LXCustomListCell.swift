//
//  LXCustomListCell.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/8/11.
//
import UIKit
import SnapKit

// MARK: - 🔐
@available(iOS 14.0, *)
fileprivate extension UIConfigurationStateCustomKey {
    static let item = UIConfigurationStateCustomKey("com.apple.ItemListCell.item")
}

// MARK: - 🔐
@available(iOS 14.0, *)
private extension UICellConfigurationState {
    var item: LXCustomCellListVC.Item? {
        set { self[.item] = newValue }
        get { return self[.item] as? LXCustomCellListVC.Item }
    }
}

@available(iOS 14.0, *)
class LXItemListCell: UICollectionViewListCell {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    private var item: LXCustomCellListVC.Item? = nil
    // MARK: 🛠Life Cycle
    override var configurationState: UICellConfigurationState {
        var state = super.configurationState
        state.item = self.item
        return state
    }

    func updateWithItem(_ newItem: LXCustomCellListVC.Item) {
        guard item != newItem else { return }
        item = newItem
        setNeedsUpdateConfiguration()
    }
}

@available(iOS 14.0, *)
class LXCustomListCell: LXItemListCell {
    // MARK: 📌UI
    private lazy var imgViewCategory: UIImageView = {
        let iv = UIImageView()
        // iv.image = UIImage(named: <#T##String#>)
        // iv.backgroundColor = .dm_f4f4f6Color
        // iv.contentMode = .scaleAspectFit
        return iv
    }()
    private lazy var labCategory: UILabel = {
        let label = UILabel()
        // label.text = ""
        // label.font = <#.systemFont(ofSize: 14)#>
        // label.textColor = <#.black#>
        // label.numberOfLines = 0
        // label.lineBreakMode = .byTruncatingTail
        // label.textAlignment = <#.center#>
        return label
    }()
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    // MARK: 🔗Vaiables
    private var labCategoryLeading: Constraint?
    private var labCategoryTrailing: Constraint?
    private var imgViewCategoryTrailing: Constraint?
    private lazy var listContentView = UIListContentView(configuration: defaultListContentConfiguration())
    // MARK: 🛠Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)

        prepareUI()
    }
    // open override func prepareForReuse() {
    //     super.prepareForReuse()
    // }
    override func updateConfiguration(using state: UICellConfigurationState) {
        // Configure the list content configuration and apply that to the list content view.
        var content = defaultListContentConfiguration().updated(for: state)
        content.imageProperties.preferredSymbolConfiguration = .init(font: content.textProperties.font, scale: .large)
        content.image = state.item?.image
        content.text = state.item?.title
        content.secondaryText = state.item?.description
        content.axesPreservingSuperviewLayoutMargins = []
        listContentView.configuration = content

        // Get the list value cell configuration for the current state, which we'll use to obtain the system default
        // styling and metrics to copy to our custom views.
        let valueConfig = UIListContentConfiguration.valueCell().updated(for: state)

        // Configure custom image view for the category icon, copying some of the styling from the value cell configuration.
        imgViewCategory.image = state.item?.category.icon
        imgViewCategory.tintColor = valueConfig.imageProperties.resolvedTintColor(for: tintColor)
        imgViewCategory.preferredSymbolConfiguration = .init(font: valueConfig.secondaryTextProperties.font, scale: .small)

        // Configure custom label for the category name, copying some of the styling from the value cell configuration.
        labCategory.text = state.item?.category.name
        labCategory.textColor = valueConfig.secondaryTextProperties.resolvedColor()
        labCategory.font = valueConfig.secondaryTextProperties.font
        labCategory.adjustsFontForContentSizeCategory = valueConfig.secondaryTextProperties.adjustsFontForContentSizeCategory

        // Update some of the constraints for our custom views using the system default metrics from the configurations.
        labCategoryLeading?.update(offset: content.directionalLayoutMargins.trailing)
        labCategoryTrailing?.update(offset: content.textToSecondaryTextHorizontalPadding)
        imgViewCategoryTrailing?.update(offset: -content.directionalLayoutMargins.trailing)
    }
}

// MARK: 👀Public Actions
@available(iOS 14.0, *)
extension LXCustomListCell {}

// MARK: 🔐Private Actions
@available(iOS 14.0, *)
private extension LXCustomListCell {
    func defaultListContentConfiguration() -> UIListContentConfiguration {
        return .subtitleCell()
    }
}

// MARK: - 🍺UI Prepare & Masonry
@available(iOS 14.0, *)
private extension LXCustomListCell {
    func prepareUI() {
        // self.contentView.backgroundColor = .white

        [listContentView, labCategory, imgViewCategory].forEach(self.contentView.addSubview)

        masonry()
    }

    func masonry() {
        listContentView.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
        }
        labCategory.snp.makeConstraints {
            labCategoryLeading = $0.leading.greaterThanOrEqualTo(listContentView.snp.trailing).constraint
            $0.centerY.equalToSuperview()
        }
        imgViewCategory.snp.makeConstraints {
            labCategoryTrailing = $0.leading.equalTo(labCategory.snp.trailing).constraint
            imgViewCategoryTrailing = $0.trailing.equalToSuperview().constraint
            $0.centerY.equalToSuperview()
        }
    }
}
