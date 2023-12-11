//
//  Presenter.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/12/10.
//

import Foundation

public enum PresentrConstants {
    public enum Values {
        public static let defaultSideMargin: Float = 30.0
        public static let defaultHeightPercentage: Float = 0.66
    }
    public enum Strings {
        public static let alertTitle = "Alert"
        public static let alertBody = "This is an alert."
    }

}

public enum DismissSwipeDirection {
    case `default`
    case bottom
    case top
}

public enum BackgroundTapAction {
    case noAction
    case dismiss
    case passthrough
}

@objc protocol PresentrDelegate {
    @objc optional func presentrShouldDismiss(keyboardShowing: Bool) -> Bool
}

class Presenter: LXBaseObject {
    /// This must be set during initialization, but can be changed to reuse a Presentr object.
    public var presentationType: PresentationType

    /// The type of transition animation to be used to present the view controller. This is optional, if not provided the default for each presentation type will be used.
    public var transitionType: TransitionType?

    /// The type of transition animation to be used to dismiss the view controller. This is optional, if not provided transitionType or default value will be used.
    public var dismissTransitionType: TransitionType?

    /// Should the presented controller have rounded corners. Each presentation type has its own default if nil.
    public var roundCorners: Bool?

    /// Radius of rounded corners for presented controller if roundCorners is true. Default is 4.
    public var cornerRadius: CGFloat = 4

    /// Shadow settings for presented controller.
    public var dropShadow: PresentrShadow?

    /// What should happen when background is tapped. Default is dismiss which dismisses the presented ViewController.
    public var backgroundTap: BackgroundTapAction = .dismiss

    /// Should the presented controller dismiss on Swipe inside the presented view controller. Default is false.
    public var dismissOnSwipe = false

    /// If dismissOnSwipe is true, the direction for the swipe. Default depends on presentation type.
    public var dismissOnSwipeDirection: DismissSwipeDirection = .default

    /// Should the presented controller use animation when dismiss on background tap or swipe. Default is true.
    public var dismissAnimated = true

    /// Color of the background. Default is Black.
    public var backgroundColor = UIColor.black

    /// Opacity of the background. Default is 0.7.
    public var backgroundOpacity: Float = 0.7

    /// Should the presented controller blur the background. Default is false.
    public var blurBackground = false

    /// The type of blur to be applied to the background. Ignored if blurBackground is set to false. Default is Dark.
    public var blurStyle: UIBlurEffect.Style = .dark

    /// A custom background view to be added on top of the regular background view.
    public var customBackgroundView: UIView?

    /// How the presented view controller should respond to keyboard presentation.
    public var keyboardTranslationType: KeyboardTranslationType = .none

    /// When a ViewController for context is set this handles what happens to a tap when it is outside the context. Default is passing it through to the background ViewController's. If this is set to anything but the default (.passthrough), the normal background tap cannot passthrough.
    public var outsideContextTap: BackgroundTapAction = .passthrough

    public weak var vcForCtx: UIViewController? {
        didSet {
            guard let vc = vcForCtx,
                  let view = vc.view else {
                contextFrameForPresentation = nil
                return
            }
            let correctedOrigin = view.convert(view.frame.origin, to: nil)
            contextFrameForPresentation = CGRect(x: correctedOrigin.x, y: correctedOrigin.y, width: view.bounds.width, height: view.bounds.height)
        }
    }

    fileprivate var contextFrameForPresentation: CGRect?

    init(presentationType: PresentationType) {
        self.presentationType = presentationType
    }
}

// MARK: - 🔐
extension Presenter {
    func presentVC(presentingVC: UIViewController, presentedVC: UIViewController, animated: Bool, complection: (() -> Void)? = nil) {
        presentedVC.transitioningDelegate = self
        presentedVC.modalPresentationStyle = .custom
        presentingVC.present(presentedVC, animated: animated, completion: complection)
    }
    fileprivate var transitionForPresent: TransitionType {
        return transitionType ?? presentationType.defaultTransitionType()
    }
    fileprivate var transitionForDismiss: TransitionType {
        return dismissTransitionType ?? transitionType ?? presentationType.defaultTransitionType()
    }
    private func presentationVC(_ presented: UIViewController, presenting: UIViewController?) -> PresentrController {
        return PresentrController(presentedViewController: presented, presentingViewController: presenting, presentationType: presentationType, roundCorners: roundCorners, cornerRadius: cornerRadius, dropShadow: dropShadow, backgroundTap: backgroundTap, dismissOnSwipe: dismissOnSwipe, dismissOnSwipeDirection: dismissOnSwipeDirection, backgroundColor: backgroundColor, backgroundOpacity: backgroundOpacity, blurBackground: blurBackground, blurStyle: blurStyle, customBackgroundView: customBackgroundView, keyboardTranslationType: keyboardTranslationType, dismissAnimated: dismissAnimated, contextFrameForPresentation: contextFrameForPresentation, outsideContextTap: outsideContextTap)
    }
}

// MARK: - ✈️UIViewControllerTransitioningDelegate
extension Presenter: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transitionForPresent.animation()
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transitionForDismiss.animation()
    }
    // func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    //     <#code#>
    // }
    // func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    //     <#code#>
    // }
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return presentationVC(presented, presenting: presenting)
    }
}
