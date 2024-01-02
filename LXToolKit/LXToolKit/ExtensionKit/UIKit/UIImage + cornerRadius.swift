//
//  UIImage + cornerRadius.swift
//  Alamofire
//
//  Created by LXThyme Jason on 2020/8/6.
//

import Foundation

// MARK: - <#Title...#>
public extension UIImage {
    func scale(with newSize: CGSize) -> UIImage? {
        var width = self.size.width
        var height = self.size.height
        let scale = newSize.width / newSize.height
        let imgScale = width / height
        if imgScale > scale {
            width = height * scale
        } else if imgScale < scale {
            height = width / scale
        }
        let frame = CGRect(x: (self.size.width - width) * 0.5,
                           y: (self.size.height - height) * 0.5, width: width, height: height)
        let imgRef1 = self.cgImage
        guard let imgRef2 = imgRef1?.cropping(to: frame) else { return nil }
        let img = UIImage(cgImage: imgRef2)
        return img
    }
    func xl_cornerRadius(cornerRadius: CGSize, roundingCorners: UIRectCorner, newSize: CGSize) -> UIImage? {
        let originImg = scale(with: newSize)
        let bounds = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: roundingCorners, cornerRadii: cornerRadius)

        context?.addPath(path.cgPath)
        context?.clip()
        originImg?.draw(in: bounds)

        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}

// MARK: - <#Title...#>
public extension UIImage {
    func xl_corner(newSize: CGSize) -> CALayer {
        let layer = CALayer()
        layer.frame = CGRect(origin: .zero, size: newSize)
        layer.contentsCenter = CGRect(x: 0.5, y: 0.5, width: 0, height: 0)
        layer.contentsScale = UIScreen.main.scale
        layer.contents = self.cgImage
        return layer

    }
}

// MARK: - <#Title...#>
public extension UIImageView {
    func xl_cornerRadius(roundingCorners: UIRectCorner, cornerRadii: CGSize) {
        let newSize = self.frame.size

        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: roundingCorners, cornerRadii: cornerRadii)
        path.addClip()
        self.draw(self.bounds)

        self.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    func xl_cornerRadius2(roundingCorners: UIRectCorner, cornerRadii: CGSize) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: roundingCorners, cornerRadii: cornerRadii)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
}

public enum XLScaleMode: Int {
    case fill = 0
    case aspectFit = 1
    case aspectFill = 2
}

func XLCGRectFitWithScaleMode(rect: CGRect, size: CGSize, scaleMode: XLScaleMode) -> CGRect {
    var newRect = rect.standardized
    var newSize = size
    newSize.width = newSize.width < 0 ? -newSize.width : newSize.width
    newSize.height = newSize.height < 0 ? -newSize.height : newSize.height
    let center = CGPoint(x: newRect.midX, y: newRect.midY)
    switch scaleMode {
        case .aspectFit, .aspectFill:
            if newRect.size.width < 0.01 ||
                newRect.size.height < 0.01 ||
                size.width < 0.01 ||
                size.height < 0.01 {
                newRect.origin = center
                newRect.size = .zero
            } else {
                var scale: CGFloat = 0
                if scaleMode == .aspectFit {
                    if newSize.width / newSize.height < newRect.size.width / newRect.size.height {
                        scale = newRect.size.height / newSize.height
                    } else {
                        scale = newRect.size.width / newSize.width
                    }
                } else {
                    if newSize.width / newSize.height < newRect.size.width / newRect.size.height {
                        scale = newRect.size.width / newSize.width
                    } else {
                        scale = newRect.size.height / newSize.height
                    }
                }

                newSize.width *= scale
                newSize.height *= scale
                newRect.size = newSize
                newRect.origin = CGPoint(x: center.x - newSize.width * 0.5,
                                         y: center.y - newSize.height * 0.5)
        }
        case .fill:
        break
    }
    return rect
}

