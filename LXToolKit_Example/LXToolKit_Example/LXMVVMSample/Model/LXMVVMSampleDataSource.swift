//
//  LXMVVMSampleDataSource.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/9/28.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
import UIKit
import LXToolKit

// typealias LXDidSelectRowAt = (_ indexPath: IndexPath) ->Void

class LXMVVMSampleDataSource: NSObject {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
//    var dataList: [LXMVVMSampleDataSourceModel]
    var didSelectRowAt: LXDidSelectRowAt?
//    private override init() {
//        self.dataList = []
//    }
//    init(with dataList: [LXMVVMSampleDataSourceModel]) {
//        self.dataList = dataList
//        super.init()
//    }
}

// MARK: 👀Public Actions
extension LXMVVMSampleDataSource {}

// MARK: 🔐Private Actions
private extension LXMVVMSampleDataSource {}

// MARK: - UITableViewDataSource
// extension LXMVVMSampleDataSource: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return dataList.count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath)
//        let item = dataList[indexPath.row]
//        cell.textLabel?.text = item.debugDescription
//        return cell
//    }
// }
// MARK: - UITableViewDelegate
// extension LXMVVMSampleDataSource: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        didSelectRowAt?(indexPath)
//    }
// }
