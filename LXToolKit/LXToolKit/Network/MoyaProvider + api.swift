//
//  MoyaProvider + api.swift
//  Alamofire
//
//  Created by LXThyme Jason on 2020/9/28.
//

import Foundation
import Moya
import RxSwift
import Alamofire

// MARK: - req
public extension MoyaProvider {
    func req(target: TargetType,
             callbackQueue: DispatchQueue? = DispatchQueue.init(label: LX_Request_Queue_label),
             progress: ProgressBlock? = nil,
             completion: Completion? = nil) ->Observable<Moya.Response> {
        return Observable.create { [weak self]observer -> Disposable in
            guard let `self` = self else {
                observer.onError(RxMoyaError.unknown)
                return Disposables.create()
            }
            if let isReachable = NetworkReachabilityManager()?.isReachable, !isReachable {
                observer.onError(RxMoyaError.unReachable)
            }

            let cancellableToken = self.request(
                MultiTarget(target) as! Target,
                callbackQueue: callbackQueue,
                progress: progress) { result in
                    switch result {
                        case .failure(let error):
                            if let isReachable = NetworkReachabilityManager()?.isReachable, !isReachable {
                                observer.onError(RxMoyaError.unReachable)
                            } else {
                                observer.onError(RxMoyaError.error(error: error))
                        }
                        case .success(let response):
                            observer.onNext(response)
                            observer.onCompleted()
                    }
            }
            return Disposables.create {
                cancellableToken.cancel()
            }
        }
    }
}
