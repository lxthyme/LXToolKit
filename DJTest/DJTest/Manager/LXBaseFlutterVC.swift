//
//  LXBaseFlutterVC.swift
//  DJTest
//
//  Created by lxthyme on 2023/12/26.
//
import UIKit
import LXToolKit
import Flutter

open class LXBaseFlutterVC: FlutterViewController {
    deinit {
        LogKit.traceLifeCycle(.flutterVC, typeName: xl.typeNameString, type: .deinit)
    }
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    public var channel: FlutterManager.Channel
    // MARK: 🛠Life Cycle
    public required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")}
    public init(with channel: FlutterManager.Channel) {
        self.channel = channel
        super.init(engine: channel.engine, nibName: nil, bundle: nil)
    }
    open override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        basePrepareUI()
        baseMasonry()
    }
    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        LogKit.traceLifeCycle(.flutterVC, typeName: xl.typeNameString, type: .didReceiveMemoryWarning)
    }

}

// MARK: 🌎LoadData
extension LXBaseFlutterVC {}

// MARK: 👀Public Actions
extension LXBaseFlutterVC {}

// MARK: 🔐Private Actions
private extension LXBaseFlutterVC {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXBaseFlutterVC {
    func basePrepareUI() {
        self.view.backgroundColor = .white
        // navigationItem.title = ""

        // [<#table#>].forEach(self.view.addSubview)
    }

    func baseMasonry() {
        let typeNameString = self.xl.typeNameString
        self.view.snp.setLabel("\(typeNameString).view")
    }
}
