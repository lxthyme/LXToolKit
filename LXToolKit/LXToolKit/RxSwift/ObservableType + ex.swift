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
            Log.rxswift.x_debug("🛠\(tmp)3.2 do onNext: \(ele)")
        }, afterNext: { ele in
            Log.rxswift.x_debug("🛠\(tmp)5. do afterNext: \(ele)")
        }, onError: { e in
            Log.rxswift.x_debug("🛠\(tmp)6. do onError: \(e)")
        }, afterError: { e in
            Log.rxswift.x_debug("🛠\(tmp)6. do afterError: \(e)")
        }, onCompleted: {
            Log.rxswift.debug("🛠\(tmp)6. do onCompleted")
        }, afterCompleted: {
            Log.rxswift.debug("🛠\(tmp)9. do afterCompleted")
        }, onSubscribe: {
            Log.rxswift.debug("🛠\(tmp)1. do onSubscribe")
        }, onSubscribed: {
            Log.rxswift.debug("🛠\(tmp)2. do onSubscribed")
        }, onDispose: {
            Log.rxswift.debug("🛠\(tmp)10. do onDispose")
        })
    }
    func xl_subscribeTest(_ prefix: String = "") -> RxSwift.Disposable {
        let tmp = prefix.isEmpty ? "" : "「\(prefix)」"
        return self.subscribe { ele in
            Log.rxswift.x_debug("\(tmp)onNext: \(ele)")
        } onError: { error in
            Log.rxswift.x_debug("\(tmp)onError: \(error)")
        } onCompleted: {
            Log.rxswift.debug("\(tmp)onCompleted")
        } onDisposed: {
            Log.rxswift.debug("\(tmp)onDisposed")
        }
    }
}
