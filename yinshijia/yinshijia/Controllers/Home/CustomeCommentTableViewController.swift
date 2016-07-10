//
//  CustomeCommentTableViewController.swift
//  yinshijia
//
//  Created by Developer on 16/7/5.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class CustomeCommentTableViewController: UITableViewController {
    
    var comments = [Comment](){
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableViewAutomaticDimension
        setUI()
    }
    
    private func setUI() {
        tableView.registerClass(CustomeCommentCell.self, forCellReuseIdentifier: String(CustomeCommentCell))
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(String(CustomeCommentCell)) as? CustomeCommentCell
        if cell == nil {
            cell = CustomeCommentCell(style: .Default, reuseIdentifier: String(CustomeCommentCell))
        }
        cell?.commentModel = comments[indexPath.row]
        return cell!
    }
    
    //MARK: UITableView+FDTemplateLayoutCell导致所有cell没有释放引起HJCornerRadius KVO错误
//    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return tableView.fd_heightForCellWithIdentifier(String(CustomeCommentCell), cacheByIndexPath: indexPath, configuration: { (cell) in
//            (cell as! CustomeCommentCell).commentModel = self.comments[indexPath.row]
//        })
//    }
}
