//
//  UIScrollView + refresh.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2020/12/29.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import MJRefresh
import RxSwift
import RxCocoa

// MARK: - 👀header refresh
extension UIScrollView {
    func addHeaderRefresh() {
        self.mj_header = MJRefreshNormalHeader(refreshingBlock: {
        })
    }
    func addFooterRefresh() {
        self.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
        })
//        self.mj_footer?.isHidden = true
    }
}


// MARK: - 👀
extension Reactive where Base: UITableView {
    var beginReloadData: Binder<Void> {
        return Binder(base) { (table, _) in
            table.reloadData()
        }
    }
}
// MARK: - 👀
extension Reactive where Base: UICollectionView {
    var beginReloadData: Binder<Void> {
        return Binder(base) { (collectionView, _) in
            collectionView.reloadData()
        }
    }
}

// MARK: - 👀footer refresh
extension Reactive where Base: UIScrollView {
    var footerRefresh: ControlEvent<Void> {
        if base.mj_footer == nil {
            base.addFooterRefresh()
        }
        let source: Observable<Void> = Observable.create({ [weak control = self.base.mj_footer] observer in
            if let control = control {
                control.refreshingBlock = {
                    observer.on(.next(()))
                }
            }
            return Disposables.create()
        })
        return  ControlEvent(events: source)
    }
    var footerEndRefresh: Binder<Void> {
        return Binder(base) { (tmp, _) in
            tmp.mj_footer?.endRefreshing()
        }
    }

    var footerEndRefreshWithNoMoreData: Binder<(page: Int, totalPage: Int)> {
        return Binder(base) { (tmp, tuple) in
            if tuple.page > 0 && tuple.page < tuple.totalPage {
                tmp.mj_footer?.isHidden = false
                tmp.mj_footer?.endRefreshingWithNoMoreData()
            } else if tuple.page > 0, tuple.page == tuple.totalPage {
                tmp.mj_footer?.isHidden = false
                tmp.mj_footer?.endRefreshing()
            } else {
                tmp.mj_footer?.isHidden = true
            }
        }
    }
    var footerEndRefreshWithNoMoreDataByPageSize: Binder<(Int, Int)> {
        return Binder(base) { (tmp, value) in
            let tuple = value as (current: Int, pageSize: Int)
            if tuple.current > 0 && tuple.current < tuple.pageSize {
                tmp.mj_footer?.isHidden = false
                tmp.mj_footer?.endRefreshingWithNoMoreData()
            } else if tuple.current > 0, tuple.current == tuple.pageSize {
                tmp.mj_footer?.isHidden = false
                tmp.mj_footer?.endRefreshing()
            } else {
                tmp.mj_footer?.isHidden = true
            }
        }
    }
    var headerRefreshing: Driver<Void> {
        if base.mj_header == nil {
            base.addHeaderRefresh()
        }
        let source: Observable<Void> = Observable
            .create { [weak mj_header = self.base.mj_header] observer in
                if let mj = mj_header {
                    mj.refreshingBlock = {
                        observer.on(.next(()))
                        mj.endRefreshing()
                    }
                }
                return Disposables.create()
        }
        return ControlEvent(events: source).asDriver()
    }
}
