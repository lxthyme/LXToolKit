//
//  App.swift
//  LXSwiftUIKit_Example
//
//  Created by lxthyme on 2023/9/8.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import SwiftUI
import FoodTruckKit

struct FoodTruckApp: App {
    @StateObject private var model = FoodTruckModel()
    @StateObject private var accountStore = AccountStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        #if os(macOS)
        .defaultSize(width: 1000, height: 650)
        #endif

        #if os(macOS)
        MenuBarExtra {
            ScrollView {
                VStack(spacing: 0) {
                    BrandHeader(animated: false, headerSize: .reduced)
                    Text("Donut stuff!")
                }
            }
        } label: {
            Label("Food Truck", systemImage: "box.truck")
        }
        .menuBarExtraStyle(.window)
        #endif
    }
}
