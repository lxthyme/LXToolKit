//
//  SamplesEntry.swift
//  FloatingPanel_Samples
//
//  Created by lxthyme on 2023/12/21.
//

import Foundation

public struct SamplesEntry {
    public static let entryVC: () -> UIViewController? = {
        let assetPath = Bundle(for: MainViewController.self).bundlePath
        let bundle = Bundle(path: NSString(string: assetPath).appendingPathComponent("FloatingPanel_Samples.bundle"))
        let sb = UIStoryboard(name: "Main", bundle: bundle)
        var vc = sb.instantiateInitialViewController()
        if let nav = vc as? UINavigationController {
            vc = nav.topViewController
        }
        return vc
    }
}
