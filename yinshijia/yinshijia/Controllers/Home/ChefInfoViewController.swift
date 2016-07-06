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
    }
}
