//
//  LXBaseMVVMTableCell.swift
//  LXMVVMTest
//
//  Created by lxthyme on 2022/2/10.
//

import UIKit
import RxSwift
import RxCocoa

class LXBaseMVVMTableCell: UITableViewCell {
    // MARK: 📌UI
    lazy var contentStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.alignment = .center
        return v
    }()
    // MARK: 🔗Vaiables
    var cellDisposeBag = DisposeBag()

    var isSelection = false
    var selectionColor: UIColor? {
        didSet {
            setSelected(isSelected, animated: true)
        }
    }
    // MARK: 🛠Life Cycle
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        prepareUI()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    open override func prepareForReuse() {
        super.prepareForReuse()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.contentView.backgroundColor = selected ? selectionColor : .clear
    }

}

// MARK: 👀Public Actions
extension LXBaseMVVMTableCell {
    func bind(to viewModel: LXBaseMVVMTableCellVM) {}
}

// MARK: 🔐Private Actions
private extension LXBaseMVVMTableCell {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXBaseMVVMTableCell {
    func prepareUI() {
        layer.masksToBounds = true
        selectionStyle = .none
        self.contentView.backgroundColor = .clear

        // [<#table#>].forEach(self.contentView.addSubview)

        masonry()
    }

    func masonry() {
        contentStackView.snp.setLabel("\(self.xl.xl_typeName).contentStackView")
    }
}
