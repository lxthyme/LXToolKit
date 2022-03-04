//
//  LXLoginVC.swift
//  LXToolKit_Exam
//
//  Created by lxthyme on 2022/3/2.
//  Copyright © 2022 CocoaPods. All rights reserved.
//
import RxSwift
import RxCocoa
import UIKit
import LXToolKit
import Toast_Swift

enum LoginSegments: Int {
    case oAuth, personal, basic

    var title: String {
        switch self {
        case .oAuth: return R.string.localizabled.loginOAuthSegmentTitle()
        case .personal: return R.string.localizabled.loginPersonalSegmentTitle()
        case .basic: return R.string.localizabled.loginBasicSegmentTitle()
        }
    }
}

class LXLoginVC: LXBaseMVVMTableVC {
    // MARK: 📌UI
    private lazy var segmentedControl: LXSegmentedControl = {
        let v = LXSegmentedControl(sectionTitles: [])
        v.selectedSegmentIndex = 0
        return v
    }()
    // MARK: - Basic authentication
    private lazy var imgViewBasicLogo: LXBaseImageView = {
        let iv = LXBaseImageView()
        iv.image = R.image.image_no_result()?.template
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    private lazy var loginTextField: UITextField = {
        let v = UITextField()
        v.textAlignment = .center
        v.keyboardType = .default
        v.borderStyle = .roundedRect
        v.clearButtonMode = .whileEditing
        v.autocapitalizationType = .none
        return v
    }()
    private lazy var pwdTextField: UITextField = {
        let v = UITextField()
        v.textAlignment = .center
        v.borderStyle = .roundedRect
        v.clearButtonMode = .whileEditing
        v.isSecureTextEntry = true
        return v
    }()
    private lazy var btnBasicLogin: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(R.image.icon_button_github(), for: .normal)
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    private lazy var basicLoginStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.spacing = 16
        return v
    }()
    // MARK: - OAuth authentication
    lazy var imgViewOAuthLogo: LXBaseImageView = {
        let iv = LXBaseImageView()
        iv.image = R.image.image_no_result()?.template
        return iv
    }()
    lazy var labTitle: LXBaseLabel = {
        let lab = LXBaseLabel()
        lab.font = lab.font.withSize(22)
        lab.numberOfLines = 0
        lab.textAlignment = .center
        return lab
    }()
    lazy var labDetail: LXBaseLabel = {
        let lab = LXBaseLabel()
        lab.font = lab.font.withSize(17)
        lab.numberOfLines = 0
        lab.textAlignment = .center
        return lab
    }()
    lazy var btnOAuthLogin: LXBaseButton = {
        let btn = LXBaseButton()
        btn.setImage(R.image.icon_button_github(), for: .normal)
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    lazy var oAuthLoginStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 16
        return sv
    }()
    // MARK: - Personal Access Token authentication
    lazy var personalLoginStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 16
        return sv
    }()
    lazy var ivPersonalLogo: LXBaseImageView = {
        let iv = LXBaseImageView()
        iv.image = R.image.image_no_result()?.template
        return iv
    }()

    lazy var labPersonalTitle: LXBaseLabel = {
        let lab = LXBaseLabel()
        lab.font = lab.font.withSize(22)
        lab.numberOfLines = 0
        lab.textAlignment = .center
        return lab
    }()
    lazy var labPersonalDetail: LXBaseLabel = {
        let lab = LXBaseLabel()
        lab.font = lab.font.withSize(17)
        lab.numberOfLines = 0
        lab.textAlignment = .center
        return lab
    }()

    lazy var tfPersonalToken: UITextField = {
        let view = UITextField()
        view.textAlignment = .center
        view.keyboardType = .emailAddress
        view.autocapitalizationType = .none
        return view
    }()

    lazy var btnPersonalLogin: LXBaseButton = {
        let btn = LXBaseButton()
        btn.setImage(R.image.icon_button_github(), for: .normal)
        // btn.centerTextAndImage(spacing: inset)
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    private lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        return v
    }()
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
        bindViewModel()
    }
    override func bindViewModel() {
        super.bindViewModel()
        guard let vm = viewModel as? LXLoginVM else { return }

        let segmentSelected = Observable
            .of(segmentedControl.segmentSelection.map { LoginSegments(rawValue: $0)! })
            .merge()
        let input = LXLoginVM.Input(segmentSelection: segmentSelected.asDriverOnErrorJustComplete(),
                                    basicLoginTrigger: btnBasicLogin.rx.tap.asDriver(),
                                    personalLoginTrigger: btnPersonalLogin.rx.tap.asDriver(),
                                    oAuthLoginTrigger: btnOAuthLogin.rx.tap.asDriver())
        let output = vm.transform(input: input)

        output.basicLoginBtnEnabled
            .drive(btnBasicLogin.rx.isEnabled)
            .disposed(by: rx.disposeBag)
        output.personalLoginBtnEnabled
            .drive(btnPersonalLogin.rx.isEnabled)
            .disposed(by: rx.disposeBag)

        _ = loginTextField.rx.textInput <-> vm.login
        _ = pwdTextField.rx.textInput <-> vm.pwd
        _ = tfPersonalToken.rx.textInput <-> vm.personalToken

        output.hidesBasicLoginView
            .drive(basicLoginStackView.rx.isHidden)
            .disposed(by: rx.disposeBag)
        output.hidesPersonalLoginView
            .drive(personalLoginStackView.rx.isHidden)
            .disposed(by: rx.disposeBag)
        output.hidesOAuthLoginView
            .drive(oAuthLoginStackView.rx.isHidden)
            .disposed(by: rx.disposeBag)
    }
}
// MARK: 🌎LoadData
extension LXLoginVC {}

