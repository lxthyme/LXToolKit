//
//  LXBaseView.swift
//  Vaffle_demo
//
//  Created by DamonJow on 2018/11/8.
//  Copyright © 2018 DamonJow. All rights reserved.
//

import UIKit

open class LXBaseView: UIView {
    deinit {
        dlog("---------- >>>View: \(self.xl.xl_typeName)\t\tdeinit <<<----------")
    }
    required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        dlog("---------- \(self.xl.xl_typeName)\t\tinit ----------")
    }

}
