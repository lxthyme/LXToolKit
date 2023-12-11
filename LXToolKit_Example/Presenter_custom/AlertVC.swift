//
//  AlertVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/12/10.
//

import Foundation

public typealias AlertActionHandler = () -> Void

enum AlertActionStyle {
    case `default`, cancel, destructive
    case custom(textColor: UIColor)

    func color() -> UIColor {
        switch self {
        case .default:
            return ColorPalette.greenColor
        case .cancel:
            return ColorPalette.grayColor
        case .destructive:
            return ColorPalette.redColor
        case .custom(let textColor):
            return textColor
        }
    }
}

open class AlertAction {
    let title: String
    let style: AlertActionStyle
    let handler: AlertActionHandler?

    init(title: String, style: AlertActionStyle, handler: AlertActionHandler?) {
        self.title = title
        self.style = style
        self.handler = handler
    }
}

private enum Font: String {

    case Montserrat = "Montserrat-Regular"
    case SourceSansPro = "SourceSansPro-Regular"

    func font(_ size: CGFloat = 15.0) -> UIFont {
        return UIFont(name: self.rawValue, size: size)!
    }

}

private struct ColorPalette {

    static let grayColor = UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 1)
    static let greenColor = UIColor(red: 58.0/255.0, green: 213.0/255.0, blue: 91.0/255.0, alpha: 1)
    static let redColor = UIColor(red: 255.0/255.0, green: 103.0/255.0, blue: 100.0/255.0, alpha: 1)

}

protocol CornerRadiusSettable {
    func customContainerViewSetCornerRadius(_ radius: CGFloat)
}

open class AlertVC: LXBaseDeinitVC {
    /// Text that will be used as the title for the alert
    public var titleText: String = "" {
        didSet {
            titleLabel?.text = titleText
        }
    }

    /// Text that will be used as the body for the alert
    public var bodyText: String = "" {
        didSet {
            bodyLabel?.text = bodyText
        }
    }

    /// If set to false, alert wont auto-dismiss the controller when an action is clicked. Dismissal will be up to the action's handler. Default is true.
    public var autoDismiss: Bool = true

    /// If autoDismiss is set to true, then set this property if you want the dismissal to be animated. Default is true.
    public var dismissAnimated: Bool = true

    public let titleFont: UIFont?

    public let bodyFont: UIFont?

    public let buttonFont: UIFont?

    fileprivate var actions = [AlertAction]()

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
    @IBOutlet private weak var firstButton: UIButton!
    @IBOutlet private weak var secondButton: UIButton!
    @IBOutlet private weak var containerView: UIView!

    public init(title: String? = nil, body: String? = nil, titleFont: UIFont? = nil, bodyFont: UIFont? = nil, buttonFont: UIFont? = nil) {
        if let title = title {
            titleText = title
        }

        if let body = body {
            bodyText = body
        }

        self.titleFont = titleFont
        self.bodyFont = bodyFont
        self.buttonFont = buttonFont

        super.init(nibName: "AlertVC", bundle: Bundle(for: type(of: self)))
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("Unsupported initializer, please use init()")
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        if actions.isEmpty {
            let okAction = AlertAction(title: "ok 🕶", style: .default, handler: nil)
            addAction(okAction)
        }

        setupContainerView()
        setupFonts()
        setupLabels()
        setupButtons()
    }
}

// MARK: - 👀
public extension AlertVC {
    func addAction(_ action: AlertAction) {
        guard actions.count < 2 else { return }
        actions += [action]
    }
    func setupContainerView() {
        containerView.clipsToBounds = true
    }
    private func setupFonts() {
        if titleFont == nil || bodyFont == nil || buttonFont == nil {
            loadFonts
        }

        titleLabel.font = titleFont ?? Font.Montserrat.font()
        bodyLabel.font = bodyFont ?? Font.SourceSansPro.font()
        firstButton.titleLabel?.font = buttonFont ?? Font.Montserrat.font(11.0)
        secondButton.titleLabel?.font = buttonFont ?? Font.Montserrat.font(11.0)
    }

    private func setupLabels() {
        titleLabel.text = titleText
        bodyLabel.text = bodyText
    }

    private func setupButtons() {
        guard let firstAction = actions.first else { return }
        apply(firstAction, toButton: firstButton)
        if actions.count == 2 {
            let secondAction = actions.last!
            apply(secondAction, toButton: secondButton)
        } else {
            secondButton.removeFromSuperview()
        }
    }

    private func apply(_ action: AlertAction, toButton: UIButton) {
        let title = action.title.uppercased()
        let style = action.style
        toButton.setTitle(title, for: UIControl.State())
        toButton.setTitleColor(style.color(), for: UIControl.State())
    }

    // MARK: IBAction's

    @IBAction func didSelectFirstAction(_ sender: AnyObject) {
        guard let firstAction = actions.first else { return }
        firstAction.handler?()
        dismiss()
    }

    @IBAction func didSelectSecondAction(_ sender: AnyObject) {
        guard let secondAction = actions.last, actions.count == 2 else { return }
        secondAction.handler?()
        dismiss()
    }

    // MARK: Helper's

    func dismiss() {
        guard autoDismiss else { return }
        self.dismiss(animated: dismissAnimated, completion: nil)
    }
}

let loadFonts: () = {
    let loadedFontMontserrat = AlertVC.loadFont(Font.Montserrat.rawValue)
    let loadedFontSourceSansPro = AlertVC.loadFont(Font.SourceSansPro.rawValue)
    if loadedFontMontserrat && loadedFontSourceSansPro {
        dlog("LOADED FONTS")
    }
}()

// MARK: - 🔐
private extension AlertVC {
    static func loadFont(_ name: String) -> Bool {
        let bundle = Bundle(for: self)
        guard let fontPath = bundle.path(forResource: name, ofType: "ttf"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: fontPath)),
            let provider = CGDataProvider(data: data as CFData),
            let font = CGFont(provider)
        else {
            return false
        }

        var error: Unmanaged<CFError>?

        let success = CTFontManagerRegisterGraphicsFont(font, &error)
        if !success {
            dlog("Error loading font. Font is possibly already registered.")
            return false
        }

        return true
    }
}

// MARK: - ✈️CornerRadiusSettable
extension AlertVC: CornerRadiusSettable {
    func customContainerViewSetCornerRadius(_ radius: CGFloat) {
        containerView.layer.cornerRadius = radius
    }
}
