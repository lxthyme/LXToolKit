//
//  LXSegmentedControl.swift
//  LXToolKit_Exam
//
//  Created by lxthyme on 2022/2/18.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import HMSegmentedControl

open class LXSegmentedControl: HMSegmentedControl {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    let segmentSelection = BehaviorRelay<Int>(value: 0)
    // MARK: 🛠Life Cycle
    required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(sectionTitles sectiontitles: [String]) {
        super.init(sectionTitles: sectiontitles)

        prepareUI()
        updateUI()
    }
    func updateUI() {
        setNeedsDisplay()
    }

}

// MARK: 👀Public Actions
extension LXSegmentedControl {}

// MARK: 🔐Private Actions
private extension LXSegmentedControl {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXSegmentedControl {
    func prepareUI() {
        self.backgroundColor = UIColor.white
        themeService.typeStream
            .subscribe(onNext: {[weak self] themeType in
                guard let `self` = self else { return }
                let theme = themeType.associatedObject
                self.backgroundColor = theme.primary
                self.selectionIndicatorColor = theme.secondary
                let font = UIFont.systemFont(ofSize: 11)
                self.titleTextAttributes = [
                    NSAttributedString.Key.font: font,
                    NSAttributedString.Key.foregroundColor: theme.text
                ]
                self.selectedTitleTextAttributes = [
                    NSAttributedString.Key.font: font,
                    NSAttributedString.Key.foregroundColor: theme.secondary
                ]
                self.setNeedsDisplay()
            })
            .disposed(by: rx.disposeBag)

        cornerRadius = Configs.BaseDimensions.cornerRadius
        imagePosition = .aboveText
        selectionStyle = .box
        selectionIndicatorLocation = .bottom
        selectionIndicatorBoxOpacity = 0
        selectionIndicatorHeight = 2
        segmentEdgeInset = UIEdgeInsets(inset: Configs.BaseDimensions.inset)
        indexChangeBlock = {[weak self] idx in
            self?.segmentSelection.accept(Int(idx))
        }

        // [<#table#>].forEach(self.addSubview)

        masonry()
    }

    func masonry() {
        self.snp.makeConstraints {
            $0.height.equalTo(Configs.BaseDimensions.segmentedControlHeight)
        }
    }
}
