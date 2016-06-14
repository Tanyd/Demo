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
    var choiceListModel: ChoiceList?{
        didSet{
            tableView.reloadData()
        }
    }
    
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
            let model = result as! ChoiceList
            self!.choiceListModel = model
            self!.tableView.mj_header.endRefreshing()
        }
        ChoiceList.loadChoiceListBaseData(callBack,id: bannerId!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return choiceListModel?.data?.item?.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = String(ChoiceListCell)
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? ChoiceListCell
        if cell == nil {
            cell = ChoiceListCell(style: .Default, reuseIdentifier: identifier)
        }
        let model = choiceListModel?.data?.item?[indexPath.row]
        cell!.choiceListModel = model
        
        if (tableView.dragging || tableView.decelerating) && !(arrayIndex.contains(indexPath)){
            
            cell!.goodsImg.sd_setImageWithURL(nil, placeholderImage: UIImage(named: "wutu"))
            
        }else {
            let goodsImgArray = model!.dinner_imageurl!.componentsSeparatedByString(",")
            cell!.goodsImg.sd_setImageWithURL(NSURL(string: goodsImgArray[0]), placeholderImage: UIImage(named: "wutu"), completed: { (img, error, _, url) in
                
                if !self.arrayIndex.contains(indexPath) {
                    self.arrayIndex.append(indexPath)
                }
            })
        }
        
        cell!.dinnerChefClick = { (chefID) in
            DebugPrint("点击了chef id\(chefID)")
        }

        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        return tableView.fd_heightForCellWithIdentifier(String(ChoiceListCell), cacheByIndexPath: indexPath, configuration: nil)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ChoiceListCell
        DebugPrint("点击了dinner \(cell.tag)")
    }
    
    override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            downloadImg()
        }
    }
    
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        downloadImg()
    }
    
    private func  downloadImg() {
        let visibleRows = tableView.indexPathsForVisibleRows
        var newRows = [NSIndexPath]()
        for path in visibleRows! {
            if !self.arrayIndex.contains(path) {
                newRows.append(path)
            }
        }
        tableView.reloadRowsAtIndexPaths(newRows, withRowAnimation: .Fade)
    }

}
