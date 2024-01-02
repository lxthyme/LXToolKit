//
//  HtmlParsing.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/9/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

func parseImageURLsFromHTML(_ html: NSString) throws -> [URL] {
    let regularExpression = try NSRegularExpression(pattern: "<img[^>]*src=\"([^\"]+)\"[^>]*>", options: [])
    let matches = regularExpression.matches(in: html as String, options: [], range: NSRange(location: 0, length: html.length))

    return matches.map { match -> URL? in
        if match.numberOfRanges != 2 { return nil }

        let url = html.substring(with: match.range(at: 1))
        var absoluteURLString = url
        if url.hasPrefix("//") {
            absoluteURLString = "http:" + url
        }
        return URL(string: absoluteURLString)
    }.filter { $0 != nil }.map { $0! }
}

func parseImageURLsFromHTMLSuitableForDisplay(_ html: NSString) throws -> [URL] {
    return try parseImageURLsFromHTML(html).filter { $0.absoluteString.range(of: ".svg.") == nil }
}
