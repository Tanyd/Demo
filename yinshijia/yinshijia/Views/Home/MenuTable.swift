//
//  MenuTable.swift
//  yinshijia
//
//  Created by tanyadong on 16/6/19.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class MenuTable: UITableView {

    var plainMenus = [Plainmenu](){
        didSet{
            reloadData()
        }
    }

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        setUI()
    }
    
    private func setUI() {
        estimatedRowHeight = 70
        rowHeight = UITableViewAutomaticDimension
        scrollEnabled = false
        separatorStyle = .None
        registerClass(MenuCell.self, forCellReuseIdentifier: String(MenuCell))
        dataSource = self
        delegate = self
        let headerImg = UIImageView(frame: CGRectMake(0, 0, 0, 145.0.fitHeight()))
        headerImg.image = UIImage(named: "menu_icon")
        headerImg.contentMode = .Center
        tableHeaderView = headerImg
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension MenuTable: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plainMenus.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(String(MenuCell)) as? MenuCell
        if cell == nil {
            cell = MenuCell(style: .Default, reuseIdentifier: String(MenuCell))
        }
        cell?.selectionStyle = .None
        cell?.model = plainMenus[indexPath.row]
        return cell!
    }
}