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
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
