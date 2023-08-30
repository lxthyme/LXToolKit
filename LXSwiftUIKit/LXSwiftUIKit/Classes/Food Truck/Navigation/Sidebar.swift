//
//  Sidebar.swift
//  LXSwiftUIKit
//
//  Created by lxthyme on 2023/8/25.
//

import SwiftUI

enum Panel: Hashable {
case truck
    case socialFeed
    #if EXTENDED_ALL
    case account
    #endif
    case orders
    case salesHistory
    case donuts
    case donutEditor
    case topFive
    // case city(City)
}

struct Sidebar: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar()
    }
}
