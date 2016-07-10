//
//  ChefInfoViewController.swift
//  yinshijia
//
//  Created by Developer on 16/7/6.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class ChefInfoViewController: UITableViewController {

    private var headerView: ChefInfoHeaderView!
    private let sectionTitles = ["主厨手作","精致私宴","环境","特色菜品","主厨地址","历史饭局","食客评价"]
    var chefID: Int = 0{
        didSet{
            loadBaseDate()
        }
    }
    private var chefModel: ChefInfo?
    override func viewDidLoad() {
        super.viewDidLoad()
        fd_interactivePopDisabled = true
        SVProgressHUD.showWithStatus("加载中", maskType: .Clear, style: .Light)
        setUI()
    }
    
    private func loadBaseDate() {
        let callBack: BaseApiCallBack = {[weak self](result, error) in
            guard error == nil else {
                return
            }
            let model = result as? ChefInfo
            self!.chefModel = model
            self!.headerView.model = ((model?.data?.baseInfo?.converurl)!,
                                      (model?.data?.baseInfo?.orderedCount)!,
                                      (model?.data?.baseInfo?.likeCount)!,
                                      (model?.data?.commentNum)!)
            self!.tableView.reloadData()
            self!.headerView.hidden = false
            SVProgressHUD.dismiss()
        }
        ChefInfo.loadChefInfo(callBack, id: chefID)
    }
    
    private func setUI() {
        tableView.backgroundColor = UIColor.whiteColor()
        headerView = ChefInfoHeaderView(frame: CGRectMake(0, 0, ScreenSize.SCREEN_WIDTH, 425.0.fitHeight()), commentAction: {
            
        })
        headerView.hidden = true
        tableView.tableHeaderView = headerView
        tableView.registerClass(ChefInfoCell.self, forCellReuseIdentifier: String(ChefInfoCell))
        tableView.registerClass(ChefInfoMarksCell.self, forCellReuseIdentifier: String(ChefInfoMarksCell))
        tableView.registerClass(PersonalDinnerCell.self, forCellReuseIdentifier: String(PersonalDinnerCell))
        tableView.registerClass(PersonalDinnerCell.self, forCellReuseIdentifier: "goods" + String(PersonalDinnerCell))
        tableView.registerClass(EnvironmentScrollCell.self, forCellReuseIdentifier: String(EnvironmentScrollCell))
        tableView.registerClass(FeatureDinnerCell.self, forCellReuseIdentifier: String(FeatureDinnerCell))
        tableView.registerClass(AddressInfoCell.self, forCellReuseIdentifier: String(AddressInfoCell))
        tableView.registerClass(HistoryDinnerCell.self, forCellReuseIdentifier: String(HistoryDinnerCell))
        tableView.registerClass(CommentCell.self, forCellReuseIdentifier: String(CommentCell))
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return (chefModel == nil) ? 0 : 9

    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier(String(ChefInfoCell)) as? ChefInfoCell
            if cell == nil {
                cell = ChefInfoCell(style: .Default, reuseIdentifier: String(ChefInfoCell))
            }
            let cell = cell as! ChefInfoCell
            cell.type = .ChefInfo
            cell.configureChefModel(chefModel?.data?.baseInfo)
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier(String(ChefInfoMarksCell)) as? ChefInfoMarksCell
            if cell == nil {
                cell = ChefInfoMarksCell(style: .Default, reuseIdentifier: String(ChefInfoMarksCell))
            }
            let cell = cell as! ChefInfoMarksCell
            cell.configureModel(chefModel?.data?.baseInfo?.tags)
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier("goods" + String(PersonalDinnerCell)) as? PersonalDinnerCell
            if cell == nil {
                cell = PersonalDinnerCell(style: .Default, reuseIdentifier: "goods" + String(PersonalDinnerCell))
            }
            let cell = cell as! PersonalDinnerCell
            if chefModel?.data?.goods?.count > 0 {
                cell.configureModel(chefModel, type: .GoodsType)
            }
        case 3:
            cell = tableView.dequeueReusableCellWithIdentifier(String(PersonalDinnerCell)) as? PersonalDinnerCell
            if cell == nil {
                cell = PersonalDinnerCell(style: .Default, reuseIdentifier: String(PersonalDinnerCell))
            }
            let cell = cell as! PersonalDinnerCell
            if chefModel?.data?.themeDinner?.count > 0 {
                cell.configureModel(chefModel, type: .CustomeMadeType)
            }
        case 4:
            cell = tableView.dequeueReusableCellWithIdentifier(String(EnvironmentScrollCell)) as? EnvironmentScrollCell
            if cell == nil {
                cell = EnvironmentScrollCell(style: .Default, reuseIdentifier: String(EnvironmentScrollCell))
            }
            let cell = cell as! EnvironmentScrollCell
            if chefModel?.data?.kitchenImage?.count > 0 {
                cell.configureModel(chefModel?.data?.kitchenImage)
            }
        case 5:
            cell = tableView.dequeueReusableCellWithIdentifier(String(FeatureDinnerCell)) as? FeatureDinnerCell
            if cell == nil {
                cell = FeatureDinnerCell(style: .Default, reuseIdentifier: String(FeatureDinnerCell))
            }
            let cell = cell as! FeatureDinnerCell
            if chefModel?.data?.menu?.count > 0 {
                cell.configureModel(chefModel?.data?.menu)
            }
        case 6:
            cell = tableView.dequeueReusableCellWithIdentifier(String(AddressInfoCell)) as? AddressInfoCell
            if cell == nil {
                cell = AddressInfoCell(style: .Default, reuseIdentifier: String(AddressInfoCell))
            }
            let cell = cell as! AddressInfoCell
            cell.configureModel(chefModel?.data?.address?.address, mapUrl: chefModel?.data?.address?.mapImageUrl)
        case 7:
            cell = tableView.dequeueReusableCellWithIdentifier(String(HistoryDinnerCell)) as? HistoryDinnerCell
            if cell == nil {
                cell = HistoryDinnerCell(style: .Default, reuseIdentifier: String(HistoryDinnerCell))
            }
            let cell = cell as! HistoryDinnerCell
            cell.configureModel(chefModel)
        case 8:
            cell = tableView.dequeueReusableCellWithIdentifier(String(CommentCell)) as? CommentCell
            if cell == nil {
                cell = CommentCell(style: .Default, reuseIdentifier: String(CommentCell))
            }
            let cell = cell as! CommentCell
            if chefModel?.data?.comment?.count > 0 {
                cell.configureModel(chefModel?.data?.comment)
            }
        default:
            break
        }
        cell?.selectionStyle = .None
        return cell!
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(String(ChefInfoSectionHeaderView)) as? ChefInfoSectionHeaderView
        if header == nil {
            header = ChefInfoSectionHeaderView(reuseIdentifier: String(ChefInfoSectionHeaderView))
        }
        header?.title = sectionTitles[section - 2]
        return header
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0,1:
            return 0
        default:
            if section == 2 && chefModel?.data?.goods?.count == 0 {
                return 0
            }
            if section == 3 && chefModel?.data?.themeDinner?.count == 0 {
                return 0
            }
            if section == 4 && chefModel?.data?.kitchenImage?.count == 0 {
                return 0
            }
            if section == 5 && chefModel?.data?.menu?.count == 0 {
                return 0
            }
            if section == 7 && chefModel?.data?.historyDinner?.count == 0 && chefModel?.data?.historyCustomMadeDinner?.count == 0 {
                return 0
            }
            if section == 8 && chefModel?.data?.comment?.count == 0{
                return 0
            }
            return 85.0.fitHeight()
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return tableView.fd_heightForCellWithIdentifier(String(ChefInfoCell), cacheByIndexPath: indexPath, configuration: { (cell) in
                let cell = cell as! ChefInfoCell
                cell.type = .ChefInfo
                cell.configureChefModel(self.chefModel?.data?.baseInfo)
            })
            
        case 1:
            return tableView.fd_heightForCellWithIdentifier(String(ChefInfoMarksCell), cacheByIndexPath: indexPath, configuration: { (cell) in
                let cell = cell as! ChefInfoMarksCell
                cell.configureModel(self.chefModel?.data?.baseInfo?.tags)
            })
            
        case 2:
            if chefModel?.data?.goods?.count > 0 {
                return tableView.fd_heightForCellWithIdentifier("goods" + String(PersonalDinnerCell), cacheByIndexPath: indexPath, configuration: { (cell) in
                    let cell = cell as! PersonalDinnerCell
                    cell.configureModel(self.chefModel, type: .GoodsType)
                })
            }else {
                return 0
            }
        case 3:
            if chefModel?.data?.themeDinner?.count > 0 {
                return tableView.fd_heightForCellWithIdentifier(String(PersonalDinnerCell), cacheByIndexPath: indexPath, configuration: { (cell) in
                    let cell = cell as! PersonalDinnerCell
                    cell.configureModel(self.chefModel, type: .CustomeMadeType)
                })
            }else {
                return 0
            }
        case 4:
            if chefModel?.data?.kitchenImage?.count > 0 {
                return 550.0.fitHeight()
            }else{
                return 0
            }
        case 5:
            if chefModel?.data?.menu?.count > 0 {
                return tableView.fd_heightForCellWithIdentifier(String(FeatureDinnerCell), cacheByIndexPath: indexPath, configuration: { (cell) in
                    let cell = cell as! FeatureDinnerCell
                    cell.configureModel(self.chefModel?.data?.menu)
                })
            }else{
                return 0
            }
        case 6:
            return tableView.fd_heightForCellWithIdentifier(String(AddressInfoCell), cacheByIndexPath: indexPath, configuration: { (cell) in
                let cell = cell as! AddressInfoCell
                cell.configureModel(self.chefModel?.data?.address?.address, mapUrl: self.chefModel?.data?.address?.mapImageUrl)
            })
        case 7:
            if chefModel?.data?.historyCustomMadeDinner?.count > 0 || chefModel?.data?.historyDinner?.count > 0 {
                return tableView.fd_heightForCellWithIdentifier(String(HistoryDinnerCell), cacheByIndexPath: indexPath, configuration: { (cell) in
                    let cell = cell as! HistoryDinnerCell
                    cell.configureModel(self.chefModel)
                })
            }else{
                return 0
            }
        case 8:
            if chefModel?.data?.comment?.count > 0 {
                return tableView.fd_heightForCellWithIdentifier(String(CommentCell), cacheByIndexPath: indexPath, configuration: { (cell) in
                    let cell = cell as! CommentCell
                    cell.configureModel(self.chefModel?.data?.comment)
                })
            }else{
                return 0
            }
        default:
            return 0
        }

    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let sectionHeaderHeight: CGFloat = 85.0.fitHeight()
        if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y > 0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0)
        } else {
            if (scrollView.contentOffset.y >= sectionHeaderHeight) {
                scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0)
            }
        }

    }
}
