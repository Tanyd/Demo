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
    private var chefModel: ChefInfo?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        headerView = ChefInfoHeaderView(frame: CGRectMake(0, 0, ScreenSize.SCREEN_WIDTH, 425.0.fitHeight()), commentAction: { 
            
        })
        tableView.tableHeaderView = headerView
        tableView.registerClass(ChefInfoIntroductionCell.self, forCellReuseIdentifier: String(ChefInfoIntroductionCell))
        tableView.registerClass(ChefInfoMarksCell.self, forCellReuseIdentifier: String(ChefInfoMarksCell))
        tableView.registerClass(PersonalDinnerCell.self, forCellReuseIdentifier: String(PersonalDinnerCell))
        tableView.registerClass(EnvironmentScrollCell.self, forCellReuseIdentifier: String(EnvironmentScrollCell))
        tableView.registerClass(FeatureDinnerCell.self, forCellReuseIdentifier: String(FeatureDinnerCell))
        tableView.registerClass(AddressInfoCell.self, forCellReuseIdentifier: String(AddressInfoCell))
        tableView.registerClass(HistoryDinnerCell.self, forCellReuseIdentifier: String(HistoryDinnerCell))
        tableView.registerClass(CommentCell.self, forCellReuseIdentifier: String(CommentCell))
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (chefModel == nil) ? 0 : 9
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier(String(ChefInfoIntroductionCell)) as? ChefInfoIntroductionCell
            if cell == nil {
                cell = ChefInfoIntroductionCell(style: .Default, reuseIdentifier: String(ChefInfoIntroductionCell))
            }
            let cell = cell as! ChefInfoIntroductionCell
            cell.configureChefModel(chefModel)
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier(String(ChefInfoMarksCell)) as? ChefInfoMarksCell
            if cell == nil {
                cell = ChefInfoMarksCell(style: .Default, reuseIdentifier: String(ChefInfoMarksCell))
            }
            let cell = cell as! ChefInfoMarksCell
            cell.configureModel(chefModel)
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier(String(PersonalDinnerCell)) as? PersonalDinnerCell
            if cell == nil {
                cell = PersonalDinnerCell(style: .Default, reuseIdentifier: String(PersonalDinnerCell))
            }
            let cell = cell as! PersonalDinnerCell
            cell.configureModel(chefModel)
        case 3:
            cell = tableView.dequeueReusableCellWithIdentifier(String(PersonalDinnerCell)) as? PersonalDinnerCell
            if cell == nil {
                cell = PersonalDinnerCell(style: .Default, reuseIdentifier: String(PersonalDinnerCell))
            }
            let cell = cell as! PersonalDinnerCell
            cell.configureModel(chefModel)
        case 4:
            cell = tableView.dequeueReusableCellWithIdentifier(String(EnvironmentScrollCell)) as? EnvironmentScrollCell
            if cell == nil {
                cell = EnvironmentScrollCell(style: .Default, reuseIdentifier: String(EnvironmentScrollCell))
            }
            let cell = cell as! EnvironmentScrollCell
            cell.configureModel(chefModel)
        case 5:
            cell = tableView.dequeueReusableCellWithIdentifier(String(FeatureDinnerCell)) as? FeatureDinnerCell
            if cell == nil {
                cell = FeatureDinnerCell(style: .Default, reuseIdentifier: String(FeatureDinnerCell))
            }
            let cell = cell as! FeatureDinnerCell
            cell.configureModel(chefModel?.data?.menu)
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
            cell.configureModel(chefModel?.data?.comment)
        default:
            break
        }
        cell?.selectionStyle = .None
        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return tableView.fd_heightForCellWithIdentifier(String(ChefInfoIntroductionCell), cacheByIndexPath: indexPath, configuration: { (cell) in
                let cell = cell as! ChefInfoIntroductionCell
                cell.configureChefModel(self.chefModel)
            })
            
        case 1:
            return tableView.fd_heightForCellWithIdentifier(String(ChefInfoMarksCell), cacheByIndexPath: indexPath, configuration: { (cell) in
                let cell = cell as! ChefInfoMarksCell
                cell.configureModel(self.chefModel)
            })
            
        case 2:
            if chefModel?.data?.goods?.count > 0 {
                return tableView.fd_heightForCellWithIdentifier(String(PersonalDinnerCell), cacheByIndexPath: indexPath, configuration: { (cell) in
                    let cell = cell as! PersonalDinnerCell
                    cell.configureModel(self.chefModel)
                })
            }else {
                return 0
            }
        case 3:
            if chefModel?.data?.themeDinner?.count > 0 {
                return tableView.fd_heightForCellWithIdentifier(String(PersonalDinnerCell), cacheByIndexPath: indexPath, configuration: { (cell) in
                    let cell = cell as! PersonalDinnerCell
                    cell.configureModel(self.chefModel)
                })
            }else {
                return 0
            }
        case 4:
            return tableView.fd_heightForCellWithIdentifier(String(EnvironmentScrollCell), cacheByIndexPath: indexPath, configuration: { (cell) in
                let cell = cell as! EnvironmentScrollCell
                cell.configureModel(self.chefModel)
            })
        case 5:
            return tableView.fd_heightForCellWithIdentifier(String(FeatureDinnerCell), cacheByIndexPath: indexPath, configuration: { (cell) in
                let cell = cell as! FeatureDinnerCell
                cell.configureModel(self.chefModel?.data?.menu)
            })
        case 6:
            return tableView.fd_heightForCellWithIdentifier(String(AddressInfoCell), cacheByIndexPath: indexPath, configuration: { (cell) in
                let cell = cell as! AddressInfoCell
                cell.configureModel(self.chefModel?.data?.address?.address, mapUrl: self.chefModel?.data?.address?.mapImageUrl)
            })
        case 7:
            return tableView.fd_heightForCellWithIdentifier(String(HistoryDinnerCell), cacheByIndexPath: indexPath, configuration: { (cell) in
                let cell = cell as! HistoryDinnerCell
                cell.configureModel(self.chefModel)
            })
        case 8:
            return tableView.fd_heightForCellWithIdentifier(String(CommentCell), cacheByIndexPath: indexPath, configuration: { (cell) in
                let cell = cell as! CommentCell
                cell.configureModel(self.chefModel?.data?.comment)
            })
        default:
            return 0
        }

    }
}
