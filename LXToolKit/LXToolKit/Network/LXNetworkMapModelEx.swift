//
//  LXNetworkMapModelEx.swift
//  Vaffle_demo
//
//  Created by LXThyme on 2019/1/8.
//  Copyright © 2019 DamonJow. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import HandyJSON
import Alamofire

//extension ObservableType where E == Response {
//    func mapBaseModel<T: HandyJSON>(_ type: T.Type) ->Observable<LXBaseModel<T>> {
//        return flatMap { response ->Observable<LXBaseModel<T>> in
//            let ele: LXBaseModel<T> = try response.mapBaseModel(T.self)
//            return Observable.just(ele)
//        }
//    }
//    
//    func mapBaseModelArray<T: HandyJSON>(_ type: T.Type) ->Observable<LXBaseModel<LXBaseListModel<T>>> {
//        return flatMap { response ->Observable<LXBaseModel<LXBaseListModel<T>>> in
//            return Observable.just(try response.mapBaseModelArray(T.self))
//        }
//    }
//}

extension Response {
    func mapBaseModel<T: HandyJSON>(_ type: T.Type) throws ->LXBaseModel<T> {
        let jsonString = String(data: data, encoding: .utf8)
        
        guard let baseModel = JSONDeserializer<LXBaseModel<T>>.deserializeFrom(json: jsonString) else {
//            throw NetWorkError.jsonError
            throw RxSwiftMoyaError.RxSwiftMoyaCouldNotMakeObjectError
        }
        
        guard baseModel.code == kLXSuccessCode else {
//            throw NetWorkError.others(resultCode: baseModel.code, resultMsg: baseModel.msg)
            throw NetWorkError.others(resultCode: baseModel.code, resultMsg: baseModel.msg)
        }
//        guard baseModel.code == kLXSuccessCode else { throw RxSwiftMoyaError.RxSwiftMoyaBizError(resultCode: baseModel.code, resultMsg: baseModel.msg) }
        
        guard baseModel.data != nil else {
//            throw NetWorkError.noData
            throw RxSwiftMoyaError.RxSwiftMoyaNoData
        }
        
        baseModel.fullJsonString = jsonString
        return baseModel
    }
    
    func mapBaseModelArray<T: HandyJSON>(_ type: T.Type) throws ->LXBaseModel<LXBaseListModel<T>> {
        
        let jsonString = String(data: data, encoding: .utf8)
        
        guard let baseModel = JSONDeserializer<LXBaseModel<LXBaseListModel<T>>>.deserializeFrom(json: jsonString) else {
//            throw NetWorkError.jsonError
            throw RxSwiftMoyaError.RxSwiftMoyaCouldNotMakeObjectError
        }
        dlog(baseModel)
        guard baseModel.code == kLXSuccessCode else {
//            throw NetWorkError.others(resultCode: baseModel.code, resultMsg: baseModel.msg)
            throw RxSwiftMoyaError.RxSwiftMoyaBizError(resultCode: baseModel.code, resultMsg: baseModel.msg)
        }
//        guard baseModel.code == kLXSuccessCode else { throw RxSwiftMoyaError.RxSwiftMoyaBizError(resultCode: baseModel.code, resultMsg: baseModel.msg) }
        
        guard let list = baseModel.data?.list, list.count > 0 else {
//            throw NetWorkError.noData
            throw RxSwiftMoyaError.RxSwiftMoyaNoData
        }
        
        baseModel.fullJsonString = jsonString
        return baseModel
    }
}


extension MoyaProvider {
    func request(target: Target) ->Observable<Moya.Response> {
        return Observable.create { [weak self] observer ->Disposable in
            if NetworkReachabilityManager()?.isReachable == false {
//                observer.onError(NetWorkError.networkError)
                observer.onError(RxSwiftMoyaError.RXSwiftMoyaNoNetwork)
                observer.onCompleted()
            }
            
            let cancellableToken = self?.request(target) { result in
                switch result {
                case let .success(response):
                    observer.onNext(response)
                    observer.onCompleted()
                    
                case let .failure(error):
                    let err = error as NSError
//                    observer.onError(NetWorkError.others(resultCode: err.code, resultMsg: err.description))
                    observer.onError(RxSwiftMoyaError.RxSwiftMoyaBizError(resultCode: err.code, resultMsg: err.description))
                    observer.onCompleted()
                }
            }
            
            return Disposables.create {
                cancellableToken?.cancel()
            }
        }
    }
}
