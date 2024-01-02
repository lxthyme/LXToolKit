//
//  LXStackMessageVC.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2020/12/1.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit

class LXStackMessageVC: UIViewController {
    // MARK: 📌UI
    private lazy var table: UITableView = {
        let t = UITableView(frame: .zero, style: .plain)
        t.rowHeight = UITableView.automaticDimension
        t.estimatedRowHeight = 0
        t.estimatedSectionHeaderHeight = 0
        t.estimatedSectionFooterHeight = 0
        t.sectionHeaderHeight = 0
        t.sectionFooterHeight = 0

        t.backgroundColor = .white
        t.separatorStyle = .none

        t.delegate = self
        t.dataSource = self

//        t.register(LXMessageCell.self, forCellReuseIdentifier: LXMessageCell.reuseIdentifier)
        t.register(UINib(nibName: LXMessageCell.XL.typeNameString, bundle: nil), forCellReuseIdentifier: LXMessageCell.XL.reuseIdentifier)

        return t
    }()
    private lazy var imgViewPointsTips: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = .cyan
        iv.contentScaleFactor = UIScreen.main.scale
        return iv
    }()
    lazy var dataList: [String] = {
        let ds = Array(repeating: "", count: 10)
        return ds
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        prepareUI()
    }

}

// MARK: 🌎LoadData
extension LXStackMessageVC {}

// MARK: 👀Public Actions
extension LXStackMessageVC {}

// MARK: 🔐Private Actions
private extension LXStackMessageVC {}

// MARK: - ✈️UITableViewDataSource
extension LXStackMessageVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LXMessageCell.XL.reuseIdentifier, for: indexPath) as? LXMessageCell else {
            return LXMessageCell(style: .default, reuseIdentifier: LXMessageCell.XL.reuseIdentifier)
        }
        if indexPath.row % 6 == 0 {
        } else if indexPath.row % 6 == 1 {
            cell.logoStackView.isHidden = true
        } else if indexPath.row % 6 == 2 {
            cell.imgViewLogo.isHidden = true
        } else if indexPath.row % 6 == 3 {
            cell.contentStackView.isHidden = true
        } else if indexPath.row % 6 == 4 {
            cell.textViewContent.isHidden = true
        } else if indexPath.row % 6 == 5 {
            cell.bottomStackView.isHidden = true
        }
        return cell
    }
}
// MARK: - ✈️UITableViewDelegate
extension LXStackMessageVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXStackMessageVC {
    func prepareUI() {
        self.view.backgroundColor = .white
        // self.title = "<#title#>"

        [table, imgViewPointsTips].forEach(self.view.addSubview)
//        imgViewPointsTips.image = UIImage(named: "new")
        let iv = UIImageView()
        iv.sd_setImage(with: URL(string: "http://duly5zwcucles.cloudfront.net/icon/new.png")) { [self] (image, error, type, url) in
            print("")
            print("iv: \(iv)")
            imgViewPointsTips.image = image
//            if let size = image?.size {
//                let width = 22 * size.width / size.height
//                self.imgViewPointsTips.snp.remakeConstraints {
//                    $0.centerY.right.equalToSuperview()
//                    $0.height.equalTo(22)
//                    $0.width.equalTo(width)
//                }
//            }
        }
        masonry()
    }

    func masonry() {
//        table.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//        imgViewPointsTips.setContentHuggingPriority(.required, for: .horizontal)
        imgViewPointsTips.setContentCompressionResistancePriority(.required, for: .horizontal)
        imgViewPointsTips.snp.makeConstraints {
            $0.centerY.right.equalToSuperview()
            $0.height.equalTo(22)
        }
    }
}
