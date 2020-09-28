//
//  DateFormatter + ex.swift
//  Alamofire
//
//  Created by LXThyme Jason on 2020/8/11.
//

import Foundation

// MARK: - 👀
public extension DateFormatter {
    static var formatter: DateFormatter = {
        let df = DateFormatter()
        df.timeStyle = .medium
        df.dateStyle = .medium
        return df
    }()
}

