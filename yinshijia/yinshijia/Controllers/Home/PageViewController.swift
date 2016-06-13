//
//  PageViewController.swift
//  yinshijia
//
//  Created by Developer on 16/6/10.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

protocol PageViewControllerDataSource: NSObjectProtocol {
    func childControllersInPageView(pageView: PageViewController) -> [UIViewController] 
}

protocol PageViewControllerDelegate: NSObjectProtocol {
    func pageViewExchangeView(fromIndex: Int,toIndex: Int)
}

class PageViewController: BaseViewController {

    private var basePage: UIPageViewController!
    private var childsVC = [UIViewController]()
    weak var dataSource: PageViewControllerDataSource?
    weak var delegate: PageViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        basePage = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        basePage.delegate = self
        basePage.dataSource = self
        basePage.view.frame = view.bounds
        
        (basePage.view.subviews[0] as! UIScrollView).delegate = self
        
        addChildViewController(basePage)
        view.addSubview(basePage.view)
        
        if dataSource != nil && (dataSource?.respondsToSelector("childControllersInPageView:"))! {
            childsVC = dataSource!.childControllersInPageView(self)
            guard  childsVC.count != 0 else {return}
            basePage.setViewControllers([childsVC[0]], direction: .Forward, animated: true, completion: nil)
        }
    }

    func exchangeChildView(fromIndex: Int, toIndex to: Int) ->Bool{
        guard to >= 0 && to < childsVC.count else {return false}
        let toVC = childsVC[to]
        let direction = fromIndex > to ? UIPageViewControllerNavigationDirection.Reverse : UIPageViewControllerNavigationDirection.Forward
        basePage.setViewControllers([toVC], direction: direction, animated: true, completion: nil)
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index =  childsVC.indexOf(viewController)
        if index == 0 || index == NSNotFound {
            return nil
        }else {
            index! -= 1
            return childsVC[index!]
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index =  childsVC.indexOf(viewController)
        if index == NSNotFound {
            return nil
        }
        index! += 1
        if index == childsVC.count {
            return nil
        }
        return childsVC[index!]
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard finished else {return}
        if delegate != nil && (delegate?.respondsToSelector("pageViewExchangeView:toIndex:"))!{
            delegate?.pageViewExchangeView((previousViewControllers.first?.view.tag)!, toIndex: (pageViewController.viewControllers?.first?.view.tag)!)
        }
    }

}

extension PageViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
       
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
    }
}