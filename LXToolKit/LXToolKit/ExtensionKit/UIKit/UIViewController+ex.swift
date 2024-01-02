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
    func checkViewIsVisible() -> Bool {
        if #available(iOS 7, *) {
            return base.isViewLoaded && base.view.window != nil
        } else {
            return base.viewIfLoaded?.window != nil
        }
    }
}

// MARK: - 👀
extension UIViewController {
    public static func topViewController() -> UIViewController? {
        return getTopVC()
    }
    // MARK: - 查找顶层控制器、
    // 获取顶层控制器 根据window
    public static func getTopVC() -> UIViewController? {
        var window = UIApplication.shared.keyWindow
        // 是否为当前显示的window
        if window?.windowLevel != UIWindow.Level.normal {
            let windows = UIApplication.shared.windows
            for  windowTemp in windows {
                if windowTemp.windowLevel == UIWindow.Level.normal {
                    window = windowTemp
                    break
                }
            }
        }
        let vc = window?.rootViewController
        return getTopVC(withCurrentVC: vc)
    }
    /// 根据控制器获取 顶层控制器
    private static func getTopVC(withCurrentVC vc: UIViewController?) -> UIViewController? {
        if vc == nil {
            print("🌶： 找不到顶层控制器")
            return nil
        }
        if let presentedVC = vc?.presentedViewController {
            // modal出来的 控制器
            return getTopVC(withCurrentVC: presentedVC)
        } else if let tabVC = vc as? UITabBarController {
            // tabBar 的跟控制器
            if let selectVC = tabVC.selectedViewController {
                return getTopVC(withCurrentVC: selectVC)
            }
            return nil
        } else if let nav = vc as? UINavigationController {
            // 控制器是 nav
            if let topVC = nav.topViewController {
                return getTopVC(withCurrentVC: topVC)
            }
            return nav
        } else {
            // 返回顶控制器
            return vc
        }
    }
}
