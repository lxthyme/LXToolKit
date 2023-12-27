//
//  LXHostVC.swift
//  DJTest
//
//  Created by lxthyme on 2023/12/26.
//
import UIKit
import RxSwift
import LXToolKit

class LXHostVC: LXBaseVC {
    // MARK: 📌UI
    private lazy var labCount: UILabel = {
        let label = UILabel()
        label.text = "NaN"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    private lazy var btnAdd: UIButton = {
        let btn = UIButton(type: .custom)
        btn.contentEdgeInsets = UIEdgeInsets(horizontal: 5, vertical: 3)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8

        btn.setTitle("Add", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.setBackgroundColor(color: .cyan, forState: .normal)
        btn.setBackgroundColor(color: .cyan.withAlphaComponent(0.5), forState: .highlighted)

        btn.addAction(UIAction(handler: { _ in
            DataModel.shared.increament()
        }), for: .touchUpInside)
        return btn
    }()
    private lazy var btnNext: UIButton = {
        let btn = UIButton(type: .custom)
        btn.contentEdgeInsets = UIEdgeInsets(horizontal: 5, vertical: 3)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8

        btn.setTitle("Next", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.setBackgroundColor(color: .cyan, forState: .normal)
        btn.setBackgroundColor(color: .cyan.withAlphaComponent(0.5), forState: .highlighted)

        btn.addAction(UIAction(handler: {[weak self] _ in
            guard let self else { return }
            if (self.navigationController?.viewControllers.count ?? 0) % 4 == 3 {
                let vc = LXSingleVC(withEntryPoint: .topMain)
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                let vc = LXDoubleVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }), for: .touchUpInside)
        return btn
    }()
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()

        DataModel.shared.rx
            .observe(\.count)
            .subscribe {[weak self] result in
                dlog("-->result[1]: \(result)")
                switch result {
                case .next(let count):
                    self?.labCount.text = "\(count)"
                default: break
                }
            }
            .disposed(by: rx.disposeBag)
        DataModel.shared.countChangedBlock = {[weak self] count in
            dlog("-->result[2]: \(count)")
            self?.labCount.text = "\(count)"
        }
    }

}

// MARK: 🌎LoadData
extension LXHostVC {}

// MARK: 👀Public Actions
extension LXHostVC {}

// MARK: 🔐Private Actions
private extension LXHostVC {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXHostVC {
    func prepareUI() {
        self.view.backgroundColor = .white
        // navigationItem.title = ""

        [labCount, btnAdd, btnNext].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {
        labCount.snp.makeConstraints {
            $0.top.equalTo(self.view.snp.topMargin).offset(40)
            $0.centerX.equalToSuperview()
        }
        btnAdd.snp.makeConstraints {
            $0.top.equalTo(labCount.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(60)
            $0.height.equalTo(40)
        }
        btnNext.snp.makeConstraints {
            $0.top.equalTo(btnAdd.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(btnAdd)
        }
    }
}
