//
//  LXBaseTableViewCell.swift
//  test
//
//  Created by lxthyme on 2023/3/26.
//
import UIKit

@objc(LXBaseSwiftTableViewCell)
open class LXBaseTableViewCell: UITableViewCell {
    // MARK: 📌UI
    public lazy var containerView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        // v.cornerRadius = AppConfig.BaseDimensions.cornerRadius
        return v
    }()
    public lazy var containerStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .horizontal
        v.alignment = .center
        return v
    }()
    // MARK: 🔗Vaiables
    // var inset: CGFloat = AppConfig.BaseDimensions.inset
    public var inset: CGFloat = 6
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
        backgroundColor = selected ? selectionColor : .clear
    }
}

// MARK: 🌎LoadData
extension LXBaseTableViewCell {
    @objc open func bind(to vm: LXBaseTableViewCellVM) {}
}

// MARK: 👀Public Actions
extension LXBaseTableViewCell {}

// MARK: 🔐Private Actions
private extension LXBaseTableViewCell {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXBaseTableViewCell {
    func basePrepareVM() {}
    func basePrepareUI() {
        self.contentView.backgroundColor = .white
        selectionStyle = .none
        selectionColor = .clear
        
        // theme.selectionColor = themeService.attribute { $0.primary }
        // containerView.theme.backgroundColor = themeService.attribute { $0.primary }
        
        containerView.addSubview(containerStackView)
        self.contentView.addSubview(containerView)
    }
    
    func baseMasonry() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(horizontal: self.inset, vertical: self.inset / 2))
        }
        containerStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(self.inset / 2)
        }
    }
}
