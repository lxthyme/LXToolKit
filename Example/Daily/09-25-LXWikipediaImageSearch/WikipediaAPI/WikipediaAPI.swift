//
//  WikipediaAPI.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/9/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

func apiError(_ error: String) ->NSError {
    return NSError(domain: "WikipediaAPI", code: -1, userInfo: [
        NSLocalizedDescriptionKey: error
    ])
}

let WikipediaParseError = apiError("Error during parsing!")

protocol WikipediaAPI {
    func getSearchResults(_ query: String) ->Observable<[WikipediaSearchResult]>
    func articleContent(_ searchResult: WikipediaSearchResult) ->Observable<WikipediaPage>
}

class DefaultWikipediaAPI: WikipediaAPI {
    static let shared = DefaultWikipediaAPI()
    let `$` = Dependencies.shared
    let loadingWikipediaData = ActivityIndicator()

    private init() {}

    private func JSON(_ url: URL) ->Observable<Any> {
        return `$`.URLSession
            .rx.json(url: url)
            .trackActivity(loadingWikipediaData)
    }

    /// Example wikipedia response http://en.wikipedia.org/w/api.php?action=opensearch&search=Rx
    func getSearchResults(_ query: String) -> Observable<[WikipediaSearchResult]> {
        let escapedQuery = query.xl_urlEscaped
        let urlContent =
            "http://en.wikipedia.org/w/api.php?action=opensearch&search=\(escapedQuery)"
//            "https://en.wikipedia.org/w/api.php?action=opensearch&format=json&search=\(escapedQuery)"
        guard let url = URL(string: urlContent) else {
            return Observable.error(exampleError("url initial error!"))
        }

        return JSON(url)
            .observeOn(`$`.backgroundWorkScheduler)
            .map { json in
                guard let json = json as? [AnyObject] else {
                    throw exampleError("Parsing error!")
                }

                return try WikipediaSearchResult.parseJSON(json)
        }
        .observeOn(`$`.mainScheduler)
    }

    /// http://en.wikipedia.org/w/api.php?action=parse&page=rx&format=json
    func articleContent(_ searchResult: WikipediaSearchResult) -> Observable<WikipediaPage> {
        let escapedPage = searchResult.title.xl_urlEscaped
        guard let url = URL(string: "http://en.wikipedia.org/w/api.php?action=parse&page=\(escapedPage)&format=json") else {
            return Observable.error(apiError("Can't create url!"))
        }

        return JSON(url)
            .debug("img>>", trimOutput: true)
            .observeOn(`$`.backgroundWorkScheduler)
            .map { jsonResult in
                guard let json = jsonResult as? NSDictionary else {
                    throw exampleError("Parsing error!")
                }
                
                return try WikipediaPage.parseJSON(json)
        }
        .observeOn(`$`.mainScheduler)
    }
}
