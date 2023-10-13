//
//  SwiftUIPreview.swift
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/10/10.
//

import Foundation
import SwiftUI

struct VCPreview<VC: UIViewController>: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}

    func makeUIViewController(context: Context) -> some UIViewController {
        return VC()
    }
}

#Preview("LXToolKitObjCTestVC") {
    VCPreview<LXToolKitObjCTestVC>()
}
