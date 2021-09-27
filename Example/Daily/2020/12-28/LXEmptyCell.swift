//
//  LXEmptyCell.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/1/10.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class LXEmptyCell: UICollectionViewCell {
    // MARK: 📌UI
    private lazy var emptyView: RetryView = {
        let v = RetryView()
        return v
    }()
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    // MARK: 🔗Vaiables
    var retryType: LXEmptyType = .success {
        didSet {
            emptyView.retryType = retryType
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)

        prepareUI()
    }
    open override func prepareForReuse() {
        super.prepareForReuse()
    }
}

// MARK: 👀Public Actions
extension LXEmptyCell {}

// MARK: 🔐Private Actions
private extension LXEmptyCell {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXEmptyCell {
    func prepareUI() {
        [emptyView].forEach(self.contentView.addSubview)
        masonry()
    }

    func masonry() {
        emptyView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
