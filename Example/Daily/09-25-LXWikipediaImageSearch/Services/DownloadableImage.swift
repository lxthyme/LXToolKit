//
//  DownloadableImage.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/9/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import RxSwift

enum DownloadableImage {
    case content(image: UIImage)
    case offlinePlaceholder
}
