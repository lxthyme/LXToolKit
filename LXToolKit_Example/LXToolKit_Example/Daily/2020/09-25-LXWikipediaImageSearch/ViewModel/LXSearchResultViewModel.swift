//
//  LXSearchResultViewModel.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/9/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import LXToolKit
import RxSwift
import RxCocoa

class LXSearchResultViewModel: LXBaseVM {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    let searchResult: WikipediaSearchResult

    var title: Driver<String> = Driver.never()
    var imageURLs: Driver<[URL]> = Driver.never()

    let API = DefaultWikipediaAPI.shared
    let `$` = Dependencies.shared
    init(searchResult: WikipediaSearchResult) {
        self.searchResult = searchResult
        super.init()

        let URLs = configureImageURLs()

        self.imageURLs = URLs.asDriver(onErrorJustReturn: [])
        self.title = configureTitle(URLs).asDriver(onErrorJustReturn: "Error during fetching!")
    }

    func configureTitle(_ imageURLs: Observable<[URL]>) ->Observable<String> {
        let loadingValue: [URL]? = nil

        return imageURLs
            .map(Optional.init)
            .startWith(loadingValue)
            .map {[weak self]URLs in
                guard let `self` = self else { return "" }
                if let urls = URLs {
                    return "\(self.searchResult.title) (\(urls.count) pictures"
                } else {
                    return "\(self.searchResult.title) (loading...)"
                }
        }
        .retryOnBecomesReachable("⚠️ Service offline ⚠️", reachabilityService: `$`.reachabilityService)
    }

    func configureImageURLs() ->Observable<[URL]> {
        return API
            .articleContent(searchResult)
            .observeOn(`$`.backgroundWorkScheduler)
            .map { page in
                do {
                    return try parseImageURLsFromHTMLSuitableForDisplay(page.text as NSString)
                } catch {
                    return []
                }
        }
        .share(replay: 1)
    }
}

// MARK: 👀Public Actions
extension LXSearchResultViewModel {}

// MARK: 🔐Private Actions
private extension LXSearchResultViewModel {}
