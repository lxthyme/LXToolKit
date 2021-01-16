//
//  LXAlbumListModel.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/1/16.
//  Copyright © 2021 CocoaPods. All rights reserved.
//
import Foundation
import Photos

typealias Second = Int
let ZLMaxImageWidth: CGFloat = 600

// MARK: - 👀LXAlbumListModel
class LXAlbumListModel: NSObject {
    let title: String
    var count: Int {
        return result.count
    }
    var result: PHFetchResult<PHAsset>
    let collection: PHAssetCollection
    let option: PHFetchOptions
    let isCameraRoll: Bool
    var headImageAsset: PHAsset? {
        return result.lastObject
    }

    var models: [LXAlbumListModel.Photo] = []
    init(title: String, result: PHFetchResult<PHAsset>, collection: PHAssetCollection, option: PHFetchOptions, isCameraRoll: Bool) {
        self.title = title
        self.result = result
        self.collection = collection
        self.option = option
        self.isCameraRoll = isCameraRoll
    }
}

// MARK: - 👀
extension LXAlbumListModel {
    func refetchPhotos() {
        let models = ZLPhotoManager.fetchPhoto(in: self.result, ascending: ZLPhotoConfiguration.default().sortAscending, allowSelectImage: ZLPhotoConfiguration.default().allowSelectImage, allowSelectVideo:  ZLPhotoConfiguration.default().allowSelectVideo)
        self.models.removeAll()
        self.models.append(contentsOf: models)
    }

    func refreshResult() {
        self.result = PHAsset.fetchAssets(in: self.collection, options: self.option)
    }
}

// MARK: - 👀TextStickerState
extension LXAlbumListModel {
    class TextStickerState: NSObject {
        let text: String
        let textColor: UIColor
        let bgColor: UIColor
        let originScale: CGFloat
        let originAngle: CGFloat
        let originFrame: CGRect
        let gesScale: CGFloat
        let gesRotation: CGFloat
        let totalTranslationPoint: CGPoint

        init(text: String, textColor: UIColor, bgColor: UIColor, originScale: CGFloat, originAngle: CGFloat, originFrame: CGRect, gesScale: CGFloat, gesRotation: CGFloat, totalTranslationPoint: CGPoint) {
            self.text = text
            self.textColor = textColor
            self.bgColor = bgColor
            self.originScale = originScale
            self.originAngle = originAngle
            self.originFrame = originFrame
            self.gesScale = gesScale
            self.gesRotation = gesRotation
            self.totalTranslationPoint = totalTranslationPoint
            super.init()
        }
    }
}

// MARK: - 👀ImageStickerState
extension LXAlbumListModel {
    class ImageStickerState: NSObject {
        let image: UIImage
        let originScale: CGFloat
        let originAngle: CGFloat
        let originFrame: CGRect
        let gesScale: CGFloat
        let gesRotation: CGFloat
        let totalTranslationPoint: CGPoint

        init(image: UIImage, originScale: CGFloat, originAngle: CGFloat, originFrame: CGRect, gesScale: CGFloat, gesRotation: CGFloat, totalTranslationPoint: CGPoint) {
            self.image = image
            self.originScale = originScale
            self.originAngle = originAngle
            self.originFrame = originFrame
            self.gesScale = gesScale
            self.gesRotation = gesRotation
            self.totalTranslationPoint = totalTranslationPoint
            super.init()
        }
    }
}

