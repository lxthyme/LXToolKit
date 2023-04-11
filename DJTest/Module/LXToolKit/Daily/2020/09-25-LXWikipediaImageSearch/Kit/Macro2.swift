//
//  Macro.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/9/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

let MB = 1024 * 1024

func exampleError(_ error: String, location: String = "\(#file):\(#line)") ->NSError {
    return NSError(domain: "Example Error", code: -1, userInfo: [
        NSLocalizedDescriptionKey: "\(location): \(error)"
    ])
}
