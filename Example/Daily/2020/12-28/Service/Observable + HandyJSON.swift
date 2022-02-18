//
//  Observable + HandyJSON.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2020/12/28.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import HandyJSON
import RxSwiftExt
import LXToolKit

// MARK: - 👀
extension ObservableType where Element == Any {
    private func mapJSONObject(failsOnEmptyData: Bool = true) ->Observable<Any> {
        return flatMap { Observable.just($0) }
    }
    private func filterNetworkErrorAndMapJSON() ->Observable<String> {
        return mapJSONObject()
            .map { response -> String in
                guard let res = response as? String,
                      res.count > 0 else {
                          throw ApiError.serializeError(response: nil, error: nil)
                }
                return res
            }
    }
    func mapModel<T: HandyJSON>(_ type: T.Type, path: String = "") ->Observable<T> {
        return filterNetworkErrorAndMapJSON()
            .map { response -> T in
                guard let model = T.deserialize(from: response, designatedPath: path) else {
                    throw ApiError.serializeError(response: nil, error: nil)
                }
                return model
            }
    }
}
