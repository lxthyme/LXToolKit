//
//  LXTestVC202401.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2024/1/25.
//
import LXToolKit

class LXTestVC202401: LXBaseVC {
    // MARK: 📌UI
    private lazy var btnPush: UIButton = {
        let btn = UIButton(type: .custom)
        btn.contentEdgeInsets = UIEdgeInsets(horizontal: 10, vertical: 6)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8

        btn.setTitle("Push", for: .normal)
        btn.setTitleColor(.white, for: .normal)

        let color: UIColor = .XL.randomGolden
        btn.setBackgroundColor(color: color, forState: .normal)
        btn.setBackgroundColor(color: color.withAlphaComponent(0.5), forState: .selected)

        return btn
    }()
    private lazy var btnPop: UIButton = {
        let btn = UIButton(type: .custom)
        btn.contentEdgeInsets = UIEdgeInsets(horizontal: 10, vertical: 6)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8

        btn.setTitle("Pop", for: .normal)
        btn.setTitleColor(.white, for: .normal)

        let color: UIColor = .XL.randomGolden
        btn.setBackgroundColor(color: color, forState: .normal)
        btn.setBackgroundColor(color: color.withAlphaComponent(0.5), forState: .selected)

        return btn
    }()
    private lazy var btnPresent: UIButton = {
        let btn = UIButton(type: .custom)
        btn.contentEdgeInsets = UIEdgeInsets(horizontal: 10, vertical: 6)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8

        btn.setTitle("Present", for: .normal)
        btn.setTitleColor(.white, for: .normal)

        let color: UIColor = .XL.randomGolden
        btn.setBackgroundColor(color: color, forState: .normal)
        btn.setBackgroundColor(color: color.withAlphaComponent(0.5), forState: .selected)

        return btn
    }()
    private lazy var btnDismiss: UIButton = {
        let btn = UIButton(type: .custom)
        btn.contentEdgeInsets = UIEdgeInsets(horizontal: 10, vertical: 6)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8

        btn.setTitle("Dismiss", for: .normal)
        btn.setTitleColor(.white, for: .normal)

        let color: UIColor = .XL.randomGolden
        btn.setBackgroundColor(color: color, forState: .normal)
        btn.setBackgroundColor(color: color.withAlphaComponent(0.5), forState: .selected)

        return btn
    }()
    private lazy var tvContent: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.textColor = .black
        tv.backgroundColor = .white
        tv.textContainer.lineBreakMode = .byWordWrapping
        tv.textAlignment = .left
        tv.returnKeyType = .done
        tv.keyboardType = .default
        tv.showsHorizontalScrollIndicator = false
        tv.showsVerticalScrollIndicator = false
        // tv.textContainer.maximumNumberOfLines = 0
        // tv.textContainer.lineBreakMode = .byTruncatingTail
        // tv.contentInset = .zero
        // let padding = tv.textContainer.lineFragmentPadding
        // tv.textContainerInset = UIEdgeInsets(top: 0, left: -padding, bottom: 0, right: -padding)
        return tv
    }()
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        testPushFlag(lifeCycle: .viewWillAppear)
    }
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)

        let info = testPushFlag(lifeCycle: .viewIsAppearing)
        tvContent.attributedText = makeAttribute(from: info)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        testPushFlag(lifeCycle: .viewDidAppear)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        testPushFlag(lifeCycle: .viewWillDisappear)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        testPushFlag(lifeCycle: .viewDidDisappear)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
        prepareVM()

        testPushFlag(lifeCycle: .viewDidLoad)
    }

}

// MARK: 🌎LoadData
extension LXTestVC202401 {}

// MARK: 👀Public Actions
extension LXTestVC202401 {}

// MARK: 🔐Private Actions
private extension LXTestVC202401 {
    @discardableResult
    func testPushFlag(lifeCycle: LogKit.LifeCycleType) -> String {
        let isContainSelf = navigationController?.viewControllers.contains(self)
        let info = """
        \(lifeCycle.rawValue)[\(isContainSelf?.string ?? "--")]: \(self.isMovingFromParent) - \(self.isMovingToParent)
        presentationController: \(self.presentationController?.description ?? "--")
        presentedViewController: \(self.presentedViewController?.description ?? "--")
        presentingViewController: \(self.presentingViewController?.description ?? "--")
        parent: \(self.parent?.description ?? "---")
        isBeingPresented: \(self.isBeingPresented)
        isBeingDismissed: \(self.isBeingDismissed)
        """
        dlog(info)
        return info
    }
    func makeAttribute(from info: String) -> NSAttributedString {
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.systemFont(ofSize: 14)
        ]
        let contentAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.boldSystemFont(ofSize: 16)
        ]
        let commonAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.cyan,
            .font: UIFont.boldSystemFont(ofSize: 14)
        ]
        let attr = NSMutableAttributedString()
        info.components(separatedBy: "\n")
            .forEach { item in
                let tmp = item.components(separatedBy: ":")
                if tmp.count >= 2 {
                    let title = tmp.first?.trimmed ?? ""
                    let content = tmp[1...].joined(separator: ":")
                    let itemAttr = NSMutableAttributedString()
                    itemAttr.append(NSAttributedString(string: "\(title): ", attributes: titleAttributes))
                    itemAttr.append(NSAttributedString(string: content, attributes: contentAttributes))
                    attr.append(itemAttr)
                } else {
                    attr.append(NSAttributedString(string: item, attributes: commonAttributes))
                }
                attr.append(NSAttributedString(string: "\n"))
            }
        return attr
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXTestVC202401 {
    func prepareVM() {
        btnPush.rx.controlEvent(.touchUpInside)
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .subscribe {[weak self] _ in
                let vc = LXTestVC202401()
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: rx.disposeBag)
        btnPop.rx.controlEvent(.touchUpInside)
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .subscribe {[weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
            .disposed(by: rx.disposeBag)
        btnPresent.rx.controlEvent(.touchUpInside)
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .subscribe {[weak self] _ in
                let vc = LXTestVC202401()
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                self?.present(nav, animated: true)
            }
            .disposed(by: rx.disposeBag)
        btnDismiss.rx.controlEvent(.touchUpInside)
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .subscribe {[weak self] _ in
                self?.dismiss(animated: true)
            }
            .disposed(by: rx.disposeBag)
    }
    func prepareUI() {
        self.view.backgroundColor = .white
        // navigationItem.title = ""

        [btnPush, btnPop, btnPresent, btnDismiss, tvContent].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {
        btnPush.snp.makeConstraints {
            $0.top.equalTo(self.view.snp.topMargin).offset(50)
            $0.right.equalTo(self.view.snp.centerX).offset(-10)
        }
        btnPop.snp.makeConstraints {
            $0.left.equalTo(self.view.snp.centerX).offset(10)
            $0.centerY.equalTo(btnPush)
        }
        btnPresent.snp.makeConstraints {
            $0.top.equalTo(btnPush.snp.bottom).offset(10)
            $0.right.equalTo(self.view.snp.centerX).offset(-10)
        }
        btnDismiss.snp.makeConstraints {
            $0.left.equalTo(self.view.snp.centerX).offset(10)
            $0.centerY.equalTo(btnPresent)
        }
        tvContent.snp.makeConstraints {
            $0.top.equalTo(btnPresent.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.height.greaterThanOrEqualTo(100)
        }
    }
}
