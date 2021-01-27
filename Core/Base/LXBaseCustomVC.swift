//
//  LXBaseCustomVC.swift
//  Alamofire
//
//  Created by LXThyme Jason on 2020/8/10.
//

import UIKit

public protocol LXCustomView {
    associatedtype CustomView: UIView
}

// MARK: - LXCustomView
public extension LXCustomView where Self: UIViewController {
    public var customView: CustomView {
        guard let v = view as? CustomView else {
            fatalError("Expected view to be of type \(CustomView.self) but got \(type(of: view)) instead")
        }
        return v
    }
}

open class LXBaseCustomVC<CustomView: UIView>: LXBaseVC {
    // MARK: UI
    public lazy var myView: CustomView = {
        return CustomView()
    }()
    // MARK: Vaiables
    // MARK: Life Cycle
    public override func loadView() {
        view = myView
    }

}

