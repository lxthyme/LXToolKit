//
//  LXSectionBgDecorationView.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/8/10.
//
import UIKit

class LXSectionBgDecorationView: UICollectionReusableView {
    // MARK: 📌UI
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    // MARK: 🔗Vaiables
    override init(frame: CGRect) {
        super.init(frame: frame)

        prepareUI()
    }
}

// MARK: 👀Public Actions
extension LXSectionBgDecorationView {}

// MARK: 🔐Private Actions
private extension LXSectionBgDecorationView {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXSectionBgDecorationView {
    func prepareUI() {
        self.backgroundColor = .lightGray.withAlphaComponent(0.5)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 12
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1

        // [<#table#>].forEach(self.addSubview)

        masonry()
    }

    func masonry() { }
}
