//
//  LXImageTestVC.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2020/10/28.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit

class LXImageTestVC: UIViewController {
    // MARK: 📌UI
    private lazy var imgViewBG: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "sign_bg")// ?.resizableImage(withCapInsets: UIEdgeInsets(top: 300, left: 300, bottom: 300, right: 300), resizingMode: .stretch)
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
    }

}

// MARK: 🌎LoadData
extension LXImageTestVC {}

// MARK: 👀Public Actions
extension LXImageTestVC {}

// MARK: 🔐Private Actions
private extension LXImageTestVC {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXImageTestVC {
    func prepareUI() {
        self.view.backgroundColor = UIColor.white
        // self.title = "<#title#>"

        [imgViewBG].forEach(self.view.addSubview)
        masonry()
    }

    func masonry() {
        imgViewBG.snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview()
        }
    }
}
