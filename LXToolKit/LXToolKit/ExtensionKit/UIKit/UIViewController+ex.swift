//
//  UIViewController + getTopVC.swift
//  Alamofire
//
//  Created by LXThyme Jason on 2020/9/7.
//

import Foundation

// MARK: - 👀
public extension Swifty where Base: UIViewController {
    /// viewWillAppear 时恢复 collectionView 的选中状态
    func restoreSelectedStatus(with collectionView: UICollectionView, animated: Bool) {
        if let indexPath = collectionView.indexPathsForSelectedItems?.first {
            if let coordinator = base.transitionCoordinator {
                coordinator.animate(alongsideTransition: { context in
                    collectionView.deselectItem(at: indexPath, animated: true)
                }) { (context) in
                    if context.isCancelled {
                        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
                    }
                }
            } else {
                collectionView.deselectItem(at: indexPath, animated: animated)
            }
        }
    }
    /// viewWillAppear 时恢复 tableView 的选中状态
    func restoreSelectedStatus(with tableView: UITableView, animated: Bool) {
        if let indexPath = tableView.indexPathForSelectedRow {
            if let coordinator = base.transitionCoordinator {
                coordinator.animate(alongsideTransition: { context in
                    tableView.deselectRow(at: indexPath, animated: true)
                }) { (context) in
                    if context.isCancelled {
                        tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                    }
                }
            } else {
                tableView.deselectRow(at: indexPath, animated: animated)
            }
        }
    }
}

// MARK: - 👀检测 ViewController 是否可见
public extension Swifty where Base: UIViewController {
    /// 检测 ViewController 是否可见
    /// - Returns: boolean
    func checkViewIsVisible() ->Bool {
        if #available(iOS 7, *) {
            return base.isViewLoaded && base.view.window != nil
        } else {
            return base.viewIfLoaded?.window != nil
        }
    }
}
