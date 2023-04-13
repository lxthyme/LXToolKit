//
//  PageRow.swift
//  LXSwiftUIKit
//
//  Created by lxthyme on 2022/9/7.
//
import SwiftUI

struct PageRow: View {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    private let title: String
    private let subtitle: String?
    // MARK: 🛠Life Cycle
    init(title: String, subtitle: String? = nil) {
        self.title = title
        self.subtitle = subtitle
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title).bold()
            if let st = subtitle {
                Text(st).font(.subheadline)
                    .opacity(0.5)
                    .lineLimit(0)
            }
        }
    }
}

#if DEBUG
struct PageRow_Previews: PreviewProvider {
    static var previews: some View {
        PageRow(title: "Demo")
    }
}
#endif
