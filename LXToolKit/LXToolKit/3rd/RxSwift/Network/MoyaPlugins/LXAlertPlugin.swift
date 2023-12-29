//
//  LXAlertPlugin.swift
//  Vaffle_demo
//
//  Created by LXThyme on 2019/1/2.
//  Copyright © 2019 DamonJow. All rights reserved.
//

import UIKit
import Moya

final class LXAlertPlugin: PluginType {
    private let viewController: UIViewController

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func willSend(_ request: RequestType, target: TargetType) { }

//    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) { }
}
