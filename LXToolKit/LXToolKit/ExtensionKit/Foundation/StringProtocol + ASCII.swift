//
//  StringProtocol + ASCII.swift
//  Vape-Ex
//
//  Created by LXThyme Jason on 2020/7/1.
//  Copyright © 2020 LXThyme. All rights reserved.
//

import Foundation

extension StringProtocol {
    var xl_asciiValues: [UInt8] { compactMap(\.asciiValue) }
}
