//
//  DinnerDetailTableView.swift
//  yinshijia
//
//  Created by tanyadong on 16/6/18.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class DinnerDetailTableView: UITableView {

    private var banner: BannerView?

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        setUI()
    }
    
    private func setUI(){
        banner = BannerView(frame: CGRectMake(0, 0, 0, 600.0.fitHeight()), focusImageViewClick: { (index) in
            
        })
        tableHeaderView = banner
        
        delegate = self
        dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DinnerDetailTableView:  UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        return cell
    }
}