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
    static let objcRouter: LXOutlineOpt = .outline(.section(title: "LXToolKitObjC_Example"), subitems: [
        .subitem(.section(title: "LXToolKitObjC_Example(Swift)"), scene: .vc(provider: { LXToolKitObjCTestSwiftVC() })),
        .subitem(.section(title: "LXToolKitObjC_Example(Objc)"), scene: .vc(provider: { LXToolKitObjCTestVC() })),
        routerMVVM,
        router2023,
        router2022,
    ])
}

// MARK: - 🔐
internal extension LXToolKitObjcRouter {
    static let routerMVVM: LXOutlineOpt = .outline(.section(title: "MVVM"), subitems: [
        .subitem(.section(title: "LXLoginVC"), scene: .vc(provider: { LXLoginVC()  })),

    ].reversed())
    static let router2023: LXOutlineOpt = .outline(.section(title: "2023"), subitems: [
        .subitem(.section(title: "LXURLCompVC"), scene: .vc(provider: { LXURLCompVC()  })),
        .subitem(.section(title: "LXWebViewTestVC"), scene: .vc(provider: { LXWebViewTestVC()  })),
        .subitem(.section(title: "DJSearchResultVC"), scene: .vc(provider: { DJSearchResultVC()  })),
        // .subitem(.section(title: "LXIGListKitTestVC"), scene: .vc(provider: { LXIGListKitTestVC()  })),
        .subitem(.section(title: "LXCollectionTestVC"), scene: .vc(provider: { LXCollectionTestVC()  })),
        .subitem(.section(title: "LXNumberFormatterVC"), scene: .vc(provider: { LXNumberFormatterVC()  })),
        .subitem(.section(title: "LXPopTestVC"), scene: .vc(provider: { LXPopTestVC()  })),
        .subitem(.section(title: "LXScrollVC"), scene: .vc(provider: { LXScrollVC()  })),
        .subitem(.section(title: "LXUpdateLayoutVC"), scene: .vc(provider: { LXUpdateLayoutVC()  })),
        .subitem(.section(title: "DJCommentVC"), scene: .vc(provider: { DJCommentVC()  })),
        .subitem(.section(title: "LXLabelTestVC"), scene: .vc(provider: { LXLabelTestVC()  })),
        .subitem(.section(title: "LXViewAnimationARCTestVC"), scene: .vc(provider: { LXViewAnimationARCTestVC()  })),
    ].reversed())
    static let router2022: LXOutlineOpt = .outline(.section(title: "2022"), subitems: [
        .subitem(.section(title: "LX0527VC"), scene: .vc(provider: { LX0527VC()  })),
        .subitem(.section(title: "LXCollectionVC"), scene: .vc(provider: { LXCollectionVC()  })),
        .subitem(.section(title: "LXListViewController"), scene: .vc(provider: { LXListViewController()  })),
        .subitem(.section(title: "LXPagingVC"), scene: .vc(provider: { LXPagingVC()  })),
        .subitem(.section(title: "LXNaHiddenVC"), scene: .vc(provider: { LXNaHiddenVC()  })),
        .subitem(.section(title: "LXNest5VC"), scene: .vc(provider: { LXNest5VC()  })),
        .subitem(.section(title: "LXTableVC"), scene: .vc(provider: { LXTableVC()  })),
        .subitem(.section(title: "LXNest6VC"), scene: .vc(provider: { LXNest6VC()  })),
        .subitem(.section(title: "LXList2VC"), scene: .vc(provider: { LXList2VC()  })),
        .subitem(.section(title: "LXNested2VC"), scene: .vc(provider: { LXNested2VC()  })),
        .subitem(.section(title: "LXPaging2VC"), scene: .vc(provider: { LXPaging2VC()  })),
        .subitem(.section(title: "LXTestModelVC"), scene: .vc(provider: { LXTestModelVC()  })),
        .subitem(.section(title: "LXTestBorderVC"), scene: .vc(provider: { LXTestBorderVC()  })),
        .subitem(.section(title: "LXBannerTestVC"), scene: .vc(provider: { LXBannerTestVC()  })),
        .subitem(.section(title: "LXSubjectTestVC"), scene: .vc(provider: { LXSubjectTestVC()  })),
        .subitem(.section(title: "DJprepareForReuseSignalTestVC"), scene: .vc(provider: { DJprepareForReuseSignalTestVC()  })),
        .subitem(.section(title: "LXShadowVC"), scene: .vc(provider: { LXShadowVC()  })),
        .subitem(.section(title: "LXStackViewTestVC"), scene: .vc(provider: { LXStackViewTestVC()  })),
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
