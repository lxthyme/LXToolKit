//
//  RequestMacro.swift
//  Vaffle_demo
//
//  Created by LXThyme on 2019/1/10.
//  Copyright © 2019 DamonJow. All rights reserved.
//

import Foundation

let kLXSuccessCode: Int = 10000

// let LXNetworkHelper_Base_URL = "http://local.api.vaffle.com"
let LXNetworkHelper_Base_URL = "https://apitest.vaffle.com"

let shouldTimeout: Bool = false

let LX_Response_Logger_Max_Count = 200
public let LX_Request_Queue_label = Bundle.main.bundleIdentifier ?? "com.hg.lx"
let networkQueue = DispatchQueue(label: LX_Request_Queue_label)
let LX_Request_Timeout: TimeInterval = 30
let LX_Resource_Timeout: TimeInterval = 30
