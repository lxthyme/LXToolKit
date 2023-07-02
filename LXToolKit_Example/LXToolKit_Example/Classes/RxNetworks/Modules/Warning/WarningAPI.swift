//
//  WarningAPI.swift
//  RxNetworks_Example
//
//  Created by Condy on 2022/1/4.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import RxNetworks

enum WarningAPI {
    case warning
}

extension WarningAPI: NetworkAPI {
    
    var ip: APIHost {
        return NetworkConfig.baseURL
    }
    
    var method: APIMethod {
        return .get
    }
    
    var path: APIPath {
        return "/failed/path"
    }
    
    var plugins: APIPlugins {
        let warning = NetworkWarningPlugin.init(options: .init(duration: 2, position: .bottom))
        var options = NetworkLoadingPlugin.Options.init(text: "Loading", delay: 0.5)
        options.setChangeHudParameters { hud in
            hud.detailsLabel.textColor = UIColor.yellow
        }
        let loading = NetworkLoadingPlugin.init(options: options)
        return [loading, warning]
    }
}
