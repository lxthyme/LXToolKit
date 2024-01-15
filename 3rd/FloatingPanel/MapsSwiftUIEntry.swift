//
//  MapsEx.swift
//  FloatingPanel_Maps-SwiftUI
//
//  Created by lxthyme on 2023/12/20.
//

import SwiftUI

@available(iOS 14.0, *)
public struct MapsSwiftUIEntry: View {
    public init() {}
    public var body: some View {
        ContentView()
            .floatingPanel(delegate: SearchPanelPhoneDelegate()) { proxy in
                FloatingPanelContentView(proxy: proxy)
            }
            .floatingPanelSurfaceAppearance(.phone)
            .floatingPanelContentMode(.fitToBounds)
            .floatingPanelContentInsetAdjustmentBehavior(.never)
    }
}

@available(iOS 14.0, *)
#Preview {
    MapsSwiftUIEntry()
}
