//
//  XLEventsModel.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import ObjectMapper

struct XLEventsModel: Mappable {

    var actor: User?
    var createdAt: Date?
    var id: String?
    var organization: User?
    var isPublic: Bool?
    var repository: Repository?
    var type: EventType = .unknown

    var payload: Payload?

    init?(map: Map) {}
    init() {}

    mutating func mapping(map: Map) {
        actor <- map["actor"]
        createdAt <- (map["created_at"], ISO8601DateTransform())
        id <- map["id"]
        organization <- map["org"]
        isPublic <- map["public"]
        repository <- map["repo"]
        type <- map["type"]

        payload = Mapper<Payload>().map(JSON: map.JSON)

        if let fullname = repository?.name {
            let parts = fullname.components(separatedBy: "/")
            repository?.name = parts.last
            repository?.owner = User()
            repository?.owner?.login = parts.first
            repository?.fullname = fullname
        }
    }
}

extension XLEventsModel: Equatable {
    static func == (lhs: XLEventsModel, rhs: XLEventsModel) -> Bool {
        return lhs.id == rhs.id
    }
}
