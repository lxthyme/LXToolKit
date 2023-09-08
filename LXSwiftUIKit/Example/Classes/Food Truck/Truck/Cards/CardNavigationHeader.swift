//
//  CardNavigationHeader.swift
//  LXSwiftUIKit_Example
//
//  Created by lxthyme on 2023/9/8.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import SwiftUI

struct CardNavigationHeader<Label: View>: View {
    var panel: Panel
    var navigation: TruckCardHeaderNavigation
    @ViewBuilder var label: Label


    var body: some View {
        HStack {
            switch navigation {
            case .navigationLink:
                NavigationLink(value: panel) {
                    label
                }
            case .selection(let binding):
                Button {
                    binding.wrappedValue = panel
                } label: {
                    label
                }
            }

            Spacer()
        }
        .buttonStyle(.borderless)
        .labelStyle(.cardNavigationHeader)
    }
}

struct CardNavigationHeader_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CardNavigationHeader(panel: .orders, navigation: .navigationLink) {
                Label("Orders", systemImage: "shippingbox")
            }
            .padding()
        }
    }
}
