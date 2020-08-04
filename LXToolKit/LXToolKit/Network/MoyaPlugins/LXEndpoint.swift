//
//  LXEndpoint.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/6/17.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
//import Moya

//let endpointClosure = { (service: APIService) -> Endpoint in
//    return Endpoint(
//        url: URL(target: service).absoluteString,
//        sampleResponseClosure: { () -> EndpointSampleResponse in
//            return .networkResponse(200, service.sampleData)
//    },
//        method: service.method,
//        task: service.task,
//        httpHeaderFields: service.headers)
//}
//
//let shouldTimeout = true
//let failureEndpointClosure = { (target: LXBaseApiProvider) ->Endpoint in
//    let sampleResponseClosure = { () ->EndpointSampleResponse in
//        return shouldTimeout ? .networkError(NSError()) : .networkResponse(200, target.sampleData)
//    }
//    return Endpoint(
//        url: URL(target: target).absoluteString,
//        sampleResponseClosure: sampleResponseClosure,
//        method: target.method,
//        task: target.task,
//        httpHeaderFields: target.headers)
//}
