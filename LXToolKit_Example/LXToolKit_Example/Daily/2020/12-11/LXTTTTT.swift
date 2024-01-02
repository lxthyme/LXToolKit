//
//  LXTTTTT.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2020/12/11.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class LXTTTTT: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
    }

}

// MARK: 🌎LoadData
extension LXTTTTT {}

// MARK: 👀Public Actions
extension LXTTTTT {}

// MARK: 🔐Private Actions
private extension LXTTTTT {
    func test() {
        let tableview = UITableView()
        let maxY = tableview.frame.maxY
        let ips = tableview
            .visibleCells
            // .map { (cell: $0, rect: $0.superview?.convert($0.frame, to: self.view )) }
            .map { cell -> (cell: UITableViewCell, rect: CGRect?) in (cell: cell, rect: cell.superview?.convert(cell.frame, to: self.view )) }
            .map { res -> (cell: UITableViewCell, visible: CGFloat, height: CGFloat) in
                guard let frame = res.rect else {
                    return (cell: res.cell, visible: 0, height: 0)
                }
                var h: CGFloat = frame.size.height
                if frame.origin.y < 0 {
                    h -= frame.origin.y
                }
                if frame.maxY > maxY {
                    h -= frame.maxY - maxY
                }
                return (cell: res.cell, visible: h, height: frame.size.height)
            }
            .filter { $0.visible >= ($0.height * 2 / 3) }
            .map { $0.cell }

        print("ips: \(ips)")
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXTTTTT {
    func prepareUI() {
        self.view.backgroundColor = UIColor.white
        // self.title = "<#title#>"

        // [<#table#>].forEach(self.view.addSubview)
        masonry()
    }

    func masonry() {}
}
