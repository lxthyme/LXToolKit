//
//  LXModalTransition.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/12/8.
//
import UIKit

class LXModalTransition: LXBaseObject {
    let interactiveTransition = InteractiveTransition()
}

// MARK: - ✈️UIViewControllerTransitioningDelegate
extension LXModalTransition: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentationTransition()
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissTransition()
    }
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition
    }
}

// MARK: - ✈️UIViewControllerTransitioningDelegate
// extension LXModalTransition: UIViewControllerTransitioningDelegate {}

// MARK: 🔐Private Actions
private extension LXModalTransition {}

class PresentationTransition: NSObject {}
class DismissTransition: NSObject {}
class InteractiveTransition: UIPercentDrivenInteractiveTransition {
    var presentedVC: UIViewController? = nil
    /// 是否拖拽了一半以上
    var shouldComplete: Bool = false
}

// MARK: - ✈️UIViewControllerAnimatedTransitioning
extension PresentationTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        guard let fpc = transitionContext?.viewController(forKey: .to) as? LXSampleListVC else {
            fatalError("Error!!!")
        }
        // let animator = fpc.anim
        // let timingParameters = UISpringTimingParameters(decelerationRate: UIScrollView.DecelerationRate.fast.rawValue, frequencyResponse: 0.25)
        // let animator = UIViewPropertyAnimator(duration: 0.0, timingParameters: timingParameters)
        // return TimeInterval(animator.duration)
        return 2
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // interruptibleAnimator(using: transitionContext).startAnimation()
        let containerView = transitionContext.containerView
        guard let toView = transitionContext.view(forKey: .to) else { return }
        containerView.addSubview(toView)

        let frame = CGRectOffset(toView.frame, 0, LXMacro.Screen.height)
        toView.frame = frame

        UIView .animate(withDuration: 0.75) {
            toView.frame = CGRectOffset(toView.frame, 0, -LXMacro.Screen.height)
        } completion: { finished in
            transitionContext.completeTransition(finished)
        }

    }
    // func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
    //     guard let fpc = transitionContext.viewController(forKey: .to) as? LXSampleListVC else {
    //         fatalError("Error!!!")
    //     }
    //     // fpc.susp
    // }
}

// MARK: - ✈️UIViewControllerAnimatedTransitioning
extension DismissTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView

        guard let fromView = transitionContext.view(forKey: .from) else {
            return
        }
        let finalFrame = CGRectOffset(fromView.frame, 0, LXMacro.Screen.height)
        if let toView = transitionContext.view(forKey: .to) {
            containerView.insertSubview(toView, at: 0)
        }

        UIView.animate(withDuration: 0.75) {
            fromView.frame = finalFrame
        } completion: { finished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

    }
}

// MARK: - ✈️UIPercentDrivenInteractiveTransition
extension InteractiveTransition {
    func transitionToVC(toVC: UIViewController) {
        presentedVC = toVC
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panAction(gesture:)))
        toVC.view.addGestureRecognizer(pan)
    }
    @objc func panAction(gesture: UIPanGestureRecognizer) {
        guard let presentedVC else {
            dlog("-->presentedVC: \(presentedVC)")
            return
        }
        switch gesture.state {
        case .began:
            dlog("-->begin")
            presentedVC.dismiss(animated: true, completion: nil)
        case .changed:
            let point = gesture.translation(in: presentedVC.view)
            let ratio = point.y / LXMacro.Screen.height
            dlog("-->ratio: \(ratio)")
            if ratio >= 0.5 {
                shouldComplete = true
            } else {
                shouldComplete = false
            }
            update(ratio)
        case .ended, .cancelled:
            dlog("-->end: \(gesture.state): \(shouldComplete)")
            if shouldComplete {
                finish()
            } else {
                cancel()
            }
        case .possible:
            dlog("-->possible")
            break
        case .failed:
            dlog("-->failed")
            break
        @unknown default:
            dlog("-->@unknown default")
            break
        }
    }
}
