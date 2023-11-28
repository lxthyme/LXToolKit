//
//  ImageService.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/9/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ImageService {
    func imageFromURL(_ url: URL, reachabilityService: ReachabilityService) ->Observable<DownloadableImage>
}

class DefaultImageService: ImageService {
    static let shared = DefaultImageService()

    let `$` = Dependencies.shared

    private let _imageCache = NSCache<AnyObject, AnyObject>()

    private let _imageDataCache = NSCache<AnyObject, AnyObject>()

    let loadingImage = ActivityIndicator()

    private init() {
        _imageDataCache.totalCostLimit = 10 * MB

        _imageCache.countLimit = 20
    }

    private func decodeImage(_ imageData: Data) ->Observable<UIImage> {
        return Observable.just(imageData)
            .observeOn(`$`.backgroundWorkScheduler)
            .map { data in
                guard let image = UIImage(data: data) else {
                    throw apiError("Decode image error!")
                }
                return image.forceLazyImageDecompression()
        }
    }

    private func _imageFromURL(_ url: URL) ->Observable<UIImage> {
        return Observable.deferred {
            let maybeImage = self._imageCache.object(forKey: url as AnyObject) as? UIImage
            let decodedImage: Observable<UIImage>

            if let img = maybeImage {
                decodedImage = Observable.just(img)
            } else {
                let cachedData = self._imageDataCache.object(forKey: url as AnyObject) as? Data

                if let cd = cachedData {
                    decodedImage = self.decodeImage(cd)
                } else {
                    decodedImage = self.`$`
                        .URLSession.rx.data(request: URLRequest(url: url))
                        .do(onNext: { data in
                            self._imageDataCache.setObject(data as AnyObject, forKey: url as AnyObject)
                        })
                        .flatMap(self.decodeImage)
                        .trackActivity(self.loadingImage)
                }
            }
            return decodedImage.do(onNext: { image in
                self._imageCache.setObject(image, forKey: url as AnyObject)
            })
        }
    }

    func imageFromURL(_ url: URL, reachabilityService: ReachabilityService) -> Observable<DownloadableImage> {
        return _imageFromURL(url)
            .map { DownloadableImage.content(image: $0) }
            .retryOnBecomesReachable(DownloadableImage.offlinePlaceholder, reachabilityService: reachabilityService)
            .startWith(.content(image: UIImage()))
    }

}
