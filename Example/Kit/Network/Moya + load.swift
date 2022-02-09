//
//  Moya + load.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/9/21.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import Moya
import HandyJSON
import LXToolKit

// MARK: - 👀
extension Reactive where Base: MoyaProviderType {
    func load(_ token: Base.Target, callbackQueue: DispatchQueue? = nil) ->Observable<ProgressResponse> {
        let progressBlock: (AnyObserver) -> (ProgressResponse) -> Void = {observer in
            return { progress in
                observer.onNext(progress)
            }
        }
        let response: Observable<ProgressResponse> = Observable.create {[weak base] observer in
            if NetworkReachabilityManager()?.isReachable ?? false {
                observer.onError(LXNetworkError.unReachable)
            }
            let cancellableToken = base?.request(token, callbackQueue: callbackQueue, progress: progressBlock(observer), completion: { result in
                switch result {
                    case .success:
                        observer.onCompleted()
                    case let .failure(error):
                        if NetworkReachabilityManager()?.isReachable ?? false {
                            observer.onError(LXNetworkError.unReachable)
                        } else {
                            observer.onError(error)
                    }
                }
            })
            return Disposables.create {
                cancellableToken?.cancel()
            }
        }
        return response
    }
}

// MARK: - 👀
extension PrimitiveSequence where Trait == SingleTrait, Element == Moya.Response {
    func mapModel<T: HandyJSON>(_ type: T.Type) -> PrimitiveSequence<Trait, T> {
        return self.map { response -> T in
            guard let string = String(data: response.data, encoding: .utf8),
                let model = T.deserialize(from: string) else {
                    throw LXNetworkError.invalidJSON
            }
            guard (200...209) ~= response.statusCode else {
                throw LXNetworkError.invalidHTTPCode
            }
            return model
        }
    }
    func mapBaseModel<T: HandyJSON>(_ type: T.Type) -> PrimitiveSequence<Trait, LXBaseGenericModel<T>> {
        return self.map { response -> LXBaseGenericModel<T> in
            guard let string = String(data: response.data, encoding: .utf8),
                let model = LXBaseGenericModel<T>.deserialize(from: string) else {
                    throw LXNetworkError.invalidJSON
            }
            guard (200...209) ~= response.statusCode else {
                throw LXNetworkError.invalidHTTPCode
            }
            return model
        }
    }
    func mapBaseListModel<T: HandyJSON>(_ type: T.Type) -> PrimitiveSequence<Trait, LXBaseListModel<T>> {
        return self.map { response -> LXBaseListModel<T> in
            guard let string = String(data: response.data, encoding: .utf8),
                let model = LXBaseListModel<T>.deserialize(from: string) else {
                    throw LXNetworkError.invalidJSON
            }
            guard (200...209) ~= response.statusCode else {
                throw LXNetworkError.invalidHTTPCode
            }
            return model
        }
    }
}
