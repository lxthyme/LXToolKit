//
//  UIImage + emoticon.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/12/3.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import Kingfisher

 extension UIImage {
    @objc static func emoticonImage(with filePath: String) -> UIImage? {
//
//        let imageURL = URL(fileURLWithPath: filePath)
//        let cacheKey = imageURL.cacheKey
//        var cacheImage: UIImage? = nil
//
//        cacheImage = KingfisherManager.shared.cache.retrieveImageInMemoryCache(forKey: cacheKey)
//        //            if nil != cacheImage {
//        //               VPLog("TTTTTTTT = 内存缓存")
//        //            }
//        if nil == cacheImage {
//            cacheImage = KingfisherManager.shared.cache
//                .retrieveImageInDiskCache(forKey: cacheKey, completionHandler: { (_) in
//                })
//            if let pngImage = cacheImage {
//                KingfisherManager.shared.cache.store(pngImage, forKey: cacheKey)
//            }
//            //                if nil != cacheImage {
//            //                    VPLog("TTTTTTTT = 磁盘缓存")
//            //                }
//        }
//        if nil == cacheImage {
//            cacheImage = UIImage(contentsOfFile: filePath)
//            if let pngImage = cacheImage {
//                KingfisherManager.shared.cache.store(pngImage, forKey: cacheKey)
//            }
//            //                if nil != cacheImage {
//            //                    VPLog("TTTTTTTT = 本地文件")
//            //                }
//        }
//        return cacheImage
        return UIImage()
    }
}
