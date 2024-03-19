//
//  UIImageView + ex.swift
//  AcknowList
//
//  Created by LXThyme Jason on 2021/3/31.
//

import Foundation
import RxCocoa
import SDWebImage

// MARK: - 🔐
public extension Swifty where Base: UIImageView {
    var imageURL: Binder<URL?> {
        return self.sd_setImage()
    }
}

// MARK: - 👀
public extension Swifty where Base: UIImageView {
    func sd_setImage(withPlaceholder placeholderImage: UIImage? = nil,
                     options: SDWebImageOptions = [.retryFailed],
                     context: [SDWebImageContextOption: Any]? = [:]) -> Binder<URL?> {
        return Binder(self.base, binding: { (imageView, url) in
            imageView.sd_setImage(with: url,
                                  placeholderImage: placeholderImage,
                                  options: options,
                                  context: context)
        })
    }
}
