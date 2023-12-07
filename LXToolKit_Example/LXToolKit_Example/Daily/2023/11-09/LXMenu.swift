//
//  LXMenu.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/11/10.
//
import UIKit

class LXMenu: UIControl {
    // MARK: 📌UI
    private lazy var labTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        // label.font = <#.systemFont(ofSize: 14)#>
        label.textColor = self.tintColor
        label.highlightedTextColor = .secondaryLabel
        // label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    // MARK: 🔗Vaiables
    var items: [UIAction] = [] {
        didSet {
            if items.isEmpty {
                self.contextMenuInteraction?.dismissMenu()
                self.isContextMenuInteractionEnabled = false
            } else {
                self.updateMenuIfVisible()
                self.isContextMenuInteractionEnabled = true
            }
        }
    }
    var menu: UIMenu {
        let selectedAction: UIAction?
        if showSelectedItem,
           selectedIndex >= 0,
           selectedIndex < items.count {
            selectedAction = items[selectedIndex]
        } else {
            selectedAction = nil
        }
        return UIMenu(title: "", children: items.map{ proxyAction($0, selected: $0 == selectedAction) })
    }
    var selectedIndex: Int = -1 {
        didSet {
            self.updateMenuIfVisible()
        }
    }
    var showSelectedItem: Bool = true {
        didSet {
            self.updateMenuIfVisible()
        }
    }
    override var isHighlighted: Bool {
        didSet {
            self.labTitle.isHighlighted = self.isHighlighted
        }
    }
    // MARK: 🛠Life Cycle
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(frame: CGRect) {
        super.init(frame: frame)

        prepareUI()
    }
    convenience init(frame: CGRect, primaryAction: UIAction?) {
        self.init(frame: frame)
        if let primaryAction {
            self.addAction(primaryAction, for: .primaryActionTriggered)
            self.labTitle.text = primaryAction.title
        }
    }
    override func tintColorDidChange() {
        super.tintColorDidChange()
        labTitle.textColor = self.tintColor
    }
    override func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { [unowned self] _ in
            return self.menu
        }
    }
    override func contextMenuInteraction(_ interaction: UIContextMenuInteraction, previewForHighlightingMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        return previewForMenuPresentation()
    }
    override func contextMenuInteraction(_ interaction: UIContextMenuInteraction, previewForDismissingMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        return previewForMenuPresentation()
    }
    override func contextMenuInteraction(_ interaction: UIContextMenuInteraction, willDisplayMenuFor configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) {
        super.contextMenuInteraction(interaction, willDisplayMenuFor: configuration, animator: animator)
        animateBackgroundHighlight(animator, highlighted: true)
    }
    override func contextMenuInteraction(_ interaction: UIContextMenuInteraction, willEndFor configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) {
        super.contextMenuInteraction(interaction, willEndFor: configuration, animator: animator)
        animateBackgroundHighlight(animator, highlighted: false)
    }
}

// MARK: 👀Public Actions
extension LXMenu {
    func updateMenuIfVisible() {
        // self.contextMenuInteraction?.updateVisibleMenu {[unowned self] _ in
        //     return self.menu
        // }
    }
    func configureBackground(highlighted: Bool) {
        self.backgroundColor = highlighted ? .systemGray2 : .systemGray5
        self.layer.cornerRadius = highlighted ? 8 : 16
        self.layer.cornerCurve = .continuous
    }
    func proxyAction(_ action: UIAction, selected: Bool) -> UIAction {
        let proxy = UIAction(title: action.title,
                             image: action.image,
                             discoverabilityTitle: action.discoverabilityTitle,
                             attributes: action.attributes,
                             state: selected ? .on : .off) { proxy in
            guard let control = proxy.sender as? LXMenu else { return }
            control.selectedIndex = control.items.firstIndex(of: action) ?? -1
            control.sendAction(action)
            control.sendActions(for: .primaryActionTriggered)
        }
        return proxy
    }
    func previewForMenuPresentation() -> UITargetedPreview {
        let previewTarget = UIPreviewTarget(container: labTitle, center: labTitle.center)
        let previewParameters = UIPreviewParameters()
        previewParameters.backgroundColor = .clear
        return UITargetedPreview(view: UIView(frame: labTitle.frame), parameters: previewParameters, target: previewTarget)
    }
    func animateBackgroundHighlight(_ animator: UIContextMenuInteractionAnimating?, highlighted: Bool) {
        if let animator {
            animator.addAnimations {
                self.configureBackground(highlighted: highlighted)
            }
        } else {
            configureBackground(highlighted: highlighted)
        }
    }
}

// MARK: 🔐Private Actions
private extension LXMenu {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXMenu {
    func prepareUI() {
        // self.backgroundColor = UIColor.white
        // self.title = "<#title#>"
        self.showsMenuAsPrimaryAction = true
        configureBackground(highlighted: false)

        [labTitle].forEach(self.addSubview)

        masonry()
    }

    func masonry() {
        labTitle.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
