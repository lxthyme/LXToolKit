//
//  LXBaseVC.swift
//  SwiftPro
//
//  Created by DamonJow on 2018/10/26.
//  Copyright © 2018 DamonJow. All rights reserved.
//

import UIKit

open class LXBaseVC: UIViewController {
    deinit {
        dlog("---------- >>>VC: \(self.xl_typeName)\t\tdeinit <<<----------")
    }
    // MARK: - lazy vars
    public lazy var table: UITableView = {
        return lazyTableView(style: .plain)
    }()
//    lazy var dataList: [Any] = {
//        let ds = Array(repeating: "", count: 20)
//        return ds
//    }()
    // MARK: - initialize
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
////        dlog("---------- \(self.xl_typeName).Xib\t\tinit ----------")
//    }
//    public required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
////        dlog("---------- \(self.xl_typeName)\t\tinit ----------")
//    }
    // MARK: - Life Cycle
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //        dlog("")
    //    }
    //    override func viewDidAppear(_ animated: Bool) {
    //        super.viewDidAppear(animated)
    //        dlog("")
    //    }
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //        dlog("")
    //    }
    //    override func viewWillDisappear(_ animated: Bool) {
    //        super.viewWillDisappear(animated)
    //        dlog("")
    //    }
    //    override func viewDidDisappear(_ animated: Bool) {
    //        super.viewDidDisappear(animated)
    //        dlog("")
    //    }
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
//        self.edgesForExtendedLayout = []
    }
    override open func value(forUndefinedKey key: String) -> Any? {
        dlog("value:forUndefinedKey:::: \(key))")
        return nil
    }
    override open func setValue(_ value: Any?, forUndefinedKey key: String) {
        super.setValue(value, forUndefinedKey: key)

        dlog("setValue:forUndefinedKey:::: (\(key): \(value ?? ""))")
    }
}

extension LXBaseVC {}

// MARK: - UITableView init
private extension LXBaseVC {
    func lazyTableView(style: UITableView.Style) ->UITableView {
        let t = UITableView(frame: .zero, style: style)
        t.rowHeight = UITableView.automaticDimension
        t.estimatedRowHeight = UITableView.automaticDimension
        t.estimatedSectionHeaderHeight = 0
        t.estimatedSectionFooterHeight = 0
        t.sectionHeaderHeight = 0
        t.sectionFooterHeight = 0
        t.backgroundColor = .white
        t.separatorStyle = .none

//        t.delegate = self
//        t.dataSource = self

        return t
    }
    func lazyLayout() ->UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = .zero
        layout.estimatedItemSize = .zero
//        layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        layout.scrollDirection = .horizontal
        layout.headerReferenceSize = .zero
        layout.footerReferenceSize = .zero
        layout.sectionInset = .zero
        if #available(iOS 11.0, *) {
            layout.sectionInsetReference = .fromContentInset
        }
        layout.sectionHeadersPinToVisibleBounds = true
        layout.sectionFootersPinToVisibleBounds = true

        return layout
    }
    func lazyCollectionView(frame: CGRect = .zero, collectionViewLayout layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()) ->UICollectionView {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.dataSource = self
//        cv.delegate = self
//        cv.prefetchDataSource
        return cv
    }
}
