//
//  LXBaseButton.swift
//  LXToolKit
//
//  Created by lxthyme on 2022/2/24.
//

import UIKit

class LXBaseButton: UIButton {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    /// 扩大按钮点击区域
    var expandInset: CGFloat = 0
    // MARK: 🛠Life Cycle
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(frame: CGRect) {
        super.init(frame: frame)

        prepareUI()
    }
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let expandRect = self.bounds.insetBy(dx: -self.expandInset, dy: -self.expandInset)
        if expandRect.contains(point) {
            return self
        }
        return super.hitTest(point, with: event)
    }
}

// MARK: 👀Public Actions
extension LXBaseButton {}

// MARK: 🔐Private Actions
private extension LXBaseButton {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXBaseButton {
    func prepareUI() {

        // [<#table#>].forEach(self.addSubview)

        masonry()
    }

    func masonry() {}
}
