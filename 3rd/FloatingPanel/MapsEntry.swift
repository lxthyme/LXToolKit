//
//  MapsEntry.swift
//  FloatingPanel_Maps
//
//  Created by lxthyme on 2023/12/21.
//

import Foundation

public struct MapsEntry {
    public static let entryVC: () -> UIViewController? = {
        let assetPath = Bundle(for: MainViewController.self).bundlePath
        let bundle = Bundle(path: NSString(string: assetPath).appendingPathComponent("FloatingPanel_Maps.bundle"))
        let sb = UIStoryboard(name: "Main", bundle: bundle)
        var vc = sb.instantiateInitialViewController()
        if let nav = vc as? UINavigationController {
            vc = nav.topViewController
        }
        return vc
    }
}
