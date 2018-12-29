//
//  ZDPresentationController.swift
//  Demo
//
//  Created by Zero.D.Saber on 2018/12/29.
//  Copyright © 2018 Zero.D.Saber. All rights reserved.
//
//  底部弹窗 https://juejin.im/post/5a9651d25188257a5911f666

import Foundation
import UIKit

public protocol PresentFromBottomVCProtocol {
    var controllerHeight: CGFloat { get }
}

//MARK: -

class ZDBottomPresentationController: UIPresentationController {
    deinit {
        print("-[ZDBottomPresentationController dealloc]")
    }
    
    public var controllerHeight: CGFloat = 0
    
    lazy var blackView: UIView = {
        let view = UIView()
        if let frame = self.containerView?.bounds {
            view.frame = frame
        }
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hide))
        return view
    }()
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    // MARK: - Present animation
    override func presentationTransitionWillBegin() {
        blackView.alpha = 0
        containerView?.addSubview(blackView)
        UIView.animate(withDuration: 0.25) {
            self.blackView.alpha = 1
        }
    }
    
    override func dismissalTransitionWillBegin() {
        UIView.animate(withDuration: 0.25) {
            self.blackView.alpha = 0
        }
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            blackView.removeFromSuperview()
        }
    }
    
    //MARK:
    override var frameOfPresentedViewInContainerView: CGRect {
        let screenBounds = UIScreen.main.bounds
        return CGRect(x: 0, y: screenBounds.height-controllerHeight, width: screenBounds.width, height: controllerHeight)
    }
    
    //MARK: Action
    @objc func hide() {
        
    }
}

//MARK: -
extension UIViewController: UIViewControllerTransitioningDelegate {
    
    //MARK: - UIViewControllerTransitioningDelegate
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = ZDBottomPresentationController(presentedViewController: presented, presenting: presenting)
        return presentationController
    }
    
    //MARK: - Public Method
    public func presentFromBottom(_ vc: UIViewController & PresentFromBottomVCProtocol) {
//        let vc = VCClass.init()
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
}



