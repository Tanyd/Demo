//
//  BaseNavigationController.swift
//  yinshijia
//
//  Created by Developer on 16/6/10.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override class func initialize() {
        UINavigationBar.appearance().setBackgroundImage(UIImage.imageWithColor(UIColor.whiteColor()), forBarMetrics: .Default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UIBarButtonItem.appearance().setBackButtonBackgroundImage(UIImage(named: "rejuBackD")?.resizableImageWithCapInsets(UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)), forState: UIControlState.Normal, barMetrics: UIBarMetrics.Default)
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 0, vertical: -60), forBarMetrics: .Default)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func pushViewController(viewController: UIViewController, animated: Bool) {
        if childViewControllers.count > 0{
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
