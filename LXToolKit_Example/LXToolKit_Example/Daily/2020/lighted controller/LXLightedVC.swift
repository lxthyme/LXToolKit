//
//  LXLightedVC.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/8/11.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import LXToolKit

private class MyView: UIView {
    // MARK: UI
    lazy var table: UITableView = {
        let t = UITableView(frame: .zero, style: .plain)
        t.rowHeight = UITableView.automaticDimension
        t.estimatedRowHeight = 0
        t.estimatedSectionHeaderHeight = 0
        t.estimatedSectionFooterHeight = 0
        t.sectionHeaderHeight = 0
        t.sectionFooterHeight = 0

        t.backgroundColor = .white
        t.separatorStyle = .none

        //        t.delegate = self
        //        t.dataSource = self

        t.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.XL.reuseIdentifier)

        return t
    }()
    // MARK: Vaiables
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(frame: CGRect) {
        super.init(frame: frame)

        prepareUI()
    }

}

// MARK: LoadData
extension MyView {}

// MARK: Public Actions
extension MyView {}

// MARK: Private Actions
private extension MyView {}

// MARK: - UI Prepare & Masonry
private extension MyView {
    func prepareUI() {
        self.backgroundColor = .white
        [table].forEach(self.addSubview)
        masonry()
    }

    func masonry() {
        table.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

class LXLightedVC: LXBaseVC {
    private typealias CustomView = MyView
    // MARK: UI
    private lazy var myView: CustomView = {
        return CustomView()
    }()
    // MARK: Vaiables
    private lazy var dataSource: LXLightedDataSource = {
        let ds = LXLightedDataSource(with: [])
        ds.didSelectRowAt = { indexPath in
            dlog("indexPath: ", indexPath)
        }
        return ds
    }()
    // MARK: Life Cycle
    override func loadView() {
        view = myView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
        prepareTable()
    }
}

// MARK: LoadData
extension LXLightedVC {
    /// 触摸事件
    // override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {}
    // override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {}
    // override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {}
    // override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {}
    //
    // /// 按压事件
    // override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {}
    // override func pressesChanged(_ presses: Set<UIPress>, with event: UIPressesEvent?) {}
    // override func pressesCancelled(_ presses: Set<UIPress>, with event: UIPressesEvent?) {}
    // override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {}
    //
    // /// 运动事件
    // override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {}
    // override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {}
    // override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {}
}

// MARK: Public Actions
extension LXLightedVC {}

// MARK: Private Actions
private extension LXLightedVC {}

// MARK: - UI Prepare & Masonry
private extension LXLightedVC {
    func prepareTable() {
        let photos = LXListItemModel().sortedPhotos()
        dataSource.dataList = photos
        myView.table.dataSource = dataSource
        myView.table.delegate = dataSource
    }
    func prepareUI() {
        // [<#table#>].forEach(self.view.addSubview)
        masonry()
    }

    func masonry() {}
}
