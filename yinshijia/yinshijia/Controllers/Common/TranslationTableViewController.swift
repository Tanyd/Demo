//
//  BaseTableViewController.swift
//  yinshijia
//
//  Created by Developer on 16/6/10.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

struct BaseTranslationViewControllerNotification {
    static let NotificationName = "BaseTableViewControllerNotification"
    static let CurrentOffY = "CurrentOffY"
    static let OldOffY = "OldOffY"
}

class TranslationTableViewController: UITableViewController {

    private var didUpdateConstraints = false
    var oldOffYes: CGFloat = 0
    var tableDidScroll: ((offY: CGFloat) -> ())?
    private var toTopIcon: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefresh()
        setUI()
    }
    
    func setupRefresh() {
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: "tableRefreshHeader")
        tableView.mj_header = header
        let footer = MJRefreshBackStateFooter(refreshingTarget: self, refreshingAction: "tableRefreshFooter")
        footer.setTitle("没有更多数据", forState: MJRefreshState.NoMoreData)
        tableView.mj_footer = footer
    }
    
    func tableRefreshHeader() {
      
    }
    
    func tableRefreshFooter() {
       
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    private func setUI() {
        
        if tableView.respondsToSelector("setSeparatorInset:"){
            tableView.separatorInset = UIEdgeInsetsZero
        }
        if tableView.respondsToSelector("setLayoutMargins:"){
            tableView.layoutMargins = UIEdgeInsetsZero
        }

    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        oldOffYes = scrollView.contentOffset.y
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        NSNotificationCenter.defaultCenter().postNotificationName(BaseTranslationViewControllerNotification.NotificationName, object: nil, userInfo: [BaseTranslationViewControllerNotification.CurrentOffY:scrollView.contentOffset.y,BaseTranslationViewControllerNotification.OldOffY:oldOffYes])
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if cell.respondsToSelector("setLayoutMargins:"){
            cell.layoutMargins = UIEdgeInsetsZero
        }
        if cell.respondsToSelector("setSeparatorInset:"){
            cell.separatorInset = UIEdgeInsetsZero
        }
    }


}
