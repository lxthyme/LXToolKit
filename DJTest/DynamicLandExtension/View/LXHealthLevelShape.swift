//
//  LXHealthLevelShape.swift
//  DJTest
//
//  Created by lxthyme on 2024/3/18.
//

import SwiftUI
import WidgetKit

@available(iOS 16.2, *)
struct LXHealthLevelShape: View {
    var level: Double
    @AppStorage("supercharged", store: UserDefaults(suiteName: EmojiRanger.appGroup))
    var supercharged: Bool = EmojiRanger.herosAreSupercharged()

    var body: some View {
        GeometryReader(content: { geometry in
            let frame = geometry.frame(in: .local)
            let boxWidth = frame.width * (supercharged ? 1.0 : level)

            RoundedRectangle(cornerRadius: 4)
                .foregroundStyle(.gray)

            RoundedRectangle(cornerRadius: 4)
                .frame(width: boxWidth)
                .foregroundStyle(.green)
        })
    }
}

@available(iOS 16.2, *)
struct LXHealthLevelShape_Previews: PreviewProvider {
    static var previews: some View {
        LXHealthLevelShape(level: 0.5)
            .widgetBackground()
            .previewLayout(.fixed(width: 160, height: 20))
            // .previewContext(WidgetPreviewContext(family: .systemSmall))

    }
}
