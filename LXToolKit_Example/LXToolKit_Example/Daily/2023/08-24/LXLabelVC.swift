//
//  LXLabelVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/8/24.
//
import UIKit
import RxSwift

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
        iv.layer.masksToBounds = true
        return iv
    }()
    private lazy var cornerView: UIView = {
        let v = UIView()
        // v.backgroundColor = .cyan.withAlphaComponent(0.3)
        v.backgroundColor = .red
        v.layer.cornerRadius = 12
        v.layer.cornerCurve = .continuous
        v.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        v.layer.masksToBounds = true
        return v
    }()
    private lazy var labTitle1: UILabel = {
        let label = createFactoryLabel()
        label.layer.cornerRadius = 16
        // label.layer.cornerCurve = .continuous
        label.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        label.layer.masksToBounds = true
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
    private lazy var imgViewLogo2: UIImageView = {
        let iv = UIImageView()
        // iv.image = R.image.cusco()
        iv.sd_setImage(with: URL(string: "https://unsplash.it/400/400/?random")) { img, error, type, url in
            dlog("""
                 img: \(img)
                 error: \(error)
                 type: \(type)
                 url: \(url)
                 """)
        }
        iv.layer.cornerRadius = 16
        // label.layer.cornerCurve = .continuous
        iv.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        iv.backgroundColor = .red
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    private lazy var logo2View: UIView = {
        let v = UIView()
        v.backgroundColor = .cyan
        return v
    }()
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()

        // self.labTitle1.rx.observe(\.bounds)
        // // .debounce(.milliseconds(300), scheduler: ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global()))
        //     .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
        //     .subscribe(on: MainScheduler.instance)
        //     .subscribe {[weak self] size in
        //         dlog("-->size: \(size)\t\(Thread.current)")
        //         self?.labTitle1.xl.setRoundingCorners(raddi: 35, corners: [.topRight, .bottomRight])
        //     }
        //     .disposed(by: self.rx.disposeBag)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // labTitle1.roundCorners([.topRight, .bottomRight], radius: 16)
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
// MARK: - 👀
public extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
// MARK: - 🍺UI Prepare & Masonry
private extension LXLabelVC {
    func prepareUI() {
        self.view.backgroundColor = .white
        // navigationItem.title = ""


        let text = "进口大串香蕉 重约900-1000g"
        labTitle1.text = "1: \(text)"
        labTitle2.text = "2: \(text)"
        labTitle3.text = "3: \(text)"
        labTitle4.text = "4: \(text)"
        labTitle5.text = "5: \(text)"
        labTitle3.numberOfLines = 1
        labTitle4.numberOfLines = 1
        labTitle5.numberOfLines = 1
        tvTitle1.text = text
        tvTitle2.text = text

        labTitle5.layer.maskedCorners = cornerView.layer.maskedCorners.intersection(.alongEdge(.maxXEdge))
        labTitle5.layer.cornerCurve = cornerView.layer.cornerCurve
        cornerView.addSubview(labTitle5)

        logo2View.layer.maskedCorners = imgViewLogo2.layer.maskedCorners.intersection(.alongEdge(.minXEdge))
        logo2View.addSubview(imgViewLogo2)
        [
            cornerView,
            imgViewLogo,
            labTitle1, labTitle2, labTitle3, labTitle4,
            tvTitle1, tvTitle2,
            logo2View,
        ].forEach(self.wrapperStackView.addArrangedSubview)
        [self.wrapperStackView].forEach(self.view.addSubview)

        masonry()
        imgViewLogo.xl.setHorizontalHuggingAndCompressionResistance()
    }

    func masonry() {
        wrapperStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(175)
        }
        imgViewLogo.snp.makeConstraints {
            $0.height.equalTo(100)
        }
        imgViewLogo2.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-20)
            $0.height.equalTo(self.imgViewLogo2.snp.width)
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
