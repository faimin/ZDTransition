//
//  SecondController.swift
//  Demo
//
//  Created by Zero.D.Saber on 2016/10/14.
//  Copyright © 2016年 Zero.D.Saber. All rights reserved.
//

import UIKit

class SecondController: UIViewController, PresentFromBottomVCProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.cyan
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var controllerHeight: CGFloat {
        return UIScreen.main.bounds.height * 0.6
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
