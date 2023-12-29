//
//  LXHMSegmentedControl.swift
//  test
//
//  Created by lxthyme on 2023/3/27.
//
import UIKit
import HMSegmentedControl
import RxRelay

open class LXHMSegmentedControl: HMSegmentedControl {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    // var inset: CGFloat = AppConfig.BaseDimensions.inset
    public var inset: CGFloat = 6
    public let segmentSelection = BehaviorRelay<Int>(value: 0)
    // MARK: 🛠Life Cycle
}

// MARK: 👀Public Actions
extension LXHMSegmentedControl {}

// MARK: 🔐Private Actions
private extension LXHMSegmentedControl {}

// MARK: - 🍺UI Prepare & Masonry
extension LXHMSegmentedControl {
    public func prepareVM() {
        // themeService.typeStream.subscribe(onNext: { [weak self] (themeType) in
        //     let theme = themeType.associatedObject
        //     self?.backgroundColor = theme.primary
        //     self?.selectionIndicatorColor = theme.secondary
        //     let font = UIFont.systemFont(ofSize: 11)
        //     self?.titleTextAttributes = [NSAttributedString.Key.font: font,
        //                                  NSAttributedString.Key.foregroundColor: theme.text]
        //     self?.selectedTitleTextAttributes = [NSAttributedString.Key.font: font,
        //                                          NSAttributedString.Key.foregroundColor: theme.secondary]
        //     self?.setNeedsDisplay()
        // }).disposed(by: rx.disposeBag)

        // cornerRadius = AppConfig.BaseDimensions.cornerRadius
        imagePosition = .aboveText
        selectionStyle = .box
        selectionIndicatorLocation = .bottom
        selectionIndicatorBoxOpacity = 0
        selectionIndicatorHeight = 2.0
        segmentEdgeInset = UIEdgeInsets(inset: self.inset)
        indexChangeBlock = { [weak self] index in
            self?.segmentSelection.accept(Int(index))
        }
    }
    func prepareUI() {
        // self.backgroundColor = UIColor.white
        // self.title = "<#title#>"

        // [<#table#>].forEach(self.addSubview)

        masonry()
    }

    func masonry() {}
}
