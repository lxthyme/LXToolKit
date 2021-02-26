//
//  String + boundingRect.swift
//  LXToolKit
//
//  Created by LXThyme Jason on 2021/1/16.
//

import Foundation

public extension Swifty where Base == String {
    func boundingRect(font: UIFont, limitSize: CGSize) -> CGSize {
        let style = NSMutableParagraphStyle()
        style.lineBreakMode = .byWordWrapping

        let att = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.paragraphStyle: style
        ]

        let attContent = NSMutableAttributedString(string: base, attributes: att)

        let size = attContent
            .boundingRect(with: limitSize,
                          options: [.usesLineFragmentOrigin, .usesFontLeading],
                          context: nil)
            .size

        return CGSize(width: ceil(size.width), height: ceil(size.height))
    }
}
