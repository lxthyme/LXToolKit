//
//  API.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/23.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import HandyJSON

protocol XLAPI {
    func events(page: Int) -> Single<XLBaseModel<XLBaseListModel<XLEventsModel>>>
    func repositoryEvents(owner: String, repo: String, page: Int) -> Single<XLBaseModel<XLBaseListModel<XLEventsModel>>>

    func userReceivedEvents(username: String, page: Int) -> Single<XLBaseModel<XLBaseListModel<XLEventsModel>>>
    func userReceivedEvents2(username: String, page: Int) -> Observable<XLBaseModel<XLBaseListModel<XLEventsModel>>>
    func userPerformedEvents(username: String, page: Int) -> Single<XLBaseModel<XLBaseListModel<XLEventsModel>>>
    func organizationEvents(username: String, page: Int) -> Single<XLBaseModel<XLBaseListModel<XLEventsModel>>>
}
