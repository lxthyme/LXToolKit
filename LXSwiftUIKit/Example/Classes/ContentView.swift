//
//  ContentView.swift
//  LXSwiftUIKit
//
//  Created by lxthyme on 2022/9/7.
//

import SwiftUI
import FoodTruckKit

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: {
                    // FoodTruckApp()
                }, label: {
                    Text("Food Truck App")
                })
                DonutBoxView(isOpen: true) {
                    DonutView(donut: .classic)
                }
                // .offset(<#T##offset: CGSize##CGSize#>)
                .aspectRatio(1, contentMode: .fit)
                .frame(maxWidth: 300)
                .onTapGesture {
                    print("DonutBoxView tapped!")
                }
                Section(header: Text("Animation")) {
                    Text("233")
                    Text("Hello, world!")
                    NavigationLink(destination: LotteryView()) {
                        PageRow(title: "LotteryView", subtitle: "Rotation Lottery")
                    }
                }

                Section(header: Text("基础控件")) {
                    NavigationLink(destination: TextPage()) {
                        PageRow(title: "Text", subtitle: "显示一行或多行只读文本")
                    }
                    NavigationLink(destination: TextFieldPage()) {
                        PageRow(title: "TextField", subtitle: "显示可编辑文本界面的输入控件")
                    }
                    NavigationLink(destination: TextFieldPage()) {
                        PageRow(title: "SecureField", subtitle: "安全输入私密文本的输入控件")
                    }
                }
            }.listStyle(.grouped)
                .navigationBarTitle(Text("Example"))
                .navigationBarTitleDisplayMode(.large)
                .navigationBarItems(trailing: Button(action: {
                    print("right tap")
                }, label: {
                    Text("Right").foregroundColor(.orange)
                }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
