//
//  LXFlutterSampleVC.swift
//  DJTest
//
//  Created by lxthyme on 2023/12/29.
//
import UIKit
import LXToolKit
import LXFlutterKit
import Flutter

extension FlutterManager.Channel {
    func registerMultiCounterMethodChannel() {
        guard case .multiCounter = channelName else { return }
        dlog("-->channel: \(channelName.name)\tentrypoint: \(entrypoint.value ?? "nil")")
        methodChannel.setMethodCallHandler {[weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
            guard let self else { return }
            dlog("-->[Flutter]call: \(call.method)-\(String(describing: call.arguments))")
            if call.method == LXFlutterMethod.MultiCounterScene.incrementCount.methodName {
                DataModel.shared.increament()
                result(nil)
            } else if call.method == LXFlutterMethod.MultiCounterScene.next.methodName {
                let nativeVC = LXHostVC()
                UIViewController.topViewController()?.navigationController?.pushViewController(nativeVC, animated: true)
                result(nil)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
    }
}

class LXFlutterSampleVC: LXBaseFlutterVC {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
        prepareFlutter()
    }

}

// MARK: 🌎LoadData
extension LXFlutterSampleVC {}

// MARK: 👀Public Actions
extension LXFlutterSampleVC {
    static func vcFrom(entrypoint: FlutterManager.EntryPoint, channelName: FlutterManager.ChannelName) -> LXFlutterSampleVC {
        let channel = FlutterManager.Channel(entrypoint: entrypoint, channelName: channelName)
        let vc = LXFlutterSampleVC(with: channel)
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
}

// MARK: 🔐Private Actions
private extension LXFlutterSampleVC {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXFlutterSampleVC {
    func prepareFlutter() {
        if case .multiCounter = channel.channelName {
            channel.registerMultiCounterMethodChannel()
            DataModel.shared.count
                .filter {[weak self] _ in
                    return self?.isVisible ?? false
                }
                .subscribe {[weak self] result in
                    dlog("-->result[LXFlutterSampleVC]: \(result)")
                    switch result {
                    case .next(let count):
                        self?.channel.methodChannel.xl_invokeMethod(method: LXFlutterMethod.MultiCounterFlutterScene.setCount, with: count)
                    default: break
                    }
                }
                .disposed(by: rx.disposeBag)
        }
    }
    func prepareUI() {
        self.view.backgroundColor = .white
        // navigationItem.title = ""

        // [<#table#>].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {}
}
