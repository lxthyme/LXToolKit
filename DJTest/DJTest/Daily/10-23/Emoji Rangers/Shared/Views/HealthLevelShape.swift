//
//  HealthLevelShape.swift
//  DJTest
//
//  Created by lxthyme on 2023/10/24.
//

import SwiftUI

struct HealthLevelShape: View {
    var level: Double
    @AppStorage("supercharged", store: UserDefaults(suiteName: EmojiRanger.appGroup))
    var supercharged: Bool = EmojiRanger.herosAreSupercharged()

    var body: some View {
        GeometryReader { proxy in
            let frame = proxy.frame(in: .local)
            let boxWidth = frame.width * (supercharged ? 1.0 : level)

            RoundedRectangle(cornerRadius: 4)
                .foregroundStyle(.gray)

            RoundedRectangle(cornerRadius: 4)
                .frame(width: boxWidth)
                .foregroundStyle(.green)
        }
    }
}

#Preview("Shape", body: {
    HealthLevelShape(level: 0.5)
        .previewLayout(.fixed(width: 160, height: 20))
})
