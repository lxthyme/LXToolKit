//
//  LXTransitionVC.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/8/13.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import LXToolKit

private class MyView: UIView {
    // MARK: UI
    // MARK: Vaiables
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        prepareUI()
    }
    
}

// MARK: LoadData
extension MyView {}

// MARK: Public Actions
extension MyView {}

// MARK: Private Actions
private extension MyView {}

// MARK: - UI Prepare & Masonry
private extension MyView {
    func prepareUI() {
        self.backgroundColor = .white
        // [<#table#>].forEach(self.addSubview)
        masonry()
    }
    
    func masonry() {}
}

class LXTransitionVC: LXBaseVC {
    private typealias CustomView = MyView
    // MARK: UI
    private lazy var myView: CustomView = {
        return CustomView()
    }()
    // MARK: Vaiables
    // MARK: Life Cycle
    override func loadView() {
        view = myView
    }
    // override func viewWillAppear(_ animated: Bool) {
    //     super.viewWillAppear(animated)
    // }
    // override func viewDidAppear(_ animated: Bool) {
    //     super.viewDidAppear(animated)
    // }
    // override func viewWillDisappear(_ animated: Bool) {
    //     super.viewWillDisappear(animated)
    // }
    // override func viewDidDisappear(_ animated: Bool) {
    //     super.viewDidDisappear(animated)
    // }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        prepareUI()
    }
}

// MARK: LoadData
extension LXTransitionVC {}

// MARK: Public Actions
extension LXTransitionVC {}

// MARK: Private Actions
private extension LXTransitionVC {
    func testTransition() {
        self.navigationController?.delegate = self
        self.tabBarController?.delegate = self
        self.transitioningDelegate = self
    }
}

// MARK: - UIViewControllerAnimatedTransitioning
extension LXTransitionVC: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.75
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {}
    //    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {}
    func animationEnded(_ transitionCompleted: Bool) {}
}

// MARK: - UIViewControllerInteractiveTransitioning
extension LXTransitionVC: UIViewControllerInteractiveTransitioning {
    func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {}
    
    
}

// MARK: - UIViewControllerContextTransitioning
//extension LXTransitionVC: UIViewControllerContextTransitioning {}

// MARK: - UIViewControllerTransitionCoordinator
extension LXTransitionVC: UIViewControllerTransitionCoordinator {
    func animate(alongsideTransition animation: ((UIViewControllerTransitionCoordinatorContext) -> Void)?, completion: ((UIViewControllerTransitionCoordinatorContext) -> Void)? = nil) -> Bool {
        return true
    }
    
    func animateAlongsideTransition(in view: UIView?, animation: ((UIViewControllerTransitionCoordinatorContext) -> Void)?, completion: ((UIViewControllerTransitionCoordinatorContext) -> Void)? = nil) -> Bool {
        return true
    }
    
    func notifyWhenInteractionEnds(_ handler: @escaping (UIViewControllerTransitionCoordinatorContext) -> Void) {}
    
    func notifyWhenInteractionChanges(_ handler: @escaping (UIViewControllerTransitionCoordinatorContext) -> Void) {}
}

// MARK: - UIViewControllerTransitionCoordinatorContext
extension LXTransitionVC: UIViewControllerTransitionCoordinatorContext {
    var isAnimated: Bool {
        return true
    }
    
    var presentationStyle: UIModalPresentationStyle {
        return .fullScreen
    }
    
    var initiallyInteractive: Bool {
        return true
    }
    
    var isInterruptible: Bool {
        return true
    }
    
    var isInteractive: Bool {
        return true
    }
    
    var isCancelled: Bool {
        return true
    }
    
    var transitionDuration: TimeInterval {
        return 1
    }
    
    var percentComplete: CGFloat {
        return 1
    }
    
    var completionVelocity: CGFloat {
        return 1
    }
    
    var completionCurve: UIView.AnimationCurve {
        return .easeInOut
    }
    
    func viewController(forKey key: UITransitionContextViewControllerKey) -> UIViewController? {
        return nil
    }
    
    func view(forKey key: UITransitionContextViewKey) -> UIView? {
        return nil
    }
    
    var containerView: UIView {
        return UIView()
    }
    
    var targetTransform: CGAffineTransform {
        return .identity
    }
}

// MARK: - UIViewControllerTransitioningDelegate
extension LXTransitionVC: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return nil
    }
}

// MARK: - UINavigationControllerDelegate
extension LXTransitionVC: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}

// MARK: - UITabBarControllerDelegate
extension LXTransitionVC: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}

// MARK: - UI Prepare & Masonry
extension LXTransitionVC {
    open override func prepareUI() {
        super.prepareUI()
        //[<#table#>].forEach(self.view.addSubview)
        masonry()
    }
    
    open override func masonry() {
        super.masonry()
    }
}
