//
//  NavigationBarAnimationViewController.swift
//  yinshijia
//
//  Created by Developer on 16/7/8.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class NavigationBarAnimationViewController: BaseViewController {

    var backItem: UIButton!
    var rightItems = [UIButton]() {
        didSet{
            if rightItems.count == 1 {
                rightItems[0].frame = CGRect(x: 10, y: 0, width: 30, height: 30)
                navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: rightItems[0])]
            }else if rightItems.count == 2 {
                rightItems[0].frame = CGRect(x: 10, y: 0, width: 30, height: 30)
                rightItems[1].frame = CGRect(x: 10 + 30, y: 0, width: 30, height: 30)
                navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: rightItems[0]),UIBarButtonItem(customView: rightItems[1])]
            }
        }
    }
    var titleColorNormal: UIColor?{
        didSet{
            navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: titleColorNormal!]
        }
    }
    var titleColorSelected: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarAppearance()
        // Do any additional setup after loading the view.
    }
    
    private func setNavigationBarAppearance() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        backItem = UIButton(type: .Custom)
        backItem.frame = CGRect(x: 10, y: 0, width: 30, height: 30)
        backItem.setImage(UIImage(named: "rejuBack"), forState: .Normal)
        backItem.setImage(UIImage(named: "rejuBackD"), forState: .Selected)
        backItem.addTarget(self, action: "backItemClick", forControlEvents: .TouchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backItem)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        var alpha = contentOffsetY / ScreenSize.SCREEN_HEIGHT
        if alpha > 1 {
            alpha = 0.99
        }
        
        if alpha > 0.7 {
            for btn in rightItems {
                btn.selected = true
            }
            backItem.selected = true
            navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: titleColorSelected!]
        }else {
            for btn in rightItems {
                btn.selected = false
            }
            backItem.selected = false
            navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: titleColorNormal!]
        }
        
        navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(UIColor(white: 1.0, alpha: alpha)), forBarMetrics: UIBarMetrics.Default)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
