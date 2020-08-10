//
//  LXPost2View.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/8/10.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class LXPost2View: ___VARIABLE_cocoaTouchSubclass___ {
    // MARK: UI
    // MARK: Vaiables
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(frame: CGRect) {
        super.init(frame: frame)

        prepareUI()
    }

}

// MARK: LoadData
extension LXPost2View {}

// MARK: Public Actions
extension LXPost2View {}

// MARK: Private Actions
private extension LXPost2View {}

// MARK: - UI Prepare & Masonry
private extension LXPost2View {
    func prepareUI() {
        self.view.backgroundColor = UIColor.white
        // self.title = "<#title#>"

        //[<#table#>].forEach(self.addSubview)
        masonry()
    }

    func masonry() {}
}
