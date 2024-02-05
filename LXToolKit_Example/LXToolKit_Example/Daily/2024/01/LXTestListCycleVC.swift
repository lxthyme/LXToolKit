//
//  LXTestListCycleVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2024/1/27.
//
import UIKit

class LXTestListCycleVC: UIViewController {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    deinit {
        LogKit.traceLifeCycle(.vc, typeName: xl.typeNameString, type: .deinit)
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        LogKit.traceLifeCycle(.vc, typeName: xl.typeNameString, type: .`init`)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        LogKit.traceLifeCycle(.vc, typeName: xl.typeNameString, type: .viewWillAppear)
    }
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        LogKit.traceLifeCycle(.vc, typeName: xl.typeNameString, type: .viewIsAppearing)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        LogKit.traceLifeCycle(.vc, typeName: xl.typeNameString, type: .viewDidAppear)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        LogKit.traceLifeCycle(.vc, typeName: xl.typeNameString, type: .viewWillDisappear)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        LogKit.traceLifeCycle(.vc, typeName: xl.typeNameString, type: .viewDidDisappear)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        LogKit.traceLifeCycle(.vc, typeName: xl.typeNameString, type: .viewDidLoad)
        prepareUI()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        LogKit.traceLifeCycle(.vc, typeName: xl.typeNameString, type: .viewWillLayoutSubviews)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        LogKit.traceLifeCycle(.vc, typeName: xl.typeNameString, type: .viewDidLayoutSubviews)
    }
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        LogKit.traceLifeCycle(.vc, typeName: xl.typeNameString, type: .willMoveToParent)
    }
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        LogKit.traceLifeCycle(.vc, typeName: xl.typeNameString, type: .didMoveToParent)
    }

}

// MARK: 🌎LoadData
extension LXTestListCycleVC {}

// MARK: 👀Public Actions
extension LXTestListCycleVC {}

// MARK: 🔐Private Actions
private extension LXTestListCycleVC {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXTestListCycleVC {
    func prepareUI() {
        self.view.backgroundColor = .white
        // navigationItem.title = ""

        // [<#table#>].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {}
}
