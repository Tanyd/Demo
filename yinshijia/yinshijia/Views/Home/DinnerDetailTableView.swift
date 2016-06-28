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
    var model: ChefDinner?{
        didSet{
            banner?.imgs = (model?.data?.baseInfo?.theme_images?.componentsSeparatedByString(","))!
            reloadData()
        }
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        setUI()
    }
    
    private func setUI(){
        banner = BannerView(frame: CGRectMake(0, -64, ScreenSize.SCREEN_WIDTH, 600.0.fitHeight()), focusImageViewClick: { (index) in
            
        })
        registerClass(DinnerDetailIntroductionCell.self, forCellReuseIdentifier: String(DinnerDetailIntroductionCell))
        registerClass(ChefInfoCell.self, forCellReuseIdentifier: String(ChefInfoCell))
        registerClass(FeatureDinnerCell.self, forCellReuseIdentifier: String(FeatureDinnerCell))
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
        return (model == nil ? 0 : 3)
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier(String(DinnerDetailIntroductionCell)) as? DinnerDetailIntroductionCell
            if cell == nil {
                cell = DinnerDetailIntroductionCell(style: .Default, reuseIdentifier: String(DinnerDetailIntroductionCell))
            }
            let cell = cell as! DinnerDetailIntroductionCell
            cell.configureModel(model)
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier(String(ChefInfoCell)) as? ChefInfoCell
            if cell == nil {
                cell = ChefInfoCell(style: .Default, reuseIdentifier: String(ChefInfoCell))
            }
            let cell = cell as! ChefInfoCell
            cell.configureModel(model)
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier(String(FeatureDinnerCell)) as? FeatureDinnerCell
            if cell == nil {
                cell = FeatureDinnerCell(style: .Default, reuseIdentifier: String(FeatureDinnerCell))
            }
            let cell = cell as! FeatureDinnerCell
            cell.configureModel(model)
//        case 3:
//            cell = tableView.dequeueReusableCellWithIdentifier(String(MoreInfoCell)) as? MoreInfoCell
//            if cell == nil {
//                cell = MoreInfoCell(style: .Default, reuseIdentifier: String(MoreInfoCell))
//            }
//            let cell = cell as! MoreInfoCell
//            cell.plainMenus = (model?.data?.plainMenu)!
        default:
            break
        }
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        switch indexPath.row {
        case 0:
            return tableView.fd_heightForCellWithIdentifier(String(DinnerDetailIntroductionCell), cacheByIndexPath: indexPath, configuration: { (cell) in
                let cell = cell as! DinnerDetailIntroductionCell
                cell.configureModel(self.model)
            })

        case 1:
            return tableView.fd_heightForCellWithIdentifier(String(ChefInfoCell), cacheByIndexPath: indexPath, configuration: { (cell) in
                let cell = cell as! ChefInfoCell
                cell.configureModel(self.model)
            })
            
        case 2:
            if model?.data?.menu?.count > 0 {
                return tableView.fd_heightForCellWithIdentifier(String(FeatureDinnerCell), cacheByIndexPath: indexPath, configuration: { (cell) in
                    let cell = cell as! FeatureDinnerCell
                    cell.configureModel(self.model)
                })
            }else {
                return 0
            }
           
        default:
            return 0
        }
        
    }
}