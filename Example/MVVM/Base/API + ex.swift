//
//  API + ex.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/9/28.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import HandyJSON

// MARK: - 🔐
extension ObservableType where Element == Response {
    func mapModel<T: HandyJSON>(_ type: T.Type) ->Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(try response.mapModel(T.self))
        }
    }
}

// MARK: - 👀
extension Response {
    func mapModel<T: HandyJSON>(_ type: T.Type) throws ->T {
        guard let obj = JSONDeserializer<T>.deserializeFrom(json: try mapString()) else {
            throw MoyaError.jsonMapping(self)
        }
        return obj
    }
}
