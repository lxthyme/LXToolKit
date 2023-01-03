//
//  UIView + ex.swift
//  Vaffle_demo
//
//  Created by LXThyme on 2018/11/19.
//  Copyright © 2018 DamonJow. All rights reserved.
//
import UIKit
import Foundation

public extension Swifty where Base: UIView {
    var safeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return self.base.safeAreaInsets
        } else {
            return .zero
        }
    }
    var safeAreaLayoutGuide: UILayoutGuide {
        if #available(iOS 11.0, *) {
            return self.base.safeAreaLayoutGuide
        } else {
            return UILayoutGuide()
        }
    }

    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(self.base.addSubview)
    }
}

// MARK: - 👀
public extension Swifty where Base: UIView {
    /// 设置圆角
    ///
    /// - Parameters:
    ///   - borderColor: 边框颜色
    ///   - borderWidth: 边框宽
    ///   - raddi: 弧度
    ///   - corners: 圆角位置
    ///   - isDotted: 是否虚线边框
    func setRoundingCorners(borderColor: UIColor,
                            borderWidth: CGFloat = 1.0,
                            raddi: CGFloat = 4.0,
                            corners: UIRectCorner = [.topLeft, .bottomRight],
                            isDotted: Bool = false) {

        let path = UIBezierPath(roundedRect: base.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: raddi, height: raddi))
        // 圆角
        let maskLayer = CAShapeLayer()
        maskLayer.frame = base.bounds
        maskLayer.path = path.cgPath
        base.layer.mask = maskLayer

        // 边框
        let borderLayer = CAShapeLayer()
        borderLayer.frame = base.bounds
        borderLayer.path = path.cgPath
        borderLayer.lineWidth = borderWidth
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        if isDotted {
            borderLayer.lineDashPattern = [NSNumber(value: 4), NSNumber(value: 2)]
        }
        base.layer.addSublayer(borderLayer)
    }
}

// MARK: - 👀
public extension Swifty where Base: UIView {
    @discardableResult func addBorders(edges: UIRectEdge, color: UIColor, thickness: CGFloat = 1.0) -> [UIView] {
        var borders = [UIView]()

        func border() -> UIView {
            let border = UIView(frame: CGRect.zero)
            border.backgroundColor = color
            border.translatesAutoresizingMaskIntoConstraints = false
            return border
        }

        if edges.contains(.top) || edges.contains(.all) {
            let top = border()
            base.addSubview(top)
            base.addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[top(==thickness)]",
                                               options: [],
                                               metrics: ["thickness": thickness],
                                               views: ["top": top]))
            base.addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[top]-(0)-|",
                                               options: [],
                                               metrics: nil,
                                               views: ["top": top]))
            borders.append(top)
        }

        if edges.contains(.left) || edges.contains(.all) {
            let left = border()
            base.addSubview(left)
            base.addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[left(==thickness)]",
                                               options: [],
                                               metrics: ["thickness": thickness],
                                               views: ["left": left]))
            base.addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[left]-(0)-|",
                                               options: [],
                                               metrics: nil,
                                               views: ["left": left]))
            borders.append(left)
        }

        if edges.contains(.right) || edges.contains(.all) {
            let right = border()
            base.addSubview(right)
            base.addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:[right(==thickness)]-(0)-|",
                                               options: [],
                                               metrics: ["thickness": thickness],
                                               views: ["right": right]))
            base.addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[right]-(0)-|",
                                               options: [],
                                               metrics: nil,
                                               views: ["right": right]))
            borders.append(right)
        }

        if edges.contains(.bottom) || edges.contains(.all) {
            let bottom = border()
            base.addSubview(bottom)
            base.addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:[bottom(==thickness)]-(0)-|",
                                               options: [],
                                               metrics: ["thickness": thickness],
                                               views: ["bottom": bottom]))
            base.addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[bottom]-(0)-|",
                                               options: [],
                                               metrics: nil,
                                               views: ["bottom": bottom]))
            borders.append(bottom)
        }

        return borders
    }
}

// MARK: - 👀
public extension Swifty where Base: UIView {
    func setPriority(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) {
        self.base.setContentHuggingPriority(priority, for: axis)
        self.base.setContentCompressionResistancePriority(priority, for: axis)
    }
}
