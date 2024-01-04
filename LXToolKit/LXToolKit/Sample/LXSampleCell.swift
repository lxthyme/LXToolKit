//
//  LXSampleCell.swift
//  LXToolKit
//
//  Created by lxthyme on 2024/1/3.
//
import UIKit

struct LXSampleBackgroundConfiguration {
    static func configuration(for state: UICellConfigurationState) -> UIBackgroundConfiguration {
        var background = UIBackgroundConfiguration.clear()
        background.cornerRadius = 10
        if state.isHighlighted || state.isSelected {
            // Set nil to use the inherited tint color of the cell when highlighted or selected
            background.backgroundColor = nil

            if state.isHighlighted {
                // Reduce the alpha of the tint color to 30% when highlighted
                background.backgroundColorTransformer = .init { $0.withAlphaComponent(0.3) }
            }
        }
        return background
    }
}
public struct LXSampleContentConfiguration {
    var title: String?
    var content: String?
    var highlightColor: UIColor?
}
// MARK: - ✈️Hashable
extension LXSampleContentConfiguration: Hashable {}
// MARK: - ✈️UIContentConfiguration
extension LXSampleContentConfiguration: UIContentConfiguration {
    public func makeContentView() -> UIView & UIContentView {
        return LXSampleContentView(contentConfig: self)
    }

    public func updated(for state: UIConfigurationState) -> LXSampleContentConfiguration {
        guard let state = state as? UICellConfigurationState else { return self }
        var updatedConfig = self
        if state.isSelected || state.isHighlighted {
            updatedConfig.highlightColor = .cyan.withAlphaComponent(0.5)
        }
        return updatedConfig
    }
}

class LXSampleContentView: LXBaseView {
    // MARK: 📌UI
    private lazy var tvContent: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.textColor = .black
        tv.backgroundColor = .clear
        tv.textAlignment = .left
        tv.returnKeyType = .done
        tv.keyboardType = .default
        // tv.textContainer.maximumNumberOfLines = 0
        // tv.textContainer.lineBreakMode = .byTruncatingTail
        // tv.contentInset = .zero
        // let padding = tv.textContainer.lineFragmentPadding
        // tv.textContainerInset = UIEdgeInsets(top: 0, left: -padding, bottom: 0, right: -padding)
        return tv
    }()
    private lazy var labTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        // label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    // MARK: 🔗Vaiables
    private var appliedConfiguration: LXSampleContentConfiguration!
    // MARK: 🛠Life Cycle
    convenience init(contentConfig: LXSampleContentConfiguration) {
        self.init(frame: .zero)
        prepareUI()
        apply(configuration: contentConfig)
    }
}
// MARK: 🌎LoadData
extension LXSampleContentView {
    private func apply(configuration: LXSampleContentConfiguration) {
        guard appliedConfiguration != configuration else { return }
        appliedConfiguration = configuration

        labTitle.text = configuration.title
        tvContent.text = configuration.content
        backgroundColor = configuration.highlightColor
    }
}
// MARK: - ✈️UIContentView
extension LXSampleContentView: UIContentView {
    var configuration: UIContentConfiguration {
        get { appliedConfiguration }
        set {
            guard let newConfig = newValue as? LXSampleContentConfiguration else { return }
            apply(configuration: newConfig)
        }
    }
}
// MARK: - 🍺UI Prepare & Masonry
private extension LXSampleContentView {
    func prepareUI() {
        // self.backgroundColor = .white

        [labTitle, tvContent].forEach(self.addSubview)
        masonry()
    }
    func masonry() {
        labTitle.snp.makeConstraints {
            $0.top.left.equalToSuperview()
            $0.right.lessThanOrEqualToSuperview()
        }
        tvContent.snp.makeConstraints {
            $0.top.equalTo(labTitle.snp.bottom).offset(10)
            $0.left.equalToSuperview()
            $0.right.lessThanOrEqualToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
class LXSampleCell: LXBaseCollectionCell {
    // MARK: 📌UI
    // required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    // MARK: 🔗Vaiables
    var item: LXSampleItem? {
        didSet {
            setNeedsUpdateConfiguration()
        }
    }
    // MARK: 🛠Life Cycle
    override func updateConfiguration(using state: UICellConfigurationState) {
        backgroundConfiguration = LXSampleBackgroundConfiguration.configuration(for: state)

        var content = LXSampleContentConfiguration().updated(for: state)
        content.title = item?.title
        content.content = item?.content
        if state.isSelected || state.isHighlighted {
            content.highlightColor = .cyan.withAlphaComponent(0.5)
        }
        contentConfiguration = content
    }
}
