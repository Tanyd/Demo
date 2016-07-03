//
//  CustomeCommentTableView.swift
//  yinshijia
//
//  Created by tanyadong on 16/7/3.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class CustomeCommentTableView: UITableView {

    var commentModels = [Comment](){
        didSet{
            reloadData()
        }
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        setUI()
    }
    
    private func setUI() {
        delegate = self
        scrollEnabled = false
        dataSource = self
        estimatedRowHeight = 70
        rowHeight = UITableViewAutomaticDimension
        let titleLable = UILabel.lableCutomer("食客评价(0)", fontType: nil, color: UIColor.blackColor(), fontSize: 15)
        titleLable.textAlignment = .Center
        titleLable.frame = CGRectMake(0, 0, 0, 145.0.fitHeight())
        tableHeaderView = titleLable
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomeCommentTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentModels.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(String(CustomeCommentCell)) as? CustomeCommentCell
        if cell == nil {
            cell = CustomeCommentCell(style: .Default, reuseIdentifier: String(CustomeCommentCell))
        }
        cell?.commentModel = commentModels[indexPath.row]
        return cell!
    }
}