//
//  LXToolKitObjcRouter.swift
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/11/21.
//

import Foundation
import SwifterSwift
import DJTestKit
import LXToolKitObjC
import SwiftUI

public struct LXToolKitObjcRouter {}

// MARK: - 👀
public extension LXToolKitObjcRouter {
    static let objcRouter: LXOutlineOpt = .outline(title: "LXToolKitObjC_Example", subitems: [
        .subitem(title: "LXToolKitObjC_Example(Swift)", scene: .vc(provider: { LXToolKitObjcTestVC() })),
        .subitem(title: "LXToolKitObjC_Example(Objc)", scene: .vc(provider: { LXToolKitObjCTestSwiftVC() })),
        routerMVVM,
        router2023,
        router2022,
    ])
}

// MARK: - 🔐
internal extension LXToolKitObjcRouter {
    static let routerMVVM: LXOutlineOpt = .outline(title: "MVVM", subitems: [
        .subitem(title: "LXLoginVC", scene: .vc(provider: { LXLoginVC()  })),

    ].reversed())
    static let router2023: LXOutlineOpt = .outline(title: "2023", subitems: [
        .subitem(title: "LXURLCompVC", scene: .vc(provider: { LXURLCompVC()  })),
        .subitem(title: "LXWebViewTestVC", scene: .vc(provider: { LXWebViewTestVC()  })),
        .subitem(title: "DJSearchResultVC", scene: .vc(provider: { DJSearchResultVC()  })),
        // .subitem(title: "LXIGListKitTestVC", scene: .vc(provider: { LXIGListKitTestVC()  })),
        .subitem(title: "LXCollectionTestVC", scene: .vc(provider: { LXCollectionTestVC()  })),
        .subitem(title: "LXNumberFormatterVC", scene: .vc(provider: { LXNumberFormatterVC()  })),
        .subitem(title: "LXPopTestVC", scene: .vc(provider: { LXPopTestVC()  })),
        .subitem(title: "LXScrollVC", scene: .vc(provider: { LXScrollVC()  })),
        .subitem(title: "LXUpdateLayoutVC", scene: .vc(provider: { LXUpdateLayoutVC()  })),
        .subitem(title: "DJCommentVC", scene: .vc(provider: { DJCommentVC()  })),
        .subitem(title: "LXLabelTestVC", scene: .vc(provider: { LXLabelTestVC()  })),
        .subitem(title: "LXViewAnimationARCTestVC", scene: .vc(provider: { LXViewAnimationARCTestVC()  })),
    ].reversed())
    static let router2022: LXOutlineOpt = .outline(title: "2022", subitems: [
        .subitem(title: "LX0527VC", scene: .vc(provider: { LX0527VC()  })),
        .subitem(title: "LXCollectionVC", scene: .vc(provider: { LXCollectionVC()  })),
        .subitem(title: "LXListViewController", scene: .vc(provider: { LXListViewController()  })),
        .subitem(title: "LXPagingVC", scene: .vc(provider: { LXPagingVC()  })),
        .subitem(title: "LXNaHiddenVC", scene: .vc(provider: { LXNaHiddenVC()  })),
        .subitem(title: "LXNest5VC", scene: .vc(provider: { LXNest5VC()  })),
        .subitem(title: "LXTableVC", scene: .vc(provider: { LXTableVC()  })),
        .subitem(title: "LXNest6VC", scene: .vc(provider: { LXNest6VC()  })),
        .subitem(title: "LXList2VC", scene: .vc(provider: { LXList2VC()  })),
        .subitem(title: "LXNested2VC", scene: .vc(provider: { LXNested2VC()  })),
        .subitem(title: "LXPaging2VC", scene: .vc(provider: { LXPaging2VC()  })),
        .subitem(title: "LXTestModelVC", scene: .vc(provider: { LXTestModelVC()  })),
        .subitem(title: "LXTestBorderVC", scene: .vc(provider: { LXTestBorderVC()  })),
        .subitem(title: "LXBannerTestVC", scene: .vc(provider: { LXBannerTestVC()  })),
        .subitem(title: "LXSubjectTestVC", scene: .vc(provider: { LXSubjectTestVC()  })),
        .subitem(title: "DJprepareForReuseSignalTestVC", scene: .vc(provider: { DJprepareForReuseSignalTestVC()  })),
        .subitem(title: "LXShadowVC", scene: .vc(provider: { LXShadowVC()  })),
        .subitem(title: "LXStackViewTestVC", scene: .vc(provider: { LXStackViewTestVC()  })),
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
