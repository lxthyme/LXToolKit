//
//  LXLabelVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/8/24.
//
import UIKit

class LXLabelVC: LXBaseVC {
    // MARK: 📌UI
    private lazy var wrapperStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.alignment = .fill
        // sv.distribution = <#.fillProportionally#>
        v.spacing = 10
        return v
    }()
    private lazy var logoView: UIView = {
        let v = UIView()
        v.backgroundColor = .red
        return v
    }()
    private lazy var imgViewLogo: UIImageView = {
        let iv = UIImageView()
        iv.image = R.image.cusco()
        // iv.backgroundColor =
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    private lazy var cornerView: UIView = {
        let v = UIView()
        // v.backgroundColor = .cyan.withAlphaComponent(0.3)
        v.backgroundColor = .red
        v.layer.cornerRadius = 12
        v.layer.cornerCurve = .continuous
        v.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        // v.layer.masksToBounds = true
        return v
    }()
    private lazy var labTitle1: UILabel = {
        let label = createFactoryLabel()
        label.layer.cornerRadius = 16
        // label.layer.cornerCurve = .continuous
        label.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        label.clipsToBounds = true
        // label.layer.masksToBounds = true
        return label
    }()
    private lazy var labTitle2: UILabel = {
        let label = createFactoryLabel()
        label.layer.cornerRadius = 16
        // label.layer.cornerCurve = .continuous
        label.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        // label.layer.masksToBounds = true
        return label
    }()
    private lazy var labTitle3: UILabel = {
        let label = createFactoryLabel()
        label.layer.cornerRadius = 16
        label.layer.cornerCurve = .continuous
        label.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        return label
    }()
    private lazy var labTitle4: UILabel = {
        let label = createFactoryLabel()
        label.layer.cornerRadius = 16
        label.layer.cornerCurve = .continuous
        label.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        label.layer.masksToBounds = true
        return label
    }()
    private lazy var labTitle5: UILabel = {
        let label = createFactoryLabel()
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    private lazy var tvTitle1: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.font = .systemFont(ofSize: 14)
        tv.textColor = .black
        tv.backgroundColor = .cyan.withAlphaComponent(0.3)
        tv.textAlignment = .left
        tv.returnKeyType = .default
        tv.keyboardType = .default
        tv.textContainer.maximumNumberOfLines = 1
        tv.textContainer.lineBreakMode = .byTruncatingTail
        tv.contentInset = .zero
        let padding = tv.textContainer.lineFragmentPadding
        tv.textContainerInset = UIEdgeInsets(top: 0, left: -padding, bottom: 0, right: -padding)
        return tv
    }()
    private lazy var tvTitle2: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.font = .systemFont(ofSize: 14)
        tv.textColor = .black
        tv.backgroundColor = .cyan.withAlphaComponent(0.3)
        tv.textAlignment = .left
        tv.returnKeyType = .default
        tv.keyboardType = .default
        tv.textContainer.maximumNumberOfLines = 0
        tv.textContainer.lineBreakMode = .byCharWrapping
        tv.contentInset = .zero
        let padding = tv.textContainer.lineFragmentPadding
        tv.textContainerInset = UIEdgeInsets(top: 0, left: -padding, bottom: 0, right: -padding)
        return tv
    }()
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // labTitle4.xl.setRoundingCorners(raddi: 35, corners: [.topRight, .bottomRight])
    }

}

// MARK: 🌎LoadData
extension LXLabelVC {}

// MARK: 👀Public Actions
extension LXLabelVC {}

// MARK: 🔐Private Actions
private extension LXLabelVC {
    func createFactoryLabel() -> UILabel {
        let label = UILabel()
        label.text = "进口大串香蕉 重约900-1000g"
        label.font = .systemFont(ofSize: 14)
        label.backgroundColor = .cyan.withAlphaComponent(0.3)
        label.textColor = .black
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left
        // label.adjustsFontForContentSizeCategory = true
        // label.layer.borderColor = UIColor.cyan.cgColor;
        // label.layer.borderWidth = 1.0
        return label
    }
}
extension CACornerMask {
    static func alongEdge(_ edge: CGRectEdge) -> CACornerMask {
        switch edge {
        case .maxXEdge: return [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        case .maxYEdge: return [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        case .minXEdge: return [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        case .minYEdge: return [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
    }
}
// MARK: - 🍺UI Prepare & Masonry
extension LXLabelVC {
    override func prepareUI() {
        super.prepareUI()
        self.view.backgroundColor = .white
        // navigationItem.title = ""


        let text = "进口大串香蕉 重约900-1000g"
        // labTitle1.text = text
        // labTitle2.text = "2: \(text)"
        // labTitle3.text = "3: \(text)"
        // labTitle4.text = "4: \(text)"
        // labTitle5.text = "5: \(text)"
        labTitle3.numberOfLines = 1
        labTitle4.numberOfLines = 1
        labTitle5.numberOfLines = 1
        tvTitle1.text = text
        tvTitle2.text = text

        labTitle5.layer.maskedCorners = cornerView.layer.maskedCorners//.intersection(.alongEdge(.maxXEdge))
        labTitle5.layer.cornerCurve = cornerView.layer.cornerCurve
        cornerView.addSubview(labTitle5)
        [
            cornerView,
            imgViewLogo,
            labTitle1, labTitle2, labTitle3, labTitle4,
            tvTitle1, tvTitle2,
        ].forEach(self.wrapperStackView.addArrangedSubview)
        [self.wrapperStackView].forEach(self.view.addSubview)

        masonry()
        imgViewLogo.xl.setHorizontalHuggingAndCompressionResistance()
    }

    override func masonry() {
        super.masonry()
        wrapperStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(175)
        }
        imgViewLogo.snp.makeConstraints {
            $0.height.equalTo(100)
        }
        // labTitle4.snp.makeConstraints {
        //     $0.height.equalTo(20)
        // }
        // labTitle5.snp.makeConstraints {
        //     $0.height.equalTo(20)
        // }
        // tvTitle1.snp.makeConstraints {
        //     $0.height.equalTo(20)
        // }
        // tvTitle2.snp.makeConstraints {
        //     $0.height.equalTo(20)
        // }
        // wrapperStackView.arrangedSubviews.forEach { view in
        //     if view.isMember(of: UIImageView.self) {
        //         view.snp.makeConstraints {
        //             $0.height.equalTo(100)
        //         }
        //     } else if view.isMember(of: UILabel.self) {
        //         // view.snp.makeConstraints {
        //         //     $0.height.greaterThanOrEqualTo(22)
        //         // }
        //     } else {
        //         dlog("-->view: \(view)")
        //     }
        // }
    }
}
