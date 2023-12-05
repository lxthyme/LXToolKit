//
//  AutoResizeWebView.swift
//  LXToolKit_Exam
//
//  Created by lxthyme on 2023/3/22.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import WebKit

// See https://developer.apple.com/library/content/documentation/Swift/Conceptual/BuildingCocoaApps/AdoptingCocoaDesignPatterns.html for more details.
private var observerContext = 0

@objcMembers
open class LXStrenchableWebView: WKWebView {

    // Keep track of height which will change when the view is loaded.
    public dynamic var webViewHeight: CGFloat = 0.0

    public init(frame: CGRect) {
        let config = WKWebViewConfiguration()
        let preferences = WKPreferences()
        config.preferences = preferences

        super.init(frame: frame, configuration: config)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    public func setup() {
        addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: &observerContext)

        scrollView.isScrollEnabled = false
        scrollView.scrollsToTop = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
    }

    public override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.height = webViewHeight
        return size
    }

    deinit {
        removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), context: &observerContext)
    }
}

extension LXStrenchableWebView {
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &observerContext {
            if let _ = change?[.newKey] as? Double {

                guard self.estimatedProgress > 0.5 else { return }

                let js = "document.getElementsByTagName('html')[0].offsetHeight"

                self.evaluateJavaScript(js, completionHandler: { result, error in
                    let contentHeight = result as? CGFloat ?? 0.0

                    if contentHeight > self.webViewHeight {
                        LogKit.kitLog("setting height to \(contentHeight)")
                        self.webViewHeight = contentHeight
                        self.invalidateIntrinsicContentSize()
                    }
                })

            }

        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }

    }
}
