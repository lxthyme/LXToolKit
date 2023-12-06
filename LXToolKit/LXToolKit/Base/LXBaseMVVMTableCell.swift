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
    lazy var wrapperView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    lazy var wrapperStackView: UIStackView = {
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

        basePrepareUI()
        baseMasonry()
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

// MARK: 🌎LoadData
extension LXBaseMVVMTableCell {
    @objc func bind(to viewModel: LXBaseMVVMTableCellVM) {}
}

// MARK: 👀Public Actions
extension LXBaseMVVMTableCell {}

// MARK: 🔐Private Actions
private extension LXBaseMVVMTableCell {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXBaseMVVMTableCell {
    func basePrepareUI() {
        layer.masksToBounds = true
        selectionStyle = .none
        
        [self.wrapperView].forEach(self.contentView.addSubview)
        [self.wrapperStackView].forEach(self.contentView.addSubview)
    }

    func baseMasonry() {
        self.snp.setLabel("\(xl.typeNameString)")
        contentView.snp.setLabel("\(self.contentView.xl.typeNameString).contentView")
        wrapperView.snp.setLabel("\(self.wrapperView.xl.typeNameString).wrapperView")
        wrapperStackView.snp.setLabel("\(self.wrapperStackView.xl.typeNameString).wrapperStackView")
        wrapperView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        wrapperStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
