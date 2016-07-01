//
//  MenuTable.swift
//  yinshijia
//
//  Created by tanyadong on 16/6/19.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class MenuTable: UITableView {

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        setUI()
    }
    
    private func setUI() {
        estimatedRowHeight = 70
        rowHeight = UITableViewAutomaticDimension
        scrollEnabled = false
        separatorStyle = .None
        let headerImg = UIImageView(frame: CGRectMake(0, 0, 0, 145.0.fitHeight()))
        headerImg.image = UIImage(named: "menu_icon")
        headerImg.contentMode = .Center
        tableHeaderView = headerImg
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
