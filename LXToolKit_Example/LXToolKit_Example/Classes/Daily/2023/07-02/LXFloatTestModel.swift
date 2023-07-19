//
//  LXFloatTestModel.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/7/2.
//
import Foundation
import HandyJSON

class LXFloatTestModel: LXAnyModel {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    var f1: [NSDecimalNumber]?
    // MARK: 🛠Life Cycle
    required init() {}

    override func mapping(mapper: HelpingMapper) {
        super.mapping(mapper: mapper)
        // mapper <<< f1 <-- NSDecimalNumberTransform()
        // mapper <<<
        //     f1 <-- TransformOf<[NSDecimalNumber]?, Double>(fromJSON: { raw in
        //         // return NSDecimalNumberTransform()
        //         dlog("-->raw: \(raw)")
        //         return [NSDecimalNumber(floatLiteral: raw ?? -1)]
        //     }, toJSON: { decimal in
        //         // return NSDecimalNumberTransform()
        //         guard let first = decimal??.first else { return -1 }
        //         dlog("-->raw: \(decimal)")
        //         return first.doubleValue
        //     })
        // mapper <<<
        //     f1 <-- TransformOf<[NSDecimalNumber], NSDecimalNumberTransform>(fromJSON: { raw in
        //         dlog("-->raw: \(raw)")
        //         return NSDecimalNumberTransform()
        //     }, toJSON: { decimal in
        //         guard let first = decimal?.first else { return [-1.0] }
        //         dlog("-->raw: \(decimal)")
        //         return [first.doubleValue]
        //     })
    }
    // override func didFinishMapping() {
    //     super.didFinishMapping()
    // }
    // override var debugDescription: String { return toJSONString(prettyPrint: true) ?? "---" }
}
