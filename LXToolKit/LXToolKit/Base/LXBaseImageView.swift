//
//  LXBaseImageView.swift
//  LXToolKit
//
//  Created by lxthyme on 2022/3/2.
//

import UIKit
import Hero

open class LXBaseImageView: UIImageView {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    // required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override public init(frame: CGRect) {
        super.init(frame: frame)

        basePrepareUI()
        baseMasonry()
    }

    override public init(image: UIImage?) {
        super.init(image: image)
        basePrepareUI()
        baseMasonry()
    }

    override public init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        basePrepareUI()
        baseMasonry()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        basePrepareUI()
        baseMasonry()
    }
}

// MARK: 👀Public Actions
extension LXBaseImageView {}

// MARK: 🔐Private Actions
private extension LXBaseImageView {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXBaseImageView {
    func basePrepareUI() {
        layer.masksToBounds = true
        contentMode = .scaleAspectFit
        hero.modifiers = [.arc]
    }

    func baseMasonry() {}
}
