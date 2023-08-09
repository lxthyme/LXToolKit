//
//  LXTextCell.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/8/8.
//
import UIKit

class LXTextCell: UICollectionViewCell {
    // MARK: 📌UI
    lazy var labTitle: UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .caption1)
        return label
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

// MARK: 🌎LoadData
extension LXTextCell {
    // func dataFill(_ title: String) {
    //     labTitle.text = title
    // }
}

// MARK: 👀Public Actions
extension LXTextCell {}

// MARK: 🔐Private Actions
private extension LXTextCell {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXTextCell {
    func prepareUI() {
        self.contentView.backgroundColor = .white

        [labTitle].forEach(self.contentView.addSubview)

        masonry()
    }

    func masonry() {
        labTitle.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10.0)
        }
    }
}
