//
//  WikipediaPage.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/9/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import RxSwift

struct WikipediaPage {
    let title: String
    let text: String

    static func parseJSON(_ json: NSDictionary) throws -> WikipediaPage {
        guard
            let parse = json.value(forKey: "parse"),
            let title = (parse as AnyObject).value(forKey: "title") as? String,
            let tmp = (parse as AnyObject).value(forKey: "text"),
            let text = (tmp as AnyObject).value(forKey: "*") as? String
            else {
                throw apiError("Error parsing page content!")
        }

        return WikipediaPage(title: title, text: text)
    }
}
