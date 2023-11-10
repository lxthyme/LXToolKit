//
//  HealthLevelShape.swift
//  DJTest
//
//  Created by lxthyme on 2023/10/24.
//

import SwiftUI

@available(iOS 16.2, *)
struct HealthLevelShape: View {
    var level: Double
    @AppStorage("supercharged", store: UserDefaults(suiteName: EmojiRanger.appGroup))
    var supercharged: Bool = EmojiRanger.herosAreSupercharged()

    var body: some View {
        GeometryReader { proxy in
            let frame = proxy.frame(in: .local)
            let boxWidth = frame.width * (supercharged ? 1.0 : level)

            RoundedRectangle(cornerRadius: 4)
                .foregroundColor(.gray)

            RoundedRectangle(cornerRadius: 4)
                .frame(width: boxWidth)
                .foregroundColor(.green)
        }
    }
}

@available(iOS 16.2, *)
#Preview("Shape", body: {
    HealthLevelShape(level: 0.5)
        .previewLayout(.fixed(width: 160, height: 20))
})
