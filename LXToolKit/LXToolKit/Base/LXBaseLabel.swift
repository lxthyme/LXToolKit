//
//  LXBaseLabel.swift
//  AcknowList
//
//  Created by lxthyme on 2022/2/10.
//

import UIKit

open class LXBaseLabel: UILabel {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    public var textInsets = UIEdgeInsets.zero {
        didSet { invalidateIntrinsicContentSize() }
    }
    // MARK: 🛠Life Cycle
    required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    public override init(frame: CGRect) {
        super.init(frame: frame)

        basePrepareUI()
        baseMasonry()
    }
}

// MARK: 👀Public Actions
extension LXBaseLabel {
    open override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: textInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textInsets.top,
                                          left: -textInsets.left,
                                          bottom: -textInsets.bottom,
                                          right: -textInsets.right)
        return textRect.inset(by: invertedInsets)
    }

    open override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }

    public var leftTextInset: CGFloat {
        get { return textInsets.left }
        set { textInsets.left = newValue }
    }

    public var rightTextInset: CGFloat {
        get { return textInsets.right }
        set { textInsets.right = newValue }
    }

    public var topTextInset: CGFloat {
        get { return textInsets.top }
        set { textInsets.top = newValue }
    }

    public var bottomTextInset: CGFloat {
        get { return textInsets.bottom }
        set { textInsets.bottom = newValue }
    }
}

// MARK: 🔐Private Actions
private extension LXBaseLabel {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXBaseLabel {
    func basePrepareUI() {
        layer.masksToBounds = true

        // [<#table#>].forEach(self.addSubview)
    }

    func baseMasonry() {}
}
