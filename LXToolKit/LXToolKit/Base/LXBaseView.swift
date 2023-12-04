//
//  LXBaseView.swift
//  Vaffle_demo
//
//  Created by DamonJow on 2018/11/8.
//  Copyright © 2018 DamonJow. All rights reserved.
//

import UIKit
@objc(LXBaseKitView)
open class LXBaseView: UIView {
    deinit {
        Log.dealloc.trace("---------- >>>View: \(self.xl.typeNameString)\t\tdeinit <<<----------")
    }
    required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        Log.dealloc.trace("---------- \(self.xl.typeNameString)\t\tinit ----------")
    }

}
