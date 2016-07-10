//
//  DiscoverViewController.swift
//  yinshijia
//
//  Created by Developer on 16/6/10.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class DiscoverViewController: BaseViewController {

    private var tableView: UITableView!
    private var menuHeader: MenuHeaderView!
    private var dicoverModel: Discover?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchBar()
        setUI()
        setupRefresh()
        tableView.mj_header.beginRefreshing()
    }
    
    private func setUI() {
        automaticallyAdjustsScrollViewInsets = false
        tableView = UITableView(frame: view.bounds, style: .Grouped)
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0)
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.colorFromHex(0xeaeaea)
        tableView.delegate = self
        tableView.dataSource = self
        menuHeader = MenuHeaderView(frame: CGRectZero)
        tableView.hidden = true
        view.addSubview(tableView)
    }
    
    private func setSearchBar() {
        let btn = UIButton(type: .Custom)
        btn.frame = CGRectMake(0, 0, 690.0.fitWidth(), 30)
        btn.layer.cornerRadius = 5.0
        btn.setImage(UIImage(named: "search_sign_gray"), forState: .Normal)
        btn.setTitle("发现更多精致私房美食", forState: .Normal)
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0)
        btn.titleLabel?.font = UIFont.systemFontOfSize(11)
        btn.setTitleColor(UIColor.grayColor(), forState: .Normal)
        btn.backgroundColor = UIColor.colorFromHex(0xf4f4f4)
        btn.contentHorizontalAlignment = .Center
        navigationItem.titleView = btn
    }
    
    private func setupRefresh() {
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: "tableRefreshHeader")
        tableView.mj_header = header
    }
  
    func tableRefreshHeader() {
        let callBack: BaseApiCallBack = {[weak self](result, error) in
            guard error == nil else {
                return
            }
            let model = result as? Discover
            if self!.dicoverModel != nil {
                self!.dicoverModel = nil
            }
            self!.dicoverModel = model
            self!.menuHeader.frame = CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: 50.0.fitHeight() + 164.0.fitHeight() * ceil((CGFloat((model?.data?.catalogs!.count)!) / 4.0)))
            self!.menuHeader.menus = (model?.data?.catalogs)!
            self!.tableView.tableHeaderView = self!.menuHeader
            self!.tableView.reloadData()
            self!.tableView.mj_header.endRefreshing()
            self!.tableView.hidden = false
            SVProgressHUD.dismiss()
        }
        Discover.loadDicoverBaseData(callBack)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DiscoverViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dicoverModel?.data?.chefs?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(String(DiscoverChefCell)) as? DiscoverChefCell
        if cell == nil {
            cell = DiscoverChefCell(style: .Default, reuseIdentifier: String(DiscoverChefCell))
        }
        cell?.chefModel = dicoverModel?.data?.chefs![indexPath.row]
        return cell!
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(String(ChefInfoSectionHeaderView)) as? ChefInfoSectionHeaderView
        if header == nil {
            header = ChefInfoSectionHeaderView(reuseIdentifier: String(ChefInfoSectionHeaderView))
        }
        header?.title = "特别推荐"
        header?.contentView.backgroundColor = UIColor.colorFromHex(0xeaeaea)
        return header
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        print(tableView.cellForRowAtIndexPath(indexPath)!.tag)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 85.0.fitHeight()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 205.0.fitHeight()
    }
    
    
}
