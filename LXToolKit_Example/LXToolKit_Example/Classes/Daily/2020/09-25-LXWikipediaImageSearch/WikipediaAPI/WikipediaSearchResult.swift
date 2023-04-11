//
//  WikipediaSearchResult.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/9/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import RxSwift

struct WikipediaSearchResult {
    let title: String
    let description: String
    let url: URL

    static func parseJSON(_ json: [AnyObject]) throws -> [WikipediaSearchResult] {
        let root = json.compactMap { $0 as? [AnyObject] }
        guard root.count == 3 else {
            throw WikipediaParseError
        }

        let (titles, descriptions, urls) = (root[0], root[1], root[2])
        let titleDescriptionAndURL: [((AnyObject, AnyObject), AnyObject)] = Array(zip(zip(titles, descriptions), urls))

        return try titleDescriptionAndURL.map({ result -> WikipediaSearchResult in
            let ((title, description), url) = result

            guard let titleString = title as? String,
                let descriptionString = description as? String,
                let urlString = url as? String,
                let url_t = URL(string: urlString) else {
                    throw WikipediaParseError
            }

            return WikipediaSearchResult(title: titleString, description: descriptionString, url: url_t)
        })
    }
}

// MARK: - 👀CustomDebugStringConvertible
extension WikipediaSearchResult: CustomDebugStringConvertible {
    var debugDescription: String {
        return "[\(title) - \(url)]"
    }
}
