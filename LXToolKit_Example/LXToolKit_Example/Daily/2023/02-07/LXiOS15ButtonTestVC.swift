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
        let s = UISegmentedControl(items: UIButton.Configuration.XL.allList.map { $0.xl.rawValue })
        s.selectedSegmentIndex = 0
        s.isMomentary = false
        s.apportionsSegmentWidthsByContent = true
        
        s.addTarget(self, action: #selector(segmentConfigurationStyleChanged(sender:)), for: .valueChanged)
        
        return s
    }()
    private lazy var segmentButtonSize: UISegmentedControl = {
        let s = UISegmentedControl(items: UIButton.Configuration.Size.XL.allList.map { $0.xl.rawValue })
        s.selectedSegmentIndex = 0
        s.isMomentary = false
        s.apportionsSegmentWidthsByContent = true
        
        s.addTarget(self, action: #selector(segmentButtonSizeChanged(sender:)), for: .valueChanged)
        
        return s
    }()
    private lazy var segmentCornerStyle: UISegmentedControl = {
        let s = UISegmentedControl(items: UIButton.Configuration.CornerStyle.XL.allList.map { $0.xl.rawValue })
        s.selectedSegmentIndex = 0
        s.isMomentary = false
        s.apportionsSegmentWidthsByContent = true
        
        s.addTarget(self, action: #selector(segmentCornerStyleChanged(sender:)), for: .valueChanged)
        
        return s
    }()
    private lazy var segmentMacIdiomStyle: UISegmentedControl = {
        let s = UISegmentedControl(items: UIButton.Configuration.MacIdiomStyle.XL.allList.map { $0.xl.rawValue } )
        s.selectedSegmentIndex = 0
        s.isMomentary = false
        s.apportionsSegmentWidthsByContent = true
        
        s.addTarget(self, action: #selector(segmentMacIdiomStyleChanged(sender:)), for: .valueChanged)
        
        return s
    }()
    private lazy var segmentTitleAlignment: UISegmentedControl = {
        let s = UISegmentedControl(items: UIButton.Configuration.TitleAlignment.XL.allList.map { $0.xl.rawValue })
        s.selectedSegmentIndex = 0
        s.isMomentary = false
        s.apportionsSegmentWidthsByContent = true
        
        s.addTarget(self, action: #selector(segmentTitleAlignmentChanged(sender:)), for: .valueChanged)
        
        return s
    }()
    private lazy var segmentBaseForegroundColor: UISegmentedControl = {
        let s = UISegmentedControl(items: colorList.map { $0.xl.getColorName() })
        s.selectedSegmentIndex = 0
        s.isMomentary = false
        s.apportionsSegmentWidthsByContent = true
        
        s.addTarget(self, action: #selector(segmentBaseForegroundColorChanged(sender:)), for: .valueChanged)
        
        return s
    }()
    private lazy var segmentBaseBackgroundColor: UISegmentedControl = {
        let s = UISegmentedControl(items: colorList.map { $0.xl.getColorName() })
        s.selectedSegmentIndex = 0
        s.isMomentary = false
        s.apportionsSegmentWidthsByContent = true
        
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
            // config.background
            config.baseForegroundColor = .yellow
            config.baseBackgroundColor = .magenta
            btnRender.configuration = config
            btnRender.setNeedsUpdateConfiguration()
        }
    }
    var cornerStyle: UIButton.Configuration.CornerStyle = .medium {
        didSet {
            config.cornerStyle = cornerStyle
            btnRender.setNeedsUpdateConfiguration()
        }
    }
    var buttonSize: UIButton.Configuration.Size = .medium {
        didSet {
            config.buttonSize = buttonSize
            btnRender.setNeedsUpdateConfiguration()
        }
    }
    var macIdiomStyle: UIButton.Configuration.MacIdiomStyle = .automatic {
        didSet {
            config.macIdiomStyle = macIdiomStyle
            btnRender.setNeedsUpdateConfiguration()
        }
    }
    var titleAlignment: UIButton.Configuration.TitleAlignment = .center {
        didSet {
            config.titleAlignment = titleAlignment
            btnRender.setNeedsUpdateConfiguration()
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
    // var background: UIBackgroundConfiguration
    // MARK: Life Cycle
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
    }
}

// MARK: LoadData
@available(iOS 15.0, *)
extension LXiOS15ButtonTestVC {}

// MARK: Public Actions
@available(iOS 15.0, *)
extension LXiOS15ButtonTestVC {}

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
        switch UIButton.Configuration.XL.allList[sender.selectedSegmentIndex] {
        case .plain():
            config = UIButton.Configuration.plain()
        case .tinted():
            config = UIButton.Configuration.tinted()
        case .gray():
            config = UIButton.Configuration.gray()
        case .filled():
            config = UIButton.Configuration.filled()
        case .borderless():
            config = UIButton.Configuration.borderless()
        case .bordered():
            config = UIButton.Configuration.bordered()
        case .borderedTinted():
            config = UIButton.Configuration.borderedTinted()
        case .borderedProminent():
            config = UIButton.Configuration.borderedProminent()
        default:
            config = UIButton.Configuration.plain()
        }
        segmentButtonSize.selectedSegmentIndex = 0
        segmentCornerStyle.selectedSegmentIndex = 0
        segmentMacIdiomStyle.selectedSegmentIndex = 0
        segmentTitleAlignment.selectedSegmentIndex = 0
    }
    @objc func segmentButtonSizeChanged(sender: UISegmentedControl) {
        // config.buttonSize = .medium
        switch UIButton.Configuration.Size.XL.allList[sender.selectedSegmentIndex] {
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
        switch UIButton.Configuration.CornerStyle.XL.allList[sender.selectedSegmentIndex] {
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
        switch UIButton.Configuration.MacIdiomStyle.XL.allList[sender.selectedSegmentIndex] {
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
        switch UIButton.Configuration.TitleAlignment.XL.allList[sender.selectedSegmentIndex] {
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
    @objc func segmentBaseForegroundColorChanged(sender: UISegmentedControl) {}
    @objc func segmentBaseBackgroundColorChanged(sender: UISegmentedControl) {}
    @objc func btnRenderAction(sender: UIButton) {}
}


// MARK: - UI Prepare & Masonry
@available(iOS 15.0, *)
extension LXiOS15ButtonTestVC {
    override open func prepareUI() {
        super.prepareUI()
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
    
    override open func masonry() {
        super.masonry()
        self.contentStackView.setCustomSpacing(20, after: segmentTitleAlignment)
        self.contentStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
