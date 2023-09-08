//
//  TruckView.swift
//  LXSwiftUIKit_Example
//
//  Created by lxthyme on 2023/9/8.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import SwiftUI

struct TruckView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

enum TruckCardHeaderNavigation {
    case navigationLink
    case selection(Binding<Panel?>)
}

struct TruckView_Previews: PreviewProvider {
    static var previews: some View {
        TruckView()
    }
}