// MARK: - 👀EditImageModel
extension LXAlbumListModel {
    class EditImageModel: NSObject {
        let drawPaths: [LXAlbumListModel.DrawPath]
        let mosaicPaths: [LXAlbumListModel.MosaicPath]
        let editRect: CGRect?
        let angle: CGFloat
        let selectRatio: LXAlbumListModel.ImageClipRatio?
//        let selectFilter: ZLFilter?
        let textStickers: [(state: LXAlbumListModel.TextStickerState, index: Int)]?
        let imageStickers: [(state: LXAlbumListModel.ImageStickerState, index: Int)]?
        init(drawPaths: [LXAlbumListModel.DrawPath],
             mosaicPaths: [LXAlbumListModel.MosaicPath],
             editRect: CGRect?,
             angle: CGFloat,
             selectRatio: LXAlbumListModel.ImageClipRatio?,
//             selectFilter: ZLFilter,
             textStickers: [(state: LXAlbumListModel.TextStickerState, index: Int)]?,
             imageStickers: [(state: LXAlbumListModel.ImageStickerState, index: Int)]?) {
            self.drawPaths = drawPaths
            self.mosaicPaths = mosaicPaths
            self.editRect = editRect
            self.angle = angle
            self.selectRatio = selectRatio
//            self.selectFilter = selectFilter
            self.textStickers = textStickers
            self.imageStickers = imageStickers
            super.init()
        }
    }
}

// MARK: - 👀ImageClipRatio: 裁剪比例
extension LXAlbumListModel {
    class ImageClipRatio: NSObject {
        let title: String
        let whRatio: CGFloat
        @objc init(title: String, whRatio: CGFloat) {
            self.title = title
            self.whRatio = whRatio
        }
    }
}

// MARK: - 👀
extension LXAlbumListModel.ImageClipRatio {
    @objc public static let custom = LXAlbumListModel.ImageClipRatio(title: "custom", whRatio: 0)
    @objc public static let wh1x1 = LXAlbumListModel.ImageClipRatio(title: "1 : 1", whRatio: 1)
    @objc public static let wh3x4 = LXAlbumListModel.ImageClipRatio(title: "3 : 4", whRatio: 3.0/4.0)
    @objc public static let wh4x3 = LXAlbumListModel.ImageClipRatio(title: "4 : 3", whRatio: 4.0/3.0)
    @objc public static let wh2x3 = LXAlbumListModel.ImageClipRatio(title: "2 : 3", whRatio: 2.0/3.0)
    @objc public static let wh3x2 = LXAlbumListModel.ImageClipRatio(title: "3 : 2", whRatio: 3.0/2.0)
    @objc public static let wh9x16 = LXAlbumListModel.ImageClipRatio(title: "9 : 16", whRatio: 9.0/16.0)
    @objc public static let wh16x9 = LXAlbumListModel.ImageClipRatio(title: "16 : 9", whRatio: 16.0/9.0)
}

func ==(lhs: LXAlbumListModel.ImageClipRatio, rhs: LXAlbumListModel.ImageClipRatio) -> Bool {
    return lhs.whRatio == rhs.whRatio
}

// MARK: - 👀DrawPath
extension LXAlbumListModel {
    class DrawPath: NSObject {
        let pathColor: UIColor
        let path: UIBezierPath
        let ratio: CGFloat
        let shapeLayer: CAShapeLayer
        init(pathColor: UIColor, pathWidth: CGFloat, ratio: CGFloat, startPoint: CGPoint) {
            self.pathColor = pathColor

            self.path = UIBezierPath()
            self.path.lineWidth = pathWidth / ratio
            self.path.lineCapStyle = .round
            self.path.lineJoinStyle = .round
            self.path.move(to: CGPoint(x: startPoint.x / ratio, y: startPoint.y / ratio))

            self.shapeLayer = CAShapeLayer()
            self.shapeLayer.lineCap = .round
            self.shapeLayer.lineJoin = .round
            self.shapeLayer.lineWidth = pathWidth / ratio
            self.shapeLayer.fillColor = UIColor.clear.cgColor
            self.shapeLayer.strokeColor = pathColor.cgColor
            self.shapeLayer.path = self.path.cgPath

            self.ratio = ratio
            super.init()
        }
    }
}

