//
//  HudPlugin.swift
//  Vaffle_demo
//
//  Created by LXThyme on 2019/1/11.
//  Copyright © 2019 DamonJow. All rights reserved.
//

import Foundation
import Moya
//import Result

final class RequestHudPlugin: PluginType {
    private let vc: UIViewController
    
    init(viewController: UIViewController) {
        self.vc = viewController
    }
    
    func willSend(_ request: RequestType, target: TargetType) {
        guard let urlString = request.request?.url?.absoluteString else { return }
        
        /// show request hud here
        dlog("urlString: ", urlString)
    }
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        guard case Result.failure(_) = result else { return }
        
        //only continue if result is a failure
    }
}
