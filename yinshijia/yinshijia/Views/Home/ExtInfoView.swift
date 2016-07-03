//
//  ExtInfoView.swift
//  yinshijia
//
//  Created by tanyadong on 16/7/3.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class ExtInfoView: UITableView {
    
    private var sectionTitles = ["饭局信息","交通指南"]
    var extInfos = [[String]](){
        didSet{
            reloadData()
        }
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        setUI()
    }
    
    private func setUI() {
        rowHeight = 30
        scrollEnabled = false
        separatorStyle = .None
        dataSource = self
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ExtInfoView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(String(ExtInfoView))
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: String(ExtInfoView))
        }
        cell?.selectionStyle = .None
        cell?.textLabel?.font = UIFont.systemFontOfSize(12)
        cell?.textLabel?.textColor = UIColor.grayColor()
        let model = extInfos[indexPath.section][indexPath.row]
        cell?.textLabel?.text = "· " + model
        return cell!
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: 100.0.fitHeight()))
        let lable = UILabel.lableCutomer(sectionTitles[section], fontType: Constant.Common.BoldFont, color: UIColor.blackColor(), fontSize: 15)
        lable.frame = CGRectMake(50.0.fitWidth(), 30.0.fitHeight(), ScreenSize.SCREEN_WIDTH, 50.0.fitHeight())
        view.addSubview(lable)
        return view
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100.0.fitHeight()
    }
}