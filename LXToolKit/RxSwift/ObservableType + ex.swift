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
            dlog("🛠\(tmp)3.2 do onNext: \(ele)")
        }, afterNext: { ele in
            dlog("🛠\(tmp)5. do afterNext: \(ele)")
        }, onError: { e in
            dlog("🛠\(tmp)6. do onError: \(e)")
        }, afterError: { e in
            dlog("🛠\(tmp)6. do afterError: \(e)")
        }, onCompleted: {
            dlog("🛠\(tmp)6. do onCompleted")
        }, afterCompleted: {
            dlog("🛠\(tmp)9. do afterCompleted")
        }, onSubscribe: {
            dlog("🛠\(tmp)1. do onSubscribe")
        }, onSubscribed: {
            dlog("🛠\(tmp)2. do onSubscribed")
        }, onDispose: {
            dlog("🛠\(tmp)10. do onDispose")
        })
    }
    func xl_subscribeTest(_ prefix: String = "") -> RxSwift.Disposable {
        let tmp = prefix.isEmpty ? "" : "「\(prefix)」"
        return self.subscribe { ele in
            dlog("\(tmp)onNext: \(ele)")
        } onError: { error in
            dlog("\(tmp)onError: \(error)")
        } onCompleted: {
            dlog("\(tmp)onCompleted")
        } onDisposed: {
            dlog("\(tmp)onDisposed")
        }
    }
}
