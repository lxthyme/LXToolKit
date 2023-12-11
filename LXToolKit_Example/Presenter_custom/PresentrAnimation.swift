//
//  PresentrAnimation.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/12/10.
//

import Foundation

public struct PresentrTransitionContext {

    public let containerView: UIView

    public let initialFrame: CGRect

    public let finalFrame: CGRect

    public let isPresenting: Bool

    public let fromViewController: UIViewController?

    public let toViewController: UIViewController?

    public let fromView: UIView?

    public let toView: UIView?

    public let animatingViewController: UIViewController?

    public let animatingView: UIView?

}

enum AnimationOptions {
    case normal(duration: TimeInterval)
    case spring(duration: TimeInterval, delay: TimeInterval, damping: CGFloat, velocity: CGFloat)
}

open class PresentrAnimation: NSObject {
    var options: AnimationOptions
    init(options: AnimationOptions = .normal(duration: 0.4)) {
        self.options = options
    }
    func transform(containerFrame: CGRect, finalFrame: CGRect) -> CGRect {
        var initialFrame = finalFrame
        initialFrame.origin.y = containerFrame.height + initialFrame.height
        return initialFrame
    }
    func beforeAnimation(using transitionCtx: PresentrTransitionContext) {
        let finalFrameForVC = transitionCtx.finalFrame
        let initialFrameForVC = transform(
            containerFrame: transitionCtx.containerView.frame,
            finalFrame: finalFrameForVC
        )

        let initialFrame = transitionCtx.isPresenting ? initialFrameForVC : finalFrameForVC
        transitionCtx.animatingView?.frame = initialFrame
    }
    func performAnimation(using transitionCtx: PresentrTransitionContext) {
        let finalFrameForVC = transitionCtx.finalFrame
        let initialFrameForVC = transform(
            containerFrame: transitionCtx.containerView.frame,
            finalFrame: finalFrameForVC
        )

        let finalFrame = transitionCtx.isPresenting ? finalFrameForVC : initialFrameForVC
        transitionCtx.animatingView?.frame = finalFrame
    }
    func afterAnimation(using transitionCtx: PresentrTransitionContext) {}
}

// MARK: - 🔐
private extension PresentrAnimation {
    func animate(presentrCtx: PresentrTransitionContext, transitionCtx: UIViewControllerContextTransitioning, duration: TimeInterval) {
        beforeAnimation(using: presentrCtx)
        UIView.animate(withDuration: duration) {
            self.performAnimation(using: presentrCtx)
        } completion: { completed in
            self.afterAnimation(using: presentrCtx)
            transitionCtx.completeTransition(!transitionCtx.transitionWasCancelled)
        }
    }
    func animateWithSpring(
        presentrCtx: PresentrTransitionContext,
        transitionCtx: UIViewControllerContextTransitioning,
        duration: TimeInterval,
        delay: TimeInterval,
        damping: CGFloat,
        velocity: CGFloat
    ) {
        beforeAnimation(using: presentrCtx)
        UIView.animate(withDuration: duration,
                       delay: delay,
                       usingSpringWithDamping: damping,
                       initialSpringVelocity: velocity,
                       options: []) {
            self.performAnimation(using: presentrCtx)
        } completion: { completed in
            self.afterAnimation(using: presentrCtx)
            transitionCtx.completeTransition(!transitionCtx.transitionWasCancelled)
        }

    }
}

// MARK: - ✈️UIViewControllerAnimatedTransitioning
extension PresentrAnimation: UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        switch options {
        case let .normal(duration):
            return duration
        case let .spring(duration, _, _, _):
            return duration
        }
    }
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView

        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to) else {
            return
        }
        let fromView = transitionContext.view(forKey: .from)
        let toView = transitionContext.view(forKey: .to)

        let isPresenting: Bool = toVC.presentingViewController == fromVC

        let animatingVC = isPresenting ? toVC : fromVC
        let animatingView = isPresenting ? toView : fromView

        let initialFrame = transitionContext.initialFrame(for: animatingVC)
        let finalFrame = transitionContext.finalFrame(for: animatingVC)

        let presentrContext = PresentrTransitionContext(
            containerView: containerView,
            initialFrame: initialFrame,
            finalFrame: finalFrame,
            isPresenting: isPresenting,
            fromViewController: fromVC,
            toViewController: toVC,
            fromView: fromView,
            toView: toView,
            animatingViewController: animatingVC,
            animatingView: animatingView
        )

        if isPresenting, let toView {
            containerView.addSubview(toView)
        }

        switch options {
        case let .normal(duration):
            animate(presentrCtx: presentrContext,
                    transitionCtx: transitionContext,
                    duration: duration)
        case let .spring(duration, delay, damping, velocity):
            animateWithSpring(presentrCtx: presentrContext,
                              transitionCtx: transitionContext,
                              duration: duration,
                              delay: delay,
                              damping: damping,
                              velocity: velocity)
        }
    }
    // public func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
    //     <#code#>
    // }
    // public func animationEnded(_ transitionCompleted: Bool) {
    //     <#code#>
    // }
}
