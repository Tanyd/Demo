//
//  BaseTabBarController.swift
//  yinshijia
//
//  Created by Developer on 16/6/10.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

     
    override func viewDidLoad() {
        super.viewDidLoad()
        setChildViewControllers()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let tabbar = Tabbar(frame: tabBar.bounds)
        self.setValue(tabbar, forKey: "tabBar")
    }

    private func setChildViewControllers() {
        addChildViewController(HomeViewController(), title: "首页", imageName: "dock_home_unselected", selectedImgName: "dock_home_selected")
        addChildViewController(DiscoverViewController(), title: "发现", imageName: "dock_discovery_unselected", selectedImgName: "dock_discovery_selected")
        addChildViewController(OrderViewController(), title: "订单", imageName: "dock_order_unselected", selectedImgName: "dock_order_selected")
        addChildViewController(MeViewController(), title: "我的", imageName: "dock_self_unselected", selectedImgName: "dock_self_selected")
    }
    
    
    func addChildViewController(childController: BaseViewController, title: String? ,imageName: String,selectedImgName: String) ->BaseNavigationController {
        childController.tabBarItem.image = UIImage(named: imageName)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        childController.tabBarItem.selectedImage = UIImage(named: selectedImgName)!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        childController.title = title
        childController.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:Constant.Common.GrayColor], forState: .Normal)
        childController.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:Constant.Common.OrangeColor], forState: .Selected)
        childController.tabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFontOfSize(11)], forState: .Selected)
        childController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -3)
        let nav = BaseNavigationController(rootViewController: childController)
        addChildViewController(nav)
        return nav
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
