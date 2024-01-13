//
//  LXOutlineParamCell.swift
//  DJTest
//
//  Created by lxthyme on 2024/1/13.
//
import UIKit
import RxSwift

@available(iOS 14.0, *)
class LXOutlineParamCell: UICollectionViewListCell {
    // MARK: 📌UI
    private lazy var btnTitle: UIButton = {
        let btn = UIButton(type: .custom)
        btn.contentEdgeInsets = UIEdgeInsets(horizontal: 10, vertical: 6)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.layer.masksToBounds = true

        return btn
    }()
    private lazy var tfTextField: UITextField = {
        let v = UITextField()
        v.placeholder = ""
        v.font = .systemFont(ofSize: 16)
        v.textColor = .black
        v.textAlignment = .left
        v.borderStyle = .roundedRect
        v.clearButtonMode = .whileEditing
        v.keyboardType = .default
        v.autocapitalizationType = .none
        // v.attributedPlaceholder = NSAttributedString(string: <#T##String#>, attributes: <#T##[NSAttributedString.Key : Any]?#>)
        return v
    }()
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    // MARK: 🔗Vaiables
    private var currentSelected = ""
    var currentValue: String {
        return tfTextField.text ?? ""
    }
    override init(frame: CGRect) {
        super.init(frame: frame)

        prepareUI()
    }
    open override func prepareForReuse() {
        super.prepareForReuse()
    }
}

// MARK: 🌎LoadData
@available(iOS 14.0, *)
extension LXOutlineParamCell {
    func dataFill(title: String, placeholder: String?, defaultValue: String? = nil) {
        btnTitle.setTitle(title, for: .normal)
        tfTextField.placeholder = placeholder
        tfTextField.text = defaultValue?.components(separatedBy: "/").first
        if #available(iOS 15.0, *),
           let defaultValue {
            configBtn(title: title, defaultValue: defaultValue)
        }
    }
    @available(iOS 15.0, *)
    func configBtn(title: String, defaultValue: String) {
        let menuList = defaultValue
            .components(separatedBy: ",")
        let subitems = menuList
            .map {[weak self] item in
                UIAction(title: item, state: self?.currentSelected == item ? .on : .off) { _ in
                    self?.tfTextField.text = item
                }
            }
        if subitems.isNotEmpty {
            toggleBtnStyle(hasMenu: true)
            let opt: UIMenu.Options = .singleSelection
            btnTitle.showsMenuAsPrimaryAction = true
            btnTitle.menu = UIMenu(title: title, options: opt, children: subitems)

            tfTextField.text = menuList.first
            currentSelected = menuList.first ?? ""
        } else {
            toggleBtnStyle(hasMenu: false)
        }
    }
}

// MARK: 👀Public Actions
@available(iOS 14.0, *)
extension LXOutlineParamCell {}

// MARK: 🔐Private Actions
@available(iOS 14.0, *)
private extension LXOutlineParamCell {
    func toggleBtnStyle(hasMenu: Bool) {
        if hasMenu {
            btnTitle.layer.cornerRadius = 8
            btnTitle.setTitleColor(.XL.randomLight, for: .normal)
            let bgColor: UIColor = .XL.randomGolden
            btnTitle.setBackgroundColor(color: bgColor, forState: .normal)
            btnTitle.setBackgroundColor(color: bgColor.withAlphaComponent(0.5), forState: .highlighted)
        } else {
            btnTitle.layer.cornerRadius = 0
            btnTitle.setTitleColor(.XL.randomGolden, for: .normal)
            btnTitle.setBackgroundColor(color: .white, forState: .normal)
        }
    }
}

// MARK: - 🍺UI Prepare & Masonry
@available(iOS 14.0, *)
private extension LXOutlineParamCell {
    func prepareUI() {
        // self.contentView.backgroundColor = .white

        [btnTitle, tfTextField].forEach(self.contentView.addSubview)
        btnTitle.xl.setHorizontalHuggingAndCompressionResistance()
        masonry()
    }

    func masonry() {
        btnTitle.snp.makeConstraints {
            $0.left.equalToSuperview().offset(15)
            $0.centerY.equalToSuperview()
        }
        tfTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.equalTo(btnTitle.snp.right).offset(10)
            $0.right.equalToSuperview().offset(-15)
            $0.bottom.equalToSuperview().offset(-10)
            $0.height.equalTo(35)
        }
    }
}
