//
//  Daily01.swift
//  LXSwiftUIKit
//
//  Created by lxthyme on 2023/8/23.
//

import SwiftUI
import Combine

class WizardTrick: NSObject {
    var name: String?
}

class WizardModel: ObservableObject {
    var trick: WizardTrick
    var wand: Int?

    // MARK: 🔗Vaiables
    let objectWillChange: ObservableObjectPublisher = PassthroughSubject<Void, Never>()
    // MARK: 🛠Life Cycle
}

struct Daily01: View {
    // @Published var count: Int = 1
    @ObservedObject var model: WizardModel
    var body: some View {
        Text("Hello, World!")
        Text("name: \(model.trick?.name)")
    }
}

struct Daily01_Previews: PreviewProvider {
    static var previews: some View {
        Daily01()
    }
}
