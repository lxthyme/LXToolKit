//
//  LXBaseVC.swift
//  test
//
//  Created by lxthyme on 2023/5/26.
//
import UIKit

public protocol Navigatable {
    var navigator: Navigator { get set }
}

open class Navigator {
    public static var `default` = Navigator()
}

public protocol LXViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}

public protocol LXBaseVMProtocol {
    associatedtype DJAPI
}

public protocol API {}

open class LXBaseVM: NSObject, LXBaseVMProtocol/**, LXViewModelType*/ {
    public typealias DJAPI = API
    public let provider: DJAPI

    public init(provider: DJAPI) {
        self.provider = provider
        super.init()
    }
}

open class LXBaseVC: UIViewController {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    public var navigator: Navigator = .default
    public var vm: LXBaseVM?
    // MARK: 🛠Life Cycle
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    public convenience init(vm: LXBaseVM?, navigator: Navigator) {
        self.init(nibName: nil, bundle: nil)
        self.navigator = navigator
        self.vm = vm
        // super.init(nibName: nil, bundle: nil)
        // self.init(vm: <#T##LXBaseVM?#>, navigator: <#T##Navigator#>)
    }
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    open override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
    }
    open func prepareUI() {
        self.view.backgroundColor = .white
        // self.title = "<#title#>"

        // [<#table#>].forEach(self.view.addSubview)

        // masonry()
    }
    open func masonry() {}
}

// MARK: 🌎LoadData
extension LXBaseVC {}

// MARK: 👀Public Actions
extension LXBaseVC {}

// MARK: 🔐Private Actions
private extension LXBaseVC {}

// MARK: - 🍺UI Prepare & Masonry
extension LXBaseVC {
    // @objc public func prepareUI() {
    //     self.view.backgroundColor = .white
    //     // self.title = "<#title#>"
    //
    //     // [<#table#>].forEach(self.view.addSubview)
    //
    //     // masonry()
    // }

    // @objc public func masonry() {}
}