// MARK: 👀Public Actions
extension LXLoginVC {}

// MARK: 🔐Private Actions
extension LXLoginVC {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXLoginVC {
    func prepareUI() {
        self.view.backgroundColor = .white
        navigationItem.titleView = segmentedControl

        isLoading.asDriver()
            .drive(onNext: {[weak self] isLoading in
                guard let `self` = self else { return }
                isLoading ? self.startAnimating() : self.stopAnimating()
            })
            .disposed(by: rx.disposeBag)

        error
            .subscribe(onNext: {[weak self] error in
                guard let `self` = self else { return }
                self.view.makeToast(error.description, title: error.title, image: R.image.icon_toast_warning())
            })
            .disposed(by: rx.disposeBag)

        languageChanged
            .subscribe(onNext: {[weak self] () in
                guard let `self` = self else { return }
                self.segmentedControl.sectionTitles = [
                    LoginSegments.oAuth.title,
                    LoginSegments.personal.title,
                    LoginSegments.basic.title
                ]
                let loc = R.string.localizabled.self
                // MARK: Basic
                self.loginTextField.placeholder = loc.loginLoginTextFieldPlaceholder()
                self.pwdTextField.placeholder = loc.loginPasswordTextFieldPlaceholder()
                self.btnBasicLogin.titleForNormal = loc.loginBasicLoginButtonTitle()
                // MARK: Personal
                self.labPersonalTitle.text = loc.loginPersonalTitleLabelText()
                self.labPersonalDetail.text = loc.loginPersonalDetailLabelText(Configs.App.githubScope)
                self.tfPersonalToken.placeholder = loc.loginPersonalTokenTextFieldPlaceholder()
                self.btnPersonalLogin.titleForNormal = loc.loginPersonalLoginButtonTitle()
                // MARK: OAuth
                self.labTitle.text = loc.loginTitleLabelText()
                self.labDetail.text = loc.loginDetailLabelText()
                self.btnOAuthLogin.titleForNormal = loc.loginOAuthloginButtonTitle()
            })
            .disposed(by: rx.disposeBag)

        basicLoginStackView.xl
            .addArrangedSubviews(imgViewBasicLogo, loginTextField, pwdTextField, btnBasicLogin)
        oAuthLoginStackView.xl
            .addArrangedSubviews(imgViewOAuthLogo, labTitle, labDetail, btnOAuthLogin)
        personalLoginStackView.xl.addArrangedSubviews(ivPersonalLogo, labPersonalTitle, labPersonalDetail, tfPersonalToken, btnPersonalLogin)
        contentStackView.xl
            .addArrangedSubviews(basicLoginStackView, personalLoginStackView, oAuthLoginStackView)
        scrollView.addSubview(contentStackView)
        contentView.addSubview(scrollView)
        self.view.addSubview(contentView)
        masonry()
    }
    func masonry() {
        segmentedControl.snp.makeConstraints {
            $0.width.equalTo(300)
        }
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
            $0.centerX.equalToSuperview()
        }
    }
}
