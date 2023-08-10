//
//  LXBadgeSupplementaryView.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/8/9.
//
import UIKit

class LXBadgeSupplementaryView: UICollectionReusableView {
    // MARK: 📌UI
    lazy var labTitle: UILabel = {
        let lab = UILabel()
        lab.text = ""
        lab.textColor = .black
        lab.font = .preferredFont(forTextStyle: .body)
        lab.numberOfLines = 1
        lab.lineBreakMode = .byTruncatingTail
        lab.textAlignment = .center
        lab.adjustsFontForContentSizeCategory = true
        return lab
    }()
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    // MARK: 🔗Vaiables
    override init(frame: CGRect) {
        super.init(frame: frame)

        prepareUI()
    }
    open override func prepareForReuse() {
        super.prepareForReuse()
    }
}

// MARK: 👀Public Actions
extension LXBadgeSupplementaryView {}

// MARK: 🔐Private Actions
private extension LXBadgeSupplementaryView {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXBadgeSupplementaryView {
    func prepareUI() {
        self.backgroundColor = .green
        self.layer.masksToBounds = true
        self.layer.cornerRadius = bounds.width / 2.0
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1.0

        [labTitle].forEach(self.addSubview)

        masonry()
    }

    func masonry() {
        labTitle.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
