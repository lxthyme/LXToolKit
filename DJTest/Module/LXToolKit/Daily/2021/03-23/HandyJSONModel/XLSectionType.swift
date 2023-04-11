//
//  XLSectionType.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//
import Foundation
import RxDataSources

struct XLSectionType<T> {
    var header: String
    var items: [T]
}

extension XLSectionType: SectionModelType {
    typealias Item = T

    init(original: XLSectionType, items: [T]) {
        self = original
        self.items = items
    }
}
