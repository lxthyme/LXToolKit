//
//  LXiOS15ButtonTestVC.swift
//  LXToolKit_Exam
//
//  Created by lxthyme on 2022/2/8.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import LXToolKit

@available(iOS 15.0, *)
class LXiOS15ButtonTestVC: LXBaseVC {
    // MARK: UI
    private lazy var segmentConfigurationStyle: UISegmentedControl = {
        let s = UISegmentedControl(items: UIButton.ConfigurationEnum.allCases.map { $0.xl.rawValue })
        s.selectedSegmentIndex = 0
        s.isMomentary = false
        s.apportionsSegmentWidthsByContent = true
        s.selectedSegmentTintColor = .magenta

        s.addTarget(self, action: #selector(segmentConfigurationStyleChanged(sender:)), for: .valueChanged)

        return s
    }()
    private lazy var segmentButtonSize: UISegmentedControl = {
        let s = UISegmentedControl(items: UIButton.Configuration.Size.XL.allCases.map { $0.xl.rawValue })
        s.selectedSegmentIndex = 0
        s.isMomentary = false
        s.apportionsSegmentWidthsByContent = true
        s.selectedSegmentTintColor = .magenta

        s.addTarget(self, action: #selector(segmentButtonSizeChanged(sender:)), for: .valueChanged)

        return s
    }()
    private lazy var segmentCornerStyle: UISegmentedControl = {
        let s = UISegmentedControl(items: UIButton.Configuration.CornerStyle.XL.allCases.map { $0.xl.rawValue })
        s.selectedSegmentIndex = 0
        s.isMomentary = false
        s.apportionsSegmentWidthsByContent = true
        s.selectedSegmentTintColor = .magenta

        s.addTarget(self, action: #selector(segmentCornerStyleChanged(sender:)), for: .valueChanged)

        return s
    }()
    private lazy var segmentMacIdiomStyle: UISegmentedControl = {
        let s = UISegmentedControl(items: UIButton.Configuration.MacIdiomStyle.XL.allCases.map { $0.xl.rawValue })
        s.selectedSegmentIndex = 0
        s.isMomentary = false
        s.apportionsSegmentWidthsByContent = true
        s.selectedSegmentTintColor = .magenta

        s.addTarget(self, action: #selector(segmentMacIdiomStyleChanged(sender:)), for: .valueChanged)

        return s
    }()
    private lazy var segmentTitleAlignment: UISegmentedControl = {
        let s = UISegmentedControl(items: UIButton.Configuration.TitleAlignment.XL.allCases.map { $0.xl.rawValue })
        s.selectedSegmentIndex = 0
        s.isMomentary = false
        s.apportionsSegmentWidthsByContent = true
        s.selectedSegmentTintColor = .magenta

        s.addTarget(self, action: #selector(segmentTitleAlignmentChanged(sender:)), for: .valueChanged)

        return s
    }()
    private lazy var segmentBaseForegroundColor: UISegmentedControl = {
        let s = UISegmentedControl(items: colorList.map { $0.xl.getColorName() })
        s.selectedSegmentIndex = 0
        s.isMomentary = false
        s.apportionsSegmentWidthsByContent = true
        s.selectedSegmentTintColor = .magenta

        s.addTarget(self, action: #selector(segmentBaseForegroundColorChanged(sender:)), for: .valueChanged)

        return s
    }()
    private lazy var segmentBaseBackgroundColor: UISegmentedControl = {
        let s = UISegmentedControl(items: colorList.map { $0.xl.getColorName() })
        s.selectedSegmentIndex = 0
        s.isMomentary = false
        s.apportionsSegmentWidthsByContent = true
        s.selectedSegmentTintColor = .magenta

        s.addTarget(self, action: #selector(segmentBaseBackgroundColorChanged(sender:)), for: .valueChanged)

        return s
    }()
    private lazy var btnRender: UIButton = {
        let btn = UIButton(type: .custom)
        btn.configuration = self.config

        btn.setTitle("Render Button", for: .normal)

        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.layer.masksToBounds = true
        // btn.layer.cornerRadius = 4

        btn.addTarget(self, action: #selector(btnRenderAction(sender:)), for: .touchUpInside)
        return btn
    }()
    // MARK: Vaiables
    var config = UIButton.Configuration.plain() {
        didSet {
            config.contentInsets = .init(top: 3, leading: 5, bottom: 3, trailing: 5)

            segmentButtonSize.selectedSegmentIndex = 0
            segmentCornerStyle.selectedSegmentIndex = 0
            segmentMacIdiomStyle.selectedSegmentIndex = 0
            segmentTitleAlignment.selectedSegmentIndex = 0
            segmentBaseForegroundColor.selectedSegmentIndex = 0
            segmentBaseBackgroundColor.selectedSegmentIndex = 0
            updateButtonBackgroundConfig()
        }
    }
    var cornerStyle: UIButton.Configuration.CornerStyle = .medium {
        didSet {
            updateButtonBackgroundConfig()
        }
    }
    var buttonSize: UIButton.Configuration.Size = .medium {
        didSet {
            updateButtonBackgroundConfig()
        }
    }
    var macIdiomStyle: UIButton.Configuration.MacIdiomStyle = .automatic {
        didSet {
            updateButtonBackgroundConfig()
        }
    }
    var titleAlignment: UIButton.Configuration.TitleAlignment = .center {
        didSet {
            updateButtonBackgroundConfig()
        }
    }
    var baseBackgroundColor: UIColor? = .white {
        didSet {
            updateButtonBackgroundConfig()
        }
    }
    var baseForegroundColor: UIColor? = .white {
        didSet {
            updateButtonBackgroundConfig()
        }
    }
    let colorList: [UIColor] = [
        .white,
        .black,
        .magenta,
        .purple,
        .red,
        .yellow,
        .cyan,
        .gray,
        .brown,
        .random
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
    }
    override var shouldAutorotate: Bool {
        return false
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeLeft
    }
    // override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
    //     return .landscapeLeft
    // }
}

// MARK: LoadData
@available(iOS 15.0, *)
extension LXiOS15ButtonTestVC {}

// MARK: Public Actions
@available(iOS 15.0, *)
extension LXiOS15ButtonTestVC {
    func updateButtonBackgroundConfig() {
        var config = self.config
        config.cornerStyle = cornerStyle
        config.buttonSize = buttonSize
        config.macIdiomStyle = macIdiomStyle
        config.titleAlignment = titleAlignment
        config.baseBackgroundColor = baseBackgroundColor
        config.baseForegroundColor = baseForegroundColor
        btnRender.configuration = config
        btnRender.setNeedsUpdateConfiguration()
    }
}

// MARK: Private Actions
@available(iOS 15.0, *)
private extension LXiOS15ButtonTestVC {
    // var config = UIButton.Configuration.plain()
    // config.buttonSize = .large
    // config.cornerStyle = .large
    // config.macIdiomStyle = .borderlessTinted
    // config.titleAlignment = .center
    @objc func segmentConfigurationStyleChanged(sender: UISegmentedControl) {
        // config = UIButton.Configuration.plain()
        // switch UIButton.Configuration.XL.allCases[sender.selectedSegmentIndex] {
        guard let item = UIButton.ConfigurationEnum.allCases[safe: sender.selectedSegmentIndex] else { return }
        switch item {
        case .plain:
            config = UIButton.Configuration.plain()
        case .tinted:
            config = UIButton.Configuration.tinted()
        case .gray:
            config = UIButton.Configuration.gray()
        case .filled:
            config = UIButton.Configuration.filled()
        case .borderless:
            config = UIButton.Configuration.borderless()
        case .bordered:
            config = UIButton.Configuration.bordered()
        case .borderedTinted:
            config = UIButton.Configuration.borderedTinted()
        case .borderedProminent:
            config = UIButton.Configuration.borderedProminent()
        default:
            config = UIButton.Configuration.plain()
        }
    }
    @objc func segmentButtonSizeChanged(sender: UISegmentedControl) {
        // config.buttonSize = .medium
        switch UIButton.Configuration.Size.XL.allCases[sender.selectedSegmentIndex] {
        case .mini:
            buttonSize = .mini
        case .small:
            buttonSize = .small
        case .medium:
            buttonSize = .medium
        case .large:
            buttonSize = .large
        @unknown default:
            buttonSize = .medium
        }
    }
    @objc func segmentCornerStyleChanged(sender: UISegmentedControl) {
        // config.cornerStyle = .large
        switch UIButton.Configuration.CornerStyle.XL.allCases[sender.selectedSegmentIndex] {
        case .fixed:
            cornerStyle = .fixed
        case .dynamic:
            cornerStyle = .dynamic
        case .small:
            cornerStyle = .small
        case .medium:
            cornerStyle = .medium
        case .large:
            cornerStyle = .large
        case .capsule:
            cornerStyle = .capsule
        @unknown default:
            cornerStyle = .fixed
        }
    }
    @objc func segmentMacIdiomStyleChanged(sender: UISegmentedControl) {
        // config.macIdiomStyle = .borderlessTinted
        switch UIButton.Configuration.MacIdiomStyle.XL.allCases[sender.selectedSegmentIndex] {
        case .automatic:
            macIdiomStyle = .automatic
        case .bordered:
            macIdiomStyle = .bordered
        case .borderless:
            macIdiomStyle = .borderless
        case .borderlessTinted:
            macIdiomStyle = .borderlessTinted
        @unknown default:
            macIdiomStyle = .automatic
        }
    }
    @objc func segmentTitleAlignmentChanged(sender: UISegmentedControl) {
        // config.titleAlignment = .center
        switch UIButton.Configuration.TitleAlignment.XL.allCases[sender.selectedSegmentIndex] {
        case .automatic:
            titleAlignment = .automatic
        case .leading:
            titleAlignment = .leading
        case .center:
            titleAlignment = .center
        case .trailing:
            titleAlignment = .trailing
        @unknown default:
            titleAlignment = .automatic
        }
    }
    @objc func segmentBaseForegroundColorChanged(sender: UISegmentedControl) {
        baseForegroundColor = colorList[safe: sender.selectedSegmentIndex]
    }
    @objc func segmentBaseBackgroundColorChanged(sender: UISegmentedControl) {
        baseBackgroundColor = colorList[safe: sender.selectedSegmentIndex]
    }
    @objc func btnRenderAction(sender: UIButton) {}
}

// MARK: - UI Prepare & Masonry
@available(iOS 15.0, *)
private extension LXiOS15ButtonTestVC {
    func prepareUI() {
        self.view.backgroundColor = .white

        contentStackView.axis = .vertical
        contentStackView.alignment = .center
        contentStackView.spacing = 5
        [
            segmentConfigurationStyle,
            segmentButtonSize,
            segmentCornerStyle,
            segmentMacIdiomStyle,
            segmentTitleAlignment,
            segmentBaseForegroundColor,
            segmentBaseBackgroundColor,
            btnRender
        ].forEach(self.contentStackView.addArrangedSubview)
        self.view.addSubview(self.contentStackView)
        masonry()
    }

    func masonry() {
        self.contentStackView.setCustomSpacing(20, after: segmentTitleAlignment)
        self.contentStackView.snp.remakeConstraints {
            $0.top.equalTo(self.view.snp.topMargin).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
}