// MARK: - 👀MosaicPath
extension LXAlbumListModel {
    class MosaicPath: NSObject {
        let path: UIBezierPath
        let ratio: CGFloat
        let startPoint: CGPoint
        var linePoints: [CGPoint] = []
        init(pathWidth: CGFloat, ratio: CGFloat, startPoint: CGPoint) {
            self.path = UIBezierPath()
            self.path.lineWidth = pathWidth
            self.path.lineCapStyle = .round
            self.path.lineJoinStyle = .round
            self.path.move(to: startPoint)

            self.ratio = ratio
            self.startPoint = CGPoint(x: startPoint.x / ratio, y: startPoint.y / ratio)
            super.init()
        }
    }
}

// MARK: - 👀
extension LXAlbumListModel.MosaicPath {
    func addLine(to point: CGPoint) {
        self.path.addLine(to: point)
        self.linePoints.append(CGPoint(x: point.x / self.ratio, y: point.y / self.ratio))
    }
}

// MARK: - 👀
extension LXAlbumListModel.DrawPath {
    func addLine(to point: CGPoint) {
        self.path.addLine(to: CGPoint(x: point.x / self.ratio, y: point.y / self.ratio))
        self.shapeLayer.path = self.path.cgPath
    }
    func drawPath() {
        self.pathColor.set()
        self.path.stroke()
    }
}

// MARK: - 👀Photo
extension LXAlbumListModel {
    class Photo: NSObject {
        let identifier: String
        let asset: PHAsset
        var type: LXAlbumListModel.MediaType = .unknown
        var duration: String = ""
        var isSelected: Bool = false
        private var pri_editImage: UIImage? = nil
        var editImage: UIImage? {
            set {
                pri_editImage = newValue
            }
            get {
                if let _ = self.editImageModel {
                    return pri_editImage
                } else {
                    return nil
                }
            }
        }
        var second: Second {
            guard type == .video else {
                return 0
            }
            return Int(round(asset.duration))
        }
        var whRatio: CGFloat {
            return CGFloat(self.asset.pixelWidth) / CGFloat(self.asset.pixelHeight)
        }
        var previewSize: CGSize {
            let scale: CGFloat = 2 //UIScreen.main.scale
            if self.whRatio > 1 {
                let h = min(UIScreen.main.bounds.height, ZLMaxImageWidth) * scale
                let w = h * self.whRatio
                return CGSize(width: w, height: h)
            } else {
                let w = min(UIScreen.main.bounds.width, ZLMaxImageWidth) * scale
                let h = w / self.whRatio
                return CGSize(width: w, height: h)
            }
        }
        // Content of the last edit.
        var editImageModel: LXAlbumListModel.EditImageModel?

        init(asset: PHAsset) {
            self.identifier = asset.localIdentifier
            self.asset = asset
            super.init()

            self.type = transformAssetType(for: asset)
            if self.type == .video {
                self.duration = transformDuration(for: asset)
            }
        }
    }
}

// MARK: - 👀
extension LXAlbumListModel {
    public enum MediaType: Int {
        case unknown = 0
        case image
        case gif
        case livePhoto
        case video
    }
}

// MARK: - 👀
extension LXAlbumListModel.Photo {
    func transformAssetType(for asset: PHAsset) -> LXAlbumListModel.MediaType {
        switch asset.mediaType {
        case .video:
            return .video
        case .image:
            if (asset.value(forKey: "filename") as? String)?.hasSuffix("GIF") == true {
                return .gif
            }
            if #available(iOS 9.1, *) {
                if asset.mediaSubtypes == .photoLive || asset.mediaSubtypes.rawValue == 10 {
                    return .livePhoto
                }
            }
            return .image
        default:
            return .unknown
        }
    }
    func transformDuration(for asset: PHAsset) -> String {
        let dur = Int(round(asset.duration))

        switch dur {
        case 0..<60:
            return String(format: "00:%02d", dur)
        case 60..<3600:
            let m = dur / 60
            let s = dur % 60
            return String(format: "%02d:%02d", m, s)
        case 3600...:
            let h = dur / 3600
            let m = (dur % 3600) / 60
            let s = dur % 60
            return String(format: "%02d:%02d:%02d", h, m, s)
        default:
            return ""
        }
    }
}
