//
//  LXBaseLabel.swift
//  test
//
//  Created by lxthyme on 2023/3/25.
//
import UIKit

class LXBaseLabel: UILabel {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    var textInsets = UIEdgeInsets.zero {
        didSet { invalidateIntrinsicContentSize() }
    }
    // MARK: 🛠Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }

    func makeUI() {
        layer.masksToBounds = true
        numberOfLines = 1
//        cornerRadius = Configs.BaseDimensions.cornerRadius
        updateUI()
    }

    func updateUI() {
        setNeedsDisplay()
    }

}

// MARK: 👀Public Actions
extension LXBaseLabel {
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: textInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textInsets.top,
                                          left: -textInsets.left,
                                          bottom: -textInsets.bottom,
                                          right: -textInsets.right)
        return textRect.inset(by: invertedInsets)
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }

    var leftTextInset: CGFloat {
        get { return textInsets.left }
        set { textInsets.left = newValue }
    }

    var rightTextInset: CGFloat {
        get { return textInsets.right }
        set { textInsets.right = newValue }
    }

    var topTextInset: CGFloat {
        get { return textInsets.top }
        set { textInsets.top = newValue }
    }

    var bottomTextInset: CGFloat {
        get { return textInsets.bottom }
        set { textInsets.bottom = newValue }
    }
}
