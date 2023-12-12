//
//  LXBaseViewModel.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/9/28.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
import UIKit
import Foundation
import RxSwift
import Moya

open class LXBaseViewModel: NSObject {
    deinit {
        LogKit.traceLifeCycle(.vm, typeName: xl.typeNameString, type: .deinit)
    }
}
