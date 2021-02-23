//
//  LXCubeFaceView.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/2/23.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class LXCubeFaceView: UIView {
    // MARK: 📌UI
    private lazy var labTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 40)
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    // MARK: 🔗Vaiables
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override private init(frame: CGRect) {
        super.init(frame: frame)

        prepareUI()
    }
    convenience init(idx: Int) {
        self.init(frame: .zero)
        labTitle.text = "\(idx)"
    }

}

// MARK: 🌎LoadData
extension LXCubeFaceView {}

// MARK: 👀Public Actions
extension LXCubeFaceView {}

// MARK: 🔐Private Actions
private extension LXCubeFaceView {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXCubeFaceView {
    func prepareUI() {
        self.backgroundColor = UIColor.white
        // self.title = "<#title#>"

        [labTitle].forEach(self.addSubview)
        masonry()
    }

    func masonry() {
        labTitle.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
