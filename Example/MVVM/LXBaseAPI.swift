//
//  LXBaseAPI.swift
//  LXToolKit_Exam
//
//  Created by lxthyme on 2022/2/10.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation

protocol LXBaseAPI {
    func events(page: Int) -> Single<[Event]>
    func repositoryEvents(owner: String, repo: String, page: Int) -> Single<[Event]>
    func userReceivedEvents(username: String, page: Int) -> Single<[Event]>
    func userPerformedEvents(username: String, page: Int) -> Single<[Event]>
    func organizationEvents(username: String, page: Int) -> Single<[Event]>
}
