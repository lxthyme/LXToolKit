//
//  Sidebar.swift
//  LXSwiftUIKit_Example
//
//  Created by lxthyme on 2023/9/8.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import SwiftUI
import FoodTruckKit

enum Panel: Hashable {
    /// The value for the ``TruckView``.
    case truck
    /// The value for the ``SocialFeedView``.
    case socialFeed
    #if EXTENDED_ALL
    /// The value for the ``AccountView``.
    case account
    #endif
    /// The value for the ``OrdersView``.
    case orders
    /// The value for the ``SalesHistoryView``.
    case salesHistory
    /// The value for the ``DonutGallery``.
    case donuts
    /// The value for the ``DonutEditor``.
    case donutEditor
    /// The value for the ``TopFiveDonutsView``.
    case topFive
    /// The value for the ``CityView``.
    case city(City.ID)
}

struct Sidebar: View {
    @Binding var selection: Panel?
    var body: some View {
        List(selection: $selection) {
            NavigationLink(value: Panel.truck) {
                Label("Truck", systemImage: "box.truck")
            }
            NavigationLink(value: Panel.orders) {
                Label("Orders", systemImage: "shippingbox")
            }
            NavigationLink(value: Panel.socialFeed) {
                Label("Social Feed", systemImage: "text.bubble")
            }
            #if EXTENDED_ALL
            NavigationLink(value: Panel.account) {
                Label("Account", systemImage: "person.crop.circle")
            }
            #endif
            NavigationLink(value: Panel.salesHistory) {
                Label("Sales History", systemImage: "clock")
            }

            Section("Donuts") {
                NavigationLink(value: Panel.donuts) {
                    Label {
                        Text("Donuts")
                    } icon: {
                        Image.donutSymbol
                    }
                }
                NavigationLink(value: Panel.donutEditor) {
                    Label("Donut Editor", systemImage: "slider.horizontal.3")
                }

                NavigationLink(value: Panel.topFive) {
                    Label("Top 5", systemImage: "trophy")
                }
            }

            Section("Cities") {
                ForEach(City.all) { city in
                    NavigationLink(value: Panel.city(city.id)) {
                        Label(city.name, systemImage: "building.2")
                    }
                    .listItemTint(.secondary)
                }
            }
        }
        .navigationTitle("Food Truck")
        #if os(macOS)
        .navigationSplitViewColumnWidth(min: 200, ideal: 200)
        #endif
    }
}

struct Sidebar_Previews: PreviewProvider {
    struct Preview: View {
        @State private var selection: Panel? = .truck

        var body: some View {
            Sidebar(selection: $selection)
        }
    }
    static var previews: some View {
        NavigationSplitView {
            Preview()
        } detail: {
            Text("Detail!")
        }

    }
}
