//
//  RetryView.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/1/9.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import LXToolKit
import RxSwift
import RxCocoa

class RetryView: UIView {
    // MARK: 📌UI
    private lazy var contentStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.spacing = 10
        v.alignment = .center
        return v
    }()
    private lazy var imgViewLogo: UIImageView = {
        let iv = UIImageView()
        iv.isUserInteractionEnabled = true
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    private lazy var labTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(PingFang: 14)
        label.textColor = Theme.Color.xl3c3e42
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    private lazy var labContent: UILabel = {
        let label = UILabel()
        label.font = UIFont(PingFang: 16)
        label.textColor = Theme.Color.xl22242A
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    private lazy var btnRetry: UIButton = {
        let btn = UIButton(type: .custom)

        btn.setTitleColor(.white, for: .normal)
        btn.setBackgroundImage(UIImage(named: "gradient_background_corner"), for: .normal)

        btn.titleLabel?.font = UIFont(PingFang: 16)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 21

//        <#btn.addTarget(self, action: #selector(btnSigninAction(sender:)), for: .touchUpInside)#>
//        <#@objc func btnSigninAction(sender: UIButton) {}#>
        return btn
    }()
    // MARK: 🔗Vaiables
    lazy var btnRetryTap: Observable<Void> = {
        return btnRetry.rx.tap
            .debounce(RxTimeInterval.milliseconds(100),
                      scheduler: MainScheduler.instance)
            .asObservable()
    }()
    var retryType: LXEmptyType = .success {
        didSet {
            var title = "",
                imgLogoName = "",
                btnRetryTitle = "",
                content = ""
            switch retryType {
                case .success:
                    imgLogoName = ""
                    title = ""
                    content = ""
                    btnRetryTitle = ""
                case .timeout:
                    imgLogoName = ""
                    title = "再给我一次机会，试试看刷新页面~"
                    content = "网速居然这么慢"
                    btnRetryTitle = "刷新"
                case .noData:
                    imgLogoName = ""
                    title = "试试看滑动刷新页面~"
                    content = "哎呀，没有内容了"
                    btnRetryTitle = ""
                case .server:
                    imgLogoName = ""
                    title = "别紧张，试试看刷新页面~"
                    content = "哎呀，崩溃了"
                    btnRetryTitle = "刷新"
                case .notLogin:
                    imgLogoName = ""
                    title = "快点去登录，才能查看更多内容~"
                    content = "哼，居然还没有登录"
                    btnRetryTitle = "登录"
            }
            imgViewLogo.image = UIImage(named: "empty_placeholde_happy_image")
            labTitle.text = title
            labContent.text = content
            labTitle.isHidden = title.isEmpty
            labContent.isHidden = content.isEmpty
            btnRetry.isHidden = btnRetryTitle.isEmpty
            btnRetry.setTitle(btnRetryTitle, for: .normal)
        }
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(frame: CGRect) {
        super.init(frame: frame)

        prepareUI()
    }

}

// MARK: 🌎LoadData
extension RetryView {}

// MARK: 👀Public Actions
extension RetryView {}

// MARK: 🔐Private Actions
private extension RetryView {}

// MARK: - 🍺UI Prepare & Masonry
private extension RetryView {
    func prepareUI() {
        self.backgroundColor = UIColor.white
        // self.title = "<#title#>"

        self.addSubview(contentStackView)
        contentStackView.xl.addArrangedSubviews(imgViewLogo, labTitle, labContent, btnRetry)
        contentStackView.xl.addCustomSpacing(35, after: labContent)
        masonry()
    }

    func masonry() {
        contentStackView.snp.makeConstraints {
            $0.top.left.greaterThanOrEqualToSuperview()
            $0.right.bottom.lessThanOrEqualToSuperview()
            $0.center.equalToSuperview()
        }
    }
}
