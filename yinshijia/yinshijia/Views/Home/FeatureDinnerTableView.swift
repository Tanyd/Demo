//
//  FeatureDinnerTableView.swift
//  yinshijia
//
//  Created by tanyadong on 16/6/18.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class FeatureDinnerTableView: UITableView {

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
    }
    
    private func setUI() {
        var titleLable = UILabel.lableCutomer("特色菜品", fontType: nil, color: UIColor.blackColor(), fontSize: 15)
        titleLable.textAlignment = .Center
        titleLable.frame = CGRectMake(0, 0, 0, 145.0.fitHeight())
        tableHeaderView = titleLable
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
