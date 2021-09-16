//
//  HUD + Observable.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2020/12/28.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import RxSwift
import Toast_Swift
import SVProgressHUD

// MARK: - 👀
extension ObservableType {
    func subscribeOnShowLoadingInWindow() -> Disposable {
        subscribe { _ in
            DispatchQueue.main.async {
                SVProgressHUD.show()
            }
        }
    }
    func subscribeOnHideLoadingInWindow() -> Disposable {
        subscribe { _ in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                if let vc = UIViewController.getTopVC() {
                    vc.view.endEditing(true)
                }
            }
        }
    }

    func showLoading() ->Observable<Element> {
        `do` { _ in
            DispatchQueue.main.async {
                SVProgressHUD.show()
            }
        }
    }
    func hideLoading() ->Observable<Element> {
        `do` { _ in
            SVProgressHUD.dismiss()
            if let vc = UIViewController.getTopVC() {
                vc.view.endEditing(true)
            }
        }
    }

    func show(_ text: String) ->Observable<Element> {
        `do` { _ in
            UIApplication.shared.keyWindow?.makeToast(text)
        }
    }

    func subscribeOnShowToast(_ text: String) ->Disposable {
        subscribe { _ in
            UIApplication.shared.keyWindow?.makeToast(text)
        }
    }
}
