//
//  API.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/23.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

protocol XLAPI {
    func events(page: Int) -> Single<[Event]>
    func repositoryEvents(owner: String, repo: String, page: Int) -> Single<[Event]>

    func userReceivedEvents(username: String, page: Int) -> Single<[Event]>
    func userReceivedEvents2(username: String, page: Int) throws -> Single<XLBaseModel<XLBaseListModel<XLEventsModel>>>
    func userPerformedEvents(username: String, page: Int) -> Single<[Event]>
    func organizationEvents(username: String, page: Int) -> Single<[Event]>
}