// MARK: - <#Title...#>
public extension UIImage {
    func xl_drawInRect(rect: CGRect, context: CGContext, scaleMode: XLScaleMode, clipsToBounds: Bool) {
        let drawRect = XLCGRectFitWithScaleMode(rect: rect, size: self.size, scaleMode: scaleMode)
        if drawRect.size.width == 0 || drawRect.size.height == 0 {
            return
        }

        if clipsToBounds {
            context.saveGState()
            context.addRect(rect)
            context.clip()
            self.draw(in: drawRect)
            context.restoreGState()
        } else {
            self.draw(in: drawRect)
        }
    }
    func xl_resizeImage(with newSize: CGSize, scaleMode: XLScaleMode) -> UIImage? {
        if newSize.width <= 0 || newSize.height <= 0 { return nil }

        let uiformat = UIGraphicsImageRendererFormat()
        uiformat.scale = self.scale
        uiformat.opaque = false
        if #available(iOS 12.0, *) {
            uiformat.preferredRange = .standard
        } else {
            uiformat.prefersExtendedRange = false
        }
        let renderer = UIGraphicsImageRenderer(size: newSize, format: uiformat)
//        if #available(iOS 10.0, *) {
            let img = renderer.image { rendererCntext in
                self.xl_drawInRect(rect: CGRect(origin: .zero, size: newSize), context: rendererCntext.cgContext, scaleMode: scaleMode, clipsToBounds: false)
            }
            return img
//        } else {
//            UIGraphicsBeginImageContextWithOptions(self.size, uiformat.opaque, uiformat.scale)
//            let context = UIGraphicsGetCurrentContext()
//            renderer.image { (<#UIGraphicsImageRendererContext#>) in
//                <#code#>
//            }
//            let img = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//            return
//        }
    }
    func xl_imageByRoundCornerRadius(radius: CGFloat, corner: UIRectCorner, borderWidth: CGFloat, borderColor: UIColor? = nil, borderLineJoin: CGLineJoin) -> UIImage? {
        var rectCorner: UIRectCorner = corner
//        var masked = CACornerMask()
        if !corner.contains(.allCorners) {
            var tmp = corner
            if corner.contains(.topLeft) { tmp.insert(.bottomLeft) }
            if corner.contains(.topRight) { tmp.insert(.bottomRight) }
            if corner.contains(.bottomLeft) { tmp.insert(.topLeft) }
            if corner.contains(.bottomRight) { tmp.insert(.topRight) }
            rectCorner = tmp
        }

        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        guard let context = UIGraphicsGetCurrentContext() else { return self }
        let rect = CGRect(origin: .zero, size: self.size)
        context.scaleBy(x: 1, y: -1)
        context.translateBy(x: 0, y: -rect.size.height)

        let minSize = min(size.width, size.height)
        if borderWidth < minSize / 2 {
            let path = UIBezierPath(roundedRect: rect.insetBy(dx: borderWidth, dy: borderWidth),
                                    byRoundingCorners: rectCorner,
                                    cornerRadii: CGSize(width: radius, height: radius))
            path.close()
            context.saveGState()
            path.addClip()
//            if let cgImage = self.cgImage {
//                context.draw(cgImage, in: rect)
//            }
            self.draw(in: rect)
            context.restoreGState()
        }

        if borderColor != nil,
            borderWidth > 0,
            borderWidth < minSize / 2 {
            let strokeInset = (floor(borderWidth * self.scale) + 0.5) / self.scale
            let strokeRect = rect.insetBy(dx: strokeInset, dy: strokeInset)
            let strokeRadius = radius > self.scale / 2 ? radius - self.scale / 2 : 0
            let path = UIBezierPath(roundedRect: strokeRect,
                                    byRoundingCorners: rectCorner,
                                    cornerRadii: CGSize(width: strokeRadius, height: borderWidth))
            path.close()

            path.lineWidth = borderWidth
            path.lineJoinStyle = borderLineJoin
            borderColor?.setStroke()
            path.stroke()
        }

        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}

// MARK: - 👀
public extension Swifty where Base: UIView {
    func addStretchableImage(image: UIImage, withContentCenter rect: CGRect) {
        /// set image
        base.layer.contents = image.cgImage
        /// set contentsCenter
        base.layer.contentsCenter = rect
    }
}
