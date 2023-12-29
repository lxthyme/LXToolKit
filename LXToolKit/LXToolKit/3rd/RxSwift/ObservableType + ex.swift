//
//  ObservableType + ex.swift
//  LXToolKit
//
//  Created by LXThyme Jason on 2021/2/25.
//

import Foundation
import RxSwift

// MARK: - 👀
public extension ObservableType {
    func xl_doOnTest(_ prefix: String = "") -> RxSwift.Observable<Self.Element> {
        let tmp = prefix.isEmpty ? "" : "「\(prefix)」"
        return self.`do`(onNext: { ele in
            LogKit.logRxSwift(.onNext, items: "🛠\(tmp)3.2 do onNext: \(ele)")
        }, afterNext: { ele in
            LogKit.logRxSwift(.afterNext, items: "🛠\(tmp)5. do afterNext: \(ele)")
        }, onError: { e in
            LogKit.logRxSwift(.onError, items: "🛠\(tmp)6. do onError: \(e)")
        }, afterError: { e in
            LogKit.logRxSwift(.afterError, items: "🛠\(tmp)6. do afterError: \(e)")
        }, onCompleted: {
            LogKit.logRxSwift(.onCompleted, items: "🛠\(tmp)6. do onCompleted")
        }, afterCompleted: {
            LogKit.logRxSwift(.afterCompleted, items: "🛠\(tmp)9. do afterCompleted")
        }, onSubscribe: {
            LogKit.logRxSwift(.onSubscribe, items: "🛠\(tmp)1. do onSubscribe")
        }, onSubscribed: {
            LogKit.logRxSwift(.onSubscribed, items: "🛠\(tmp)2. do onSubscribed")
        }, onDispose: {
            LogKit.logRxSwift(.onDispose, items: "🛠\(tmp)10. do onDispose")
        })
    }
    func xl_subscribeTest(_ prefix: String = "") -> RxSwift.Disposable {
        let tmp = prefix.isEmpty ? "" : "「\(prefix)」"
        return self.subscribe { ele in
            LogKit.logRxSwift(.onSubscribe, items: "\(tmp)onNext: \(ele)")
        } onError: { error in
            LogKit.logRxSwift(.onError, items: "\(tmp)onError: \(error)")
        } onCompleted: {
            LogKit.logRxSwift(.onCompleted, items: "\(tmp)onCompleted")
        } onDisposed: {
            LogKit.logRxSwift(.onDispose, items: "\(tmp)onDisposed")
        }
    }
}
