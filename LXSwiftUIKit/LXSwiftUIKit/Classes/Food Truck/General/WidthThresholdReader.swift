//
//  WidthThresholdReader.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/8/25.
//

import SwiftUI

@available(iOS 15.0, *)
struct WidthThresholdReader: View {
    // var widthThreshold: Double = 400
    // var dynamicTypeThreshold: DynamicTypeSize = .xxLarge
    // @ViewBuilder var content: (WidthThresholdProxy) -> Content

    // #if os(iOS)
    // @Environment(\.horizontalSizeClass) private var sizeClass
    // #endif
    // @Environment(\.dynamicTypeSize) private var dynamicType

    var body: some View {
        // GeometryReader { geometryProxy in
        //     let compressionProxy = WidthThresholdProxy(
        //         width: geometryProxy.size.width,
        //         isCompact: isCompact(width: geometryProxy.size.width)
        //     )
        //     // content(compressionProxy)
        //     content(compressionProxy)
        //         // .frame(maxWidth: .infinity, maxHeight: .infinity)
        // }
        Text("Hello world!")
    }

    func isCompact(width: Double) -> Bool {
        return true
    }
}

struct WidthThresholdProxy: Equatable {
    var width: Double
    var isCompact: Bool
}

@available(iOS 15.0, *)
struct WidthThresholdReader_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 40) {
            // WidthThresholdReader { proxy in
            //     Label {
            //         Text("Standard")
            //     } icon: {
            //         compactIndicator(proxy: proxy)
            //     }
            // }
            // .border(.quaternary)
            WidthThresholdReader()
        }
    }

    // @ViewBuilder
    // static func compactIndicator(proxy: WidthThresholdProxy) -> some View {
    //     if proxy.isCompact {
    //         Image(systemName: "arrowtriangle.right.and.line.vertical.and.arrowtriangle.left.fill")
    //             .foregroundStyle(.red)
    //     } else {
    //         Image(systemName: "checkmark.circle")
    //             .foregroundStyle(.secondary)
    //     }
    // }
}
