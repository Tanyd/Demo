//
//  ChefListTableViewController.swift
//  yinshijia
//
//  Created by Developer on 16/6/14.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class ChoiceListTableViewController: UITableViewController {

    private var arrayIndex = [NSIndexPath]()
    var bannerId: Int?{
        didSet{
            tableView.mj_header.beginRefreshing()
        }
    }
    
    var categoryId: Int?{
        didSet{
            tableView.mj_header.beginRefreshing()
        }
    }
    
    private var choiceListModel: ChoiceList?{
        didSet{
            navigationItem.title = choiceListModel?.data?.campaign?.title
            if choiceListModel?.data?.campaign?.desp != "" {
                if choiceListModel?.data?.campaign?.desp != nil {
                    let despH = ((choiceListModel?.data?.campaign?.desp!)! as NSString).getTextRectSize(UIFont.systemFontOfSize(13), size: CGSize(width: ScreenSize.SCREEN_WIDTH * 0.7, height: CGFloat.max)).height
                    headerLable.text = choiceListModel?.data?.campaign?.desp
                    headerLable.frame = CGRectMake(0, 0, ScreenSize.SCREEN_WIDTH, despH + 5)
                }else{
                    headerLable.frame = CGRectZero
                }
                tableView.tableHeaderView = headerLable
            }
            
            tableView.reloadData()
        }
    }
    
    private var categoryListModel: CategoryList?{
        didSet{
            tableView.reloadData()
        }
    }
    
    
    private lazy var headerLable: UILabel = {
       let lable = UILabel.labelCustomer(nil, fontType: nil, color: UIColor.grayColor(), fontSize: 13)
        lable.numberOfLines = 0
        lable.textAlignment = .Center
        return lable
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    private func setUI() {
        tableView.registerClass(ChoiceListCell.self, forCellReuseIdentifier: String(ChoiceListCell))
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: "tableRefreshHeader")
        tableView.mj_header = header
        tableView.tableFooterView = UIView()
    }
    
    func tableRefreshHeader() {
        let callBack: BaseApiCallBack = {[weak self](result, error) in
            guard error == nil else {
                self!.tableView.mj_header.endRefreshing()
                return
            }
            
            if self!.bannerId != nil {
                self!.choiceListModel = nil
                let model = result as! ChoiceList
                self!.choiceListModel = model
            }else if self!.categoryId != nil {
                self!.categoryListModel = nil
                let model = result as! CategoryList
                self!.categoryListModel = model
            }
            
            self!.tableView.mj_header.endRefreshing()
        }
        
        if bannerId != nil {
            ChoiceList.loadChoiceListBaseData(callBack,id: bannerId!)
        }else if categoryId != nil {
            CategoryList.loadCategoryListBaseData(callBack, id: categoryId!)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if bannerId != nil {
            return choiceListModel?.data?.item?.count ?? 0
        }else if categoryId != nil {
            return categoryListModel?.data?.count ?? 0
        }else {
            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = String(ChoiceListCell)
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? ChoiceListCell
        if cell == nil {
            cell = ChoiceListCell(style: .Default, reuseIdentifier: identifier)
        }
        
        var model: NSObject?
        if bannerId != nil {
            model = choiceListModel?.data?.item?[indexPath.row]
            cell!.choiceListModel = model as? Item
        }else if categoryId != nil {
            model = categoryListModel?.data?[indexPath.row]
            cell!.categoryListModel = model as? CategoryListData
        }
        
        cell!.dinnerChefClick = { (chefID) in
            DebugPrint("点击了chef id\(chefID)")
        }

        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableView.fd_heightForCellWithIdentifier(String(ChoiceListCell), cacheByIndexPath: indexPath) { (cell) in
            let cell = cell as! ChoiceListCell
            if self.bannerId != nil {
                let model = self.choiceListModel?.data?.item?[indexPath.row]
                cell.choiceListModel = model
            }else if self.categoryId != nil {
                let model = self.categoryListModel?.data?[indexPath.row]
                cell.categoryListModel = model
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ChoiceListCell
        DebugPrint("点击了dinner \(cell.tag)")
    }

}
