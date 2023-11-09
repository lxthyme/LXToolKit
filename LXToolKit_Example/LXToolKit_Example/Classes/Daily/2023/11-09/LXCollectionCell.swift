//
//  LXCollectionCell.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/11/9.
//
import UIKit

class LXCollectionCell: UICollectionViewCell {
    // MARK: 📌UI
    private lazy var labTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        // label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        label.layer.borderWidth = 0.5
        label.layer.borderColor = UIColor.cyan.cgColor
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
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
extension LXCollectionCell {
    public func dataFill(_ title: String) {
        labTitle.text = title
    }
}

// MARK: 👀Public Actions
extension LXCollectionCell {}

// MARK: 🔐Private Actions
private extension LXCollectionCell {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXCollectionCell {
    func prepareUI() {
        self.contentView.backgroundColor = .white

        [labTitle].forEach(self.contentView.addSubview)

        masonry()
    }

    func masonry() {
        labTitle.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
