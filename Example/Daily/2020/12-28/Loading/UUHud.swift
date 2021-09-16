//
//  UUHud.swift
//  UUTeacher
//
//  Created by Derrick on 2018/11/13.
//  Copyright © 2018年 bike. All rights reserved.
//

import UIKit

public class UUHud: UIView {
    
//    private var animatImageV:YYAnimatedImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubview()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSubview() {
        
//        let image = YYImage(named: "loading")
//        animatImageV = YYAnimatedImageView(image: image)
//        animatImageV?.alpha = 0
//        addSubview(animatImageV!)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
//        animatImageV?.snp.makeConstraints({ (snp) in
//            snp.width.height.equalTo(150)
//            snp.center.equalTo(self.snp.center)
//        })
    }
    
    /// show in window
    @objc public class func showHud() {
        self.showHud(inView: UIApplication.shared.keyWindow!)
    }
    
    /// show in a view
    @objc public class func showHud(inView:UIView) {
        for view in inView.subviews {
            if view.isKind(of: UUHud.self) {
                UUHud.hideHud(inView: inView)
                return
            }
        }
        let hud = UUHud()
        hud.frame = inView.bounds
        inView.addSubview(hud)
//        hud.animatImageV?.transform = CGAffineTransform(scaleX: CGFloat(0.3), y: CGFloat(0.3))
//        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 5, options: UIView.AnimationOptions.curveEaseOut, animations: {
//            hud.animatImageV?.alpha = 1
//            hud.animatImageV?.transform = CGAffineTransform.identity
//            
//        }, completion: nil)
        
    }
    
    /// hide from window
    @objc public class func hideHud(){
        self.hideHud(inView: UIApplication.shared.keyWindow!)
    }
    
    /// hide from a view
    @objc public class func hideHud(inView:UIView){
        for view in inView.subviews {
            if view.isKind(of: UUHud.self) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    for view in inView.subviews {
                        if view.isKind(of: UUHud.self) {
                            view.removeFromSuperview()
                        }
                    }
                }
            }
        }
    }
}

