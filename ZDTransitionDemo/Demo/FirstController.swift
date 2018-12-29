//
//  ViewController.swift
//  Demo
//
//  Created by 符现超 on 2016/10/14.
//  Copyright © 2016年 Zero.D.Saber. All rights reserved.
//

import UIKit

class FirstController: UIViewController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if ((self.navigationController?.delegate = self) != nil) {
            self.navigationController?.delegate = nil
        }
    }
    
    //MARK: UINavigationControllerDelegate
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC == self {
            return ZDScrollTransition()
        }
        return nil
    }
}

