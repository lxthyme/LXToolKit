//
//  LXBGNestedGroupDecorationView.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/11/13.
//
import UIKit

open class LXBGNestedGroupDecorationView: UICollectionReusableView {
    // MARK: 📌UI
    required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    // MARK: 🔗Vaiables
    override public init(frame: CGRect) {
        super.init(frame: frame)

        prepareUI()
    }
}

// MARK: 👀Public Actions
extension LXBGNestedGroupDecorationView {}

// MARK: 🔐Private Actions
private extension LXBGNestedGroupDecorationView {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXBGNestedGroupDecorationView {
    func prepareUI() {
        self.backgroundColor = .lightGray.withAlphaComponent(0.5)
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 12

        // [<#table#>].forEach(self.addSubview)

        masonry()
    }

    func masonry() { }
}
