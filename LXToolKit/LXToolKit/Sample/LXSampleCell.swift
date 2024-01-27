//
//  LXSampleCell.swift
//  LXToolKit
//
//  Created by lxthyme on 2024/1/3.
//
import UIKit

@available(iOS 14.0, *)
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
public struct LXSampleItem {
    public var title: String?
    public var content: String?
    public var highlightColor: UIColor?

    public init(title: String? = nil, content: String? = nil) {
        self.title = title
        self.content = content
    }
}
// MARK: - ✈️Hashable
extension LXSampleItem: Hashable {}
// MARK: - ✈️UIContentConfiguration
@available(iOS 14.0, *)
extension LXSampleItem: UIContentConfiguration {
    public func makeContentView() -> UIView & UIContentView {
        return LXSampleContentView(contentConfig: self)
    }
    public func updated(for state: UIConfigurationState) -> LXSampleItem {
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
        tv.showsHorizontalScrollIndicator = false
        tv.showsVerticalScrollIndicator = false
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
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    // MARK: 🔗Vaiables
    private var appliedConfiguration: LXSampleItem!
    // MARK: 🛠Life Cycle
    convenience init(contentConfig: LXSampleItem) {
        self.init(frame: .zero)
        prepareUI()
        apply(configuration: contentConfig)
    }
}
// MARK: 🌎LoadData
extension LXSampleContentView {
    private func apply(configuration: LXSampleItem) {
        guard appliedConfiguration != configuration else { return }
        appliedConfiguration = configuration

        labTitle.text = configuration.title
        tvContent.attributedText = makeAttribute(from: configuration.content)
        backgroundColor = configuration.highlightColor
    }
}
// MARK: - ✈️UIContentView
@available(iOS 14.0, *)
extension LXSampleContentView: UIContentView {
    var configuration: UIContentConfiguration {
        get { appliedConfiguration }
        set {
            guard let newConfig = newValue as? LXSampleItem else { return }
            apply(configuration: newConfig)
        }
    }
}

// MARK: - 🔐
private extension LXSampleContentView {
    func makeAttribute(from info: String?) -> NSAttributedString? {
        guard let info else { return nil }
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.systemFont(ofSize: 14)
        ]
        let contentAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.boldSystemFont(ofSize: 16)
        ]
        let commonAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.cyan,
            .font: UIFont.boldSystemFont(ofSize: 14)
        ]
        let attr = NSMutableAttributedString()
        info.components(separatedBy: "\n")
            .forEach { item in
                let tmp = item.components(separatedBy: ":")
                if tmp.count >= 2 {
                    let title = tmp.first?.trimmed ?? ""
                    let content = tmp[1...].joined(separator: ":")
                    let itemAttr = NSMutableAttributedString()
                    itemAttr.append(NSAttributedString(string: "\(title): ", attributes: titleAttributes))
                    itemAttr.append(NSAttributedString(string: content, attributes: contentAttributes))
                    attr.append(itemAttr)
                } else {
                    attr.append(NSAttributedString(string: item, attributes: commonAttributes))
                }
                attr.append(NSAttributedString(string: "\n"))
            }
        return attr
    }
}
// MARK: - 🍺UI Prepare & Masonry
private extension LXSampleContentView {
    func prepareUI() {
        // self.backgroundColor = .white

        [labTitle, tvContent].forEach(self.addSubview)
        labTitle.xl.setVerticalHuggingAndCompressionResistance()
        tvContent.xl.setVerticalHuggingAndCompressionResistance()
        masonry()
    }
    func masonry() {
        labTitle.snp.makeConstraints {
            $0.top.left.equalToSuperview()
            $0.right.lessThanOrEqualToSuperview()
        }
        tvContent.snp.makeConstraints {
            $0.top.equalTo(labTitle.snp.bottom)//.offset(10)
            $0.left.equalToSuperview()
            $0.right.lessThanOrEqualToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
@available(iOS 14.0, *)
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

        var content = LXSampleItem().updated(for: state)
        content.title = item?.title
        content.content = item?.content
        if state.isSelected || state.isHighlighted {
            content.highlightColor = .cyan.withAlphaComponent(0.5)
        }
        contentConfiguration = content
    }
}
