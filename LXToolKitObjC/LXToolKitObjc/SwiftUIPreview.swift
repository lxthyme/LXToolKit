//
//  SwiftUIPreview.swift
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/10/10.
//

import Foundation
import SwiftUI

// MARK: - 👀
extension UIViewController {
    private struct VCPreview: UIViewControllerRepresentable {
        // typealias T = UIViewController
        let previewVC: UIViewController

        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}

        func makeUIViewController(context: Context) -> some UIViewController {
            return previewVC
        }

    }
    public func toPreview() -> some View {
        // inject self (the current view controller) for the preview
        VCPreview(previewVC: self)
    }
}

// #Preview("LXToolKitObjCTestVC") {
//     VCPreview<LXToolKitObjCTestVC>()
// }
