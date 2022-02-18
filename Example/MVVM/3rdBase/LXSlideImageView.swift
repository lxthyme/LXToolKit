//
//  LXSlideImageView.swift
//  LXToolKit_Exam
//
//  Created by lxthyme on 2022/2/18.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import ImageSlideshow

class LXSlideImageView: ImageSlideshow {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(frame: CGRect) {
        super.init(frame: frame)

        prepareUI()
        updateUI()
    }
    func updateUI() {
        setNeedsDisplay()
    }
}

// MARK: 👀Public Actions
extension LXSlideImageView {
    func setSources(sources: [URL]) {
        setImageInputs(sources.map({ url -> SDWebImageSource in
            SDWebImageSource(url: url)
        }))
    }
    func present(from vc: UIViewController) {
        if #available(iOS 13.0, *) {
            self.presentFullScreenControllerForIos13(from: vc)
        } else {
            self.presentFullScreenController(from: vc)
        }
    }
    @discardableResult
    func presentFullScreenControllerForIos13(from vc: UIViewController) -> FullScreenSlideshowViewController {
        let fullscreen = FullScreenSlideshowViewController()
        fullscreen.pageSelected = {[weak self] page in
            self?.setCurrentPage(page, animated: false)
        }

        fullscreen.initialPage = currentPage
        fullscreen.inputs = images
        // slideshowTransitioningDelegate = ZoomAnimatedTransitioningDelegate(slideshowView: self, slideshowController: fullscreen)
        fullscreen.transitioningDelegate = slideshowTransitioningDelegate
        fullscreen.modalPresentationStyle = .fullScreen
        fullscreen.present(fullscreen, animated: true, completion: nil)

        return fullscreen
    }
}

// MARK: 🔐Private Actions
private extension LXSlideImageView {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXSlideImageView {
    func prepareUI() {
        contentScaleMode = .scaleAspectFit
        contentMode = .scaleAspectFit
        backgroundColor = UIColor.Material.grey100
        layer.borderWidth = Configs.BaseDimensions.borderWidth
        layer.borderColor = UIColor.white.cgColor
        slideshowInterval = 3
        hero.modifiers = [.arc]
        activityIndicator = DefaultActivityIndicator(style: .white, color: .secondary())

        masonry()
    }

    func masonry() {}
}
