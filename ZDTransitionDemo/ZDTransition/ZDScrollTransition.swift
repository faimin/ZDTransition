//
//  ZDScrollTransition.swift
//  Demo
//
//  Created by Zero on 2016/10/14.
//  Copyright © 2016年 Zero.D.Saber. All rights reserved.
//

import UIKit
import Foundation

let duration: TimeInterval = 0.3

class ZDScrollTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    //MARK: UIViewControllerAnimatedTransitioning
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration;
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        let containerView = transitionContext.containerView
        
        
        // http://swift.gg/2016/04/13/swift-qa-2016-04-13/
        var snapShortView: UIView
        if #available(iOS 10, *) {
            snapShortView = zd_snapShortView(fromView!)
        } else {
            snapShortView = (fromView?.snapshotView(afterScreenUpdates: false))!
        }
        
        snapShortView.frame = CGRect(x: 0, y: 0, width: containerView.bounds.width, height: containerView.bounds.height)
        
        containerView.addSubview(snapShortView)
        containerView.addSubview(toView!)
        
        UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions.curveEaseIn, animations: { 
            toView?.transform = CGAffineTransform(translationX: 0, y: -containerView.bounds.height/2)
            }) { (finished) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }
    
    //MARK: Private Method
    private func zd_snapShortView(_ view: UIView) -> UIView {
        UIGraphicsBeginImageContext(view.frame.size)
        let context = UIGraphicsGetCurrentContext()
        view.layer.render(in: context!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let imageView = UIImageView.init(image: image)
        return imageView
    }
}
