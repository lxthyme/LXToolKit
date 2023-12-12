//
//  Controller.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/12/11.
//
import UIKit

@objc public protocol FloatingPanelControllerDelegate {
    /// Returns a FloatingPanelLayout object. If you use the default one, you can use a `FloatingPanelBottomLayout` object.
    @objc(floatingPanel:layoutForTraitCollection:) optional
    func floatingPanel(_ fpc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout

    /// Returns a FloatingPanelLayout object. If you use the default one, you can use a `FloatingPanelBottomLayout` object.
    @objc(floatingPanel:layoutForSize:) optional
    func floatingPanel(_ fpc: FloatingPanelController, layoutFor size: CGSize) -> FloatingPanelLayout

    /// Returns a UIViewPropertyAnimator object to add/present the  panel to a position.
    ///
    /// Default is the spring animation with 0.25 secs.
    @objc(floatingPanel:animatorForPresentingToState:) optional
    func floatingPanel(_ fpc: FloatingPanelController, animatorForPresentingTo state: FloatingPanelState) -> UIViewPropertyAnimator

    /// Returns a UIViewPropertyAnimator object to remove/dismiss a panel from a position.
    ///
    /// Default is the spring animator with 0.25 secs.
    @objc(floatingPanel:animatorForDismissingWithVelocity:) optional
    func floatingPanel(_ fpc: FloatingPanelController, animatorForDismissingWith velocity: CGVector) -> UIViewPropertyAnimator

    /// Called when a panel has changed to a new state.
    ///
    /// This can be called inside an animation block for presenting, dismissing a panel or moving a panel with your
    /// animation. So any view properties set inside this function will be automatically animated alongside a panel.
    @objc optional
    func floatingPanelDidChangeState(_ fpc: FloatingPanelController)

    /// Asks the delegate if dragging should begin by the pan gesture recognizer.
    @objc optional
    func floatingPanelShouldBeginDragging(_ fpc: FloatingPanelController) -> Bool

    /// Called while the user drags the surface or the surface moves to a state anchor.
    @objc optional
    func floatingPanelDidMove(_ fpc: FloatingPanelController)

    /// Called on start of dragging (may require some time and or distance to move)
    @objc optional
    func floatingPanelWillBeginDragging(_ fpc: FloatingPanelController)

    /// Called on finger up if the user dragged. velocity is in points/second.
    @objc optional
    func floatingPanelWillEndDragging(_ fpc: FloatingPanelController, withVelocity velocity: CGPoint, targetState: UnsafeMutablePointer<FloatingPanelState>)

    /// Called on finger up if the user dragged.
    ///
    /// If `attract` is true, the panel continues moving towards the nearby state
    /// anchor. Otherwise, it stops at the closest state anchor.
    ///
    /// - Note: If `attract` is false, ``FloatingPanelController.state`` property has
    ///   already changed to the closest anchor's state by the time this delegate method
    ///   is called.
    @objc optional
    func floatingPanelDidEndDragging(_ fpc: FloatingPanelController, willAttract attract: Bool)

    /// Called when it is about to be attracted to a state anchor.
    @objc optional
    func floatingPanelWillBeginAttracting(_ fpc: FloatingPanelController, to state: FloatingPanelState) // called on finger up as a panel are moving

    /// Called when attracting it is completed.
    @objc optional
    func floatingPanelDidEndAttracting(_ fpc: FloatingPanelController) // called when a panel stops

    /// Asks the delegate whether a panel should be removed when dragging ended at the specified location
    ///
    /// This delegate method is called only where ``FloatingPanel/FloatingPanelController/isRemovalInteractionEnabled``  is `true`.
    /// The velocity vector is calculated from the distance to a point of the hidden state and the pan gesture's velocity.
    @objc(floatingPanel:shouldRemoveAtLocation:withVelocity:)
    optional
    func floatingPanel(_ fpc: FloatingPanelController, shouldRemoveAt location: CGPoint, with velocity: CGVector) -> Bool

    /// Called on start to remove its view controller from the parent view controller.
    @objc(floatingPanelWillRemove:)
    optional
    func floatingPanelWillRemove(_ fpc: FloatingPanelController)

    /// Called when a panel is removed from the parent view controller.
    @objc optional
    func floatingPanelDidRemove(_ fpc: FloatingPanelController)

    /// Asks the delegate for a content offset of the tracking scroll view to be pinned when a panel moves
    ///
    /// If you do not implement this method, the controller uses a value of the content offset plus the content insets
    /// of the tracked scroll view. Your implementation of this method can return a value for a navigation bar with a large
    /// title, for example.
    ///
    /// This method will not be called if the controller doesn't track any scroll view.
    @objc(floatingPanel:contentOffsetForPinningScrollView:)
    optional
    func floatingPanel(_ fpc: FloatingPanelController, contentOffsetForPinning trackingScrollView: UIScrollView) -> CGPoint

    /// Returns a Boolean value that determines whether the tracking scroll view should
    /// scroll or not
    ///
    ///
    /// If you return true, the scroll content scrolls when its scroll position is not
    /// at the top of the content. If the delegate doesn’t implement this method, its
    /// content can be scrolled only in the most expanded state.
    ///
    /// Basically, the decision to scroll is based on the `state` property like the
    /// following code.
    /// ```swift
    /// func floatingPanel(
    ///     _ fpc: FloatingPanelController,
    ///     shouldAllowToScroll scrollView: UIScrollView,
    ///     in state: FloatingPanelState
    /// ) -> Bool {
    ///     return state == .full || state == .half
    /// }
    /// ```
    ///
    /// - Attention: It is recommended that this method always returns the most expanded state(i.e.
    /// .full). If it excludes the state, the panel might do unexpected behaviors.
    @objc(floatingPanel:shouldAllowToScroll:in:)
    optional func floatingPanel(
        _ fpc: FloatingPanelController,
        shouldAllowToScroll scrollView: UIScrollView,
        in state: FloatingPanelState
    ) -> Bool
}

class FloatingPanelController: LXBaseDeinitVC {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
    }

}

// MARK: 🌎LoadData
extension Controller {}

// MARK: 👀Public Actions
extension Controller {}

// MARK: 🔐Private Actions
private extension Controller {}

// MARK: - 🍺UI Prepare & Masonry
private extension Controller {
    func prepareUI() {
        self.view.backgroundColor = .white
        // navigationItem.title = ""

        // [<#table#>].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {}
}
