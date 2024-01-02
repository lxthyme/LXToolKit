//
//  LXLightedDataSource.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/8/11.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import LXToolKit

typealias LXCellConfigureBlock = (_ cell: UITableViewCell, _ item: AnyObject) -> Void
typealias LXDidSelectRowAt = (_ indexPath: IndexPath) -> Void

class LXLightedDataSource: NSObject {
    // MARK: UI
    // MARK: Vaiables
    var dataList: [LXListItemModel.Photo]
//    private var configureCellBlock: LXCellConfigureBlock
    var didSelectRowAt: LXDidSelectRowAt?
//    private override init() {
//        self.dataList = []
//        self.cellIdentifier = ""
//        let block: LXCellConfigureBlock = {(_, _) in  }
//        self.configureCellBlock = block
//    }
    init(with dataList: [LXListItemModel.Photo]/**, configureCellBlock: @escaping LXCellConfigureBlock*/) {
        self.dataList = dataList
//        self.configureCellBlock = configureCellBlock
        super.init()
    }
}

// MARK: Public Actions
extension LXLightedDataSource {}

// MARK: Private Actions
private extension LXLightedDataSource {}

// MARK: - UITableViewDataSource
extension LXLightedDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.XL.reuseIdentifier, for: indexPath)
        let item = dataList[indexPath.row]
        cell.textLabel?.text = item.name
        if let d = item.creationDate {
            cell.detailTextLabel?.text = DateFormatter.xl.formatter.string(from: d)
        }
        return cell
    }
}
// MARK: - UITableViewDelegate
extension LXLightedDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        didSelectRowAt?(indexPath)
    }
}
