//
//  UIImageView + DownloadableImage.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/9/27.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: - 👀
extension Reactive where Base: UIImageView {
//    var downloadableImage: Binder<DownloadableImage> {
//        return downloadableImage
//    }

    func downloadableImageAnimated(_ transitionType: CATransitionType?) -> Binder<DownloadableImage> {
        return Binder(base) { (imgView, image) in
            for subview in imgView.subviews {
                subview.removeFromSuperview()
            }

            switch image {
                case .content(image: let img):
                    (imgView as UIImageView).rx.image.on(.next(img))
                case .offlinePlaceholder:
                    let label = UILabel(frame: imgView.bounds)
                    label.textAlignment = .center
                    label.font = UIFont.systemFont(ofSize: 35)
                    label.text = "⚠️"
                    imgView.addSubview(label)
            }
        }
    }
}
