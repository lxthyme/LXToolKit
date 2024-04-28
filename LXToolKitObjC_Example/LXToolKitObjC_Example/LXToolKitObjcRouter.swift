//
//  LXToolKitObjcRouter.swift
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/11/21.
//

import Foundation
// import SwifterSwift
import DJTestKit
import LXToolKitObjC
import SwiftUI

public struct LXToolKitObjcRouter {}

// MARK: - 👀
public extension LXToolKitObjcRouter {
    static let objcRouter: LXOutlineItem = LXOutlineItem(opt: .outline(.section(title: "LXToolKitObjC_Example")), subitems: [
        LXOutlineItem(opt: .subitem(.section(title: "LXToolKitObjC_Example(Swift)")), scene: .vc(provider: { LXToolKitObjCTestSwiftVC() })),
        LXOutlineItem(opt: .subitem(.section(title: "LXToolKitObjC_Example(Objc)")), scene: .vc(provider: { LXToolKitObjCTestVC() })),
        routerMVVM,
        router2024,
        router2023,
        router2022,
    ])
}

// MARK: - 🔐
internal extension LXToolKitObjcRouter {
    static let routerMVVM: LXOutlineItem = LXOutlineItem(opt: .outline(.section(title: "MVVM(objc)")), subitems: [
        LXOutlineItem(opt: .subitem(.section(title: "LXLoginVC")), scene: .vc(provider: { LXLoginVC()  })),

    ].reversed())
    static let router2024: LXOutlineItem = LXOutlineItem(opt: .outline(.section(title: "2024(objc)")), subitems: [
        LXOutlineItem(opt: .subitem(.section(title: "DJTestObjc01VC")), scene: .vc(provider: { DJTestObjc01VC()  })),
        LXOutlineItem(opt: .subitem(.section(title: "LXTable202403VC")), scene: .vc(provider: { LXTable202403VC()  })),
        // LXOutlineItem(opt: .subitem(.section(title: "LXKeyboardTestVC")), scene: .vc(provider: { LXKeyboardTestVC()  })),
    ].reversed())
    static let router2023: LXOutlineItem = LXOutlineItem(opt: .outline(.section(title: "2023(objc)")), subitems: [
        LXOutlineItem(opt: .subitem(.section(title: "LXURLCompVC")), scene: .vc(provider: { LXURLCompVC()  })),
        LXOutlineItem(opt: .subitem(.section(title: "LXWebViewTestVC")), scene: .vc(provider: { LXWebViewTestVC()  })),
        LXOutlineItem(opt: .subitem(.section(title: "DJSearchResultVC")), scene: .vc(provider: { LXDJSearchResultVC()  })),
        // LXOutlineItem(opt: .subitem(.section(title: "LXIGListKitTestVC")), scene: .vc(provider: { LXIGListKitTestVC()  })),
        LXOutlineItem(opt: .subitem(.section(title: "LXCollectionTestVC")), scene: .vc(provider: { LXCollectionTestVC()  })),
        LXOutlineItem(opt: .subitem(.section(title: "LXNumberFormatterVC")), scene: .vc(provider: { LXNumberFormatterVC()  })),
        LXOutlineItem(opt: .subitem(.section(title: "LXPopTestVC")), scene: .vc(provider: { LXPopTestVC()  })),
        LXOutlineItem(opt: .subitem(.section(title: "LXScrollVC")), scene: .vc(provider: { LXScrollVC()  })),
        LXOutlineItem(opt: .subitem(.section(title: "LXUpdateLayoutVC")), scene: .vc(provider: { LXUpdateLayoutVC()  })),
        LXOutlineItem(opt: .subitem(.section(title: "LXDJCommentVC")), scene: .vc(provider: { LXDJCommentVC()  })),
        LXOutlineItem(opt: .subitem(.section(title: "LXLabelTestVC")), scene: .vc(provider: { LXLabelTestVC()  })),
        LXOutlineItem(opt: .subitem(.section(title: "LXViewAnimationARCTestVC")), scene: .vc(provider: { LXViewAnimationARCTestVC()  })),
    ].reversed())
    static let router2022: LXOutlineItem = LXOutlineItem(opt: .outline(.section(title: "2022(objc)")), subitems: [
        LXOutlineItem(opt: .subitem(.section(title: "LX0527VC")), scene: .vc(provider: { LX0527VC()  })),
        LXOutlineItem(opt: .subitem(.section(title: "LXCollectionVC")), scene: .vc(provider: { LXCollectionVC()  })),
        LXOutlineItem(opt: .subitem(.section(title: "LXListViewController")), scene: .vc(provider: { LXListViewController()  })),
        LXOutlineItem(opt: .subitem(.section(title: "LXPagingVC")), scene: .vc(provider: { LXPagingVC()  })),
        LXOutlineItem(opt: .subitem(.section(title: "LXNaHiddenVC")), scene: .vc(provider: { LXNaHiddenVC()  })),
        LXOutlineItem(opt: .subitem(.section(title: "LXNest5VC")), scene: .vc(provider: { LXNest5VC()  })),
        LXOutlineItem(opt: .subitem(.section(title: "LXTableVC")), scene: .vc(provider: { LXTableVC()  })),
        LXOutlineItem(opt: .subitem(.section(title: "LXNest6VC")), scene: .vc(provider: { LXNest6VC()  })),
        LXOutlineItem(opt: .subitem(.section(title: "LXList2VC")), scene: .vc(provider: { LXList2VC()  })),
        LXOutlineItem(opt: .subitem(.section(title: "LXNested2VC")), scene: .vc(provider: { LXNested2VC()  })),
        LXOutlineItem(opt: .subitem(.section(title: "LXPaging2VC")), scene: .vc(provider: { LXPaging2VC()  })),
        LXOutlineItem(opt: .subitem(.section(title: "LXTestModelVC")), scene: .vc(provider: { LXTestModelVC()  })),
        LXOutlineItem(opt: .subitem(.section(title: "LXTestBorderVC")), scene: .vc(provider: { LXTestBorderVC()  })),
        LXOutlineItem(opt: .subitem(.section(title: "LXBannerTestVC")), scene: .vc(provider: { LXBannerTestVC()  })),
        LXOutlineItem(opt: .subitem(.section(title: "LXSubjectTestVC")), scene: .vc(provider: { LXSubjectTestVC()  })),
        LXOutlineItem(opt: .subitem(.section(title: "DJprepareForReuseSignalTestVC")), scene: .vc(provider: { DJprepareForReuseSignalTestVC()  })),
        LXOutlineItem(opt: .subitem(.section(title: "LXShadowVC")), scene: .vc(provider: { LXShadowVC()  })),
        LXOutlineItem(opt: .subitem(.section(title: "LXStackViewTestVC")), scene: .vc(provider: { LXStackViewTestVC()  })),
    ].reversed())
}


// #Preview("LXToolKitObjCTestVC") {
//     VCPreview<LXToolKitObjcTestVC>()
// }

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
       // VCPreview<LXToolKitObjcTestVC>()
        LXNest5VC().toPreview()
    }
}
