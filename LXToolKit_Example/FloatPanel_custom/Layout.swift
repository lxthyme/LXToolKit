//
//  Layout.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/12/11.
//

import Foundation

@objc public protocol FloatingPanelLayout {
    /// Returns the position of a panel in a `FloatingPanelController` view .
    @objc var position: FloatingPanelPosition { get }

    /// Returns the initial state when a panel is presented.
    @objc var initialState: FloatingPanelState { get }

    /// Returns the layout anchors to specify the snapping locations for each state.
    @objc var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] { get }

    /// Returns layout constraints to determine the cross dimension of a panel.
    @objc optional func prepareLayout(surfaceView: UIView, in view: UIView) -> [NSLayoutConstraint]

    /// Returns the alpha value of the backdrop of a panel for each state.
    @objc optional func backdropAlpha(for state: FloatingPanelState) -> CGFloat
}
