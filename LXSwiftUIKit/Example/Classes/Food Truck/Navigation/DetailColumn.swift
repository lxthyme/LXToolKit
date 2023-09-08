//
//  DetailColumn.swift
//  LXSwiftUIKit_Example
//
//  Created by lxthyme on 2023/9/8.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import SwiftUI
import FoodTruckKit

struct DetailColumn: View {
    @Binding var selection: Panel?
    @ObservedObject var model: FoodTruckModel
    @State private var timeframe: Timeframe = .today
    var body: some View {
        Text("Hello world!")
        // switch selection ?? .truck {
        // case .truck:
        //     TruckV
        // case .socialFeed:
        //     <#code#>
        // case .account:
        //     <#code#>
        // case .orders:
        //     <#code#>
        // case .salesHistory:
        //     <#code#>
        // case .donuts:
        //     <#code#>
        // case .donutEditor:
        //     <#code#>
        // case .topFive:
        //     <#code#>
        // case .city(let iD):
        //     <#code#>
        // }
    }
}

struct DetailColumn_Previews: PreviewProvider {
    struct Preview: View {
        @State private var selection: Panel? = .truck
        @StateObject private var model = FoodTruckModel.preview

        var body: some View {
            DetailColumn(selection: $selection, model: model)
        }
    }
    static var previews: some View {
        Preview()
    }
}
