//
//  LXBaseTableViewCell.swift
//  test
//
//  Created by lxthyme on 2023/3/26.
//
import UIKit

@objc(LXBaseSwiftTableViewCell)
open class LXBaseTableViewCell: UITableViewCell {
    deinit {
        LogKit.traceLifeCycle(.TableViewCell, typeName: xl.typeNameString, type: .deinit)
    }
    // MARK: 📌UI
    public lazy var wrapperView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    public lazy var wrapperStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.alignment = .center
        return v
    }()
    // MARK: 🔗Vaiables
    public var isSelection = false
    public var selectionColor: UIColor? {
        didSet {
            setSelected(isSelected, animated: true)
        }
    }
    // MARK: 🛠Life Cycle
    public required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        basePrepareVM()
        basePrepareUI()
        baseMasonry()
    }
    open override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    open override func prepareForReuse() {
        super.prepareForReuse()
    }
    open override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        contentView.backgroundColor = selected ? selectionColor : .clear
    }
}

// MARK: 🌎LoadData
extension LXBaseTableViewCell {
    @objc open func bind(to viewModel: LXBaseTableViewCellVM) {}
}

// MARK: 👀Public Actions
extension LXBaseTableViewCell {}

// MARK: 🔐Private Actions
private extension LXBaseTableViewCell {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXBaseTableViewCell {
    func basePrepareVM() {}
    func basePrepareUI() {
        contentView.backgroundColor = .white
        selectionStyle = .none
        selectionColor = .clear
        
        // theme.selectionColor = themeService.attribute { $0.primary }
        // containerView.theme.backgroundColor = themeService.attribute { $0.primary }
        
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
