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
        print("#line: " + String(#line) + ", #function: " + String(#function))
    }
    
    // 全局变量，记录模态视图的高度
    let controllerHeight: CGFloat
    
    lazy var blackView: UIView = {
        let view = UIView()
        if let frame = self.containerView?.bounds {
            view.frame = frame
        }
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hide))
        view.addGestureRecognizer(tapGesture)
        
        return view
    }()
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        if let vc = presentedViewController as? PresentFromBottomVCProtocol {
            controllerHeight = vc.controllerHeight;
        }
        else {
            controllerHeight = UIScreen.main.bounds.height
        }
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
        self.presentedViewController.dismiss(animated: true, completion: nil)
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
    // 继承自UIViewController且遵守PresentFromBottomVCProtocol协议
    public func presentFromBottom(_ vc: UIViewController & PresentFromBottomVCProtocol) {
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
}



