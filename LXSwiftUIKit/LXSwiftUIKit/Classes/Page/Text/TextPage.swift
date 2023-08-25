//
//  TestPage.swift
//  LXSwiftUIKit
//
//  Created by lxthyme on 2022/9/7.
//

import SwiftUI

private let github = "https://github.com/Jinxiansen/SwiftUI"

struct TextPage: View {
    var body: some View {
        VStack(spacing: 15) {
            Text("SwiftUI")
            Text("SwiftUI")
                .foregroundColor(.orange)
                .bold()
                .font(.system(.largeTitle))
                .fontWeight(.medium)
                .italic()
                .shadow(color: .black, radius: 1, x: 0, y: 2)

            Text(github)
                .underline(true, color: .gray)
                .font(.system(size: 16, design: .serif))
                .onTapGesture {
                    print(github)
                }

            HStack {
                Text("Text")
                Text("TextField").bold()
                Text("SecureField").foregroundColor(.orange)
            }

            Text("Views and controls are the visual building blocks of your app’s user interface." +
            " Use them to present your app’s content onscreen.")
                .lineLimit(nil)
        }
    }
}

struct TextPage_Previews: PreviewProvider {
    static var previews: some View {
        TextPage()
    }
}
