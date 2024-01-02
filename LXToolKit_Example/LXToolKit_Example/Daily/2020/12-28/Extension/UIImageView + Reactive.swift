//
//  UIImageView + Reactive.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/1/9.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import SDWebImage

// MARK: - 👀
extension Reactive where Base: UIImageView {
    func xl_setImage(placeholder: UIImage? = UIImage(named: "placeholderimage")) -> Binder<String> {
        return Binder(base) { iv, url in
            iv.sd_setImage(with: URL(string: url),
                           placeholderImage: placeholder,
                           options: [
                            .lowPriority,
                            .matchAnimatedImageClass,
                            .preloadAllFrames,
                            .progressiveLoad,
                            .retryFailed],
                           context: nil)
        }
    }
}
