//
//  FeatureDinnerTableView.swift
//  yinshijia
//
//  Created by tanyadong on 16/6/18.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class FeatureDinnerTableView: UITableView {

    var model = [Menu](){
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
        let titleLable = UILabel.lableCutomer("特色菜品", fontType: nil, color: UIColor.blackColor(), fontSize: 15)
        titleLable.textAlignment = .Center
        titleLable.frame = CGRectMake(0, 0, 0, 145.0.fitHeight())
        tableHeaderView = titleLable
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension FeatureDinnerTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(String(FeatureDinnerDetailCell)) as? FeatureDinnerDetailCell
        if cell == nil {
            cell = FeatureDinnerDetailCell(style: .Default, reuseIdentifier: String(FeatureDinnerDetailCell))
        }
        cell?.model = model[indexPath.row]
        cell?.selectionStyle = .None
        return cell!
    }
}