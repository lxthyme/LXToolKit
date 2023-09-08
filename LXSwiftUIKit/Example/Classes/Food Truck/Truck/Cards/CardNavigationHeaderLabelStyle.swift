//
//  CardNavigationHeaderLabelStyle.swift
//  LXSwiftUIKit_Example
//
//  Created by lxthyme on 2023/9/8.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import SwiftUI

struct CardNavigationHeaderLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .firstTextBaseline, spacing: 4) {
            configuration.icon
                .foregroundStyle(.secondary)
            configuration.title

            Image(systemName: "chevron.forward")
                .foregroundStyle(.tertiary)
                .fontWeight(.semibold)
                .imageScale(.small)
                .padding(.leading, 2)
        }
        .font(.headline)
        .imageScale(.large)
        .foregroundColor(.accentColor)
    }
}

extension LabelStyle where Self == CardNavigationHeaderLabelStyle {
    static var cardNavigationHeader: CardNavigationHeaderLabelStyle {
        CardNavigationHeaderLabelStyle()
    }
}

struct CardNavigationHeaderLabelStyle_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Label("Title 1", systemImage: "star")
            Label("Title 2", systemImage: "square")
            Label("Title 3", systemImage: "circle")
        }
        .labelStyle(.cardNavigationHeader)
    }
}
