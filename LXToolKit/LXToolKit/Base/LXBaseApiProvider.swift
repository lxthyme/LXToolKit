//
//  LXBaseApiProvider.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/6/17.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import HandyJSON

//protocol DecodableTargetType: Moya.TargetType {
//    associatedtype ResultType: HandyJSON
//}

//protocol LXBaseApiProvider: APIService, DecodableTargetType, AccessTokenAuthorizable {}
//enum LXBaseApiProvider: APIService {
//    var params: APIParameter? {
//        return ("", [:])
//    }
//
//}

// MARK: - <#Title...#>
//extension LXBaseApiProvider {
//    @discardableResult
//    func req<T: APIService>(_ target: T,
//                                     callbackQueue: DispatchQueue? = .none,
//                                     progress: ProgressBlock? = .none,
//                                     completion: @escaping (_ result: Result<T.ResultType, MoyaError>) ->()) -> Cancellable {
//        return apiProvider.request(MultiTarget(target), callbackQueue: callbackQueue, progress: progress) { result in
//            switch result {
//                case .success(let response):
//                    if let json = try? response.mapJSON() as? [String: Any],
//                        let model = T.ResultType.deserialize(from: json) {
//                        completion(.success(model))
//                    } else {
//                        completion(.failure(.jsonMapping(response)))
//                }
//                case .failure(let error):
//                    completion(.failure(error))
//            }
//        }
//    }
//}
