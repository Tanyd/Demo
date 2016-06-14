//
//  SelectionViewController.swift
//  yinshijia
//
//  Created by Developer on 16/6/10.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class ChoiceViewController: TranslationTableViewController {

    private var headerView: HeaderView!
    private var choicePage = 0
    private let choiceMaxPage = 5
    private var arrayIndex = [NSIndexPath]()

    var choiceModel: Choice?{
        didSet{
            headerView.categorys = (choiceModel?.data?.catalog)!
            headerView.banners = (choiceModel?.data?.banner)!
            tableView.reloadData()
        }
    }
    
    var dinnerLists = [Dinnerlist](){
        didSet{
            choiceModel!.data!.dinnerList! = (choiceModel!.data!.dinnerList!) + dinnerLists
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        tableView.mj_header.beginRefreshing()
    }

    private func setUI() {
        tableView.registerClass(ChoiceCell.self, forCellReuseIdentifier: String(ChoiceCell))
        headerView = HeaderView(frame: CGRectMake(0, 0, 0, 540.0.fitHeight()))
        tableView.tableHeaderView = headerView
    }
    
    override func tableRefreshHeader() {
        tableView.mj_footer.resetNoMoreData()
        let callBack: BaseApiCallBack = {[weak self](result, error) in
            guard error == nil else {
                self!.tableView.mj_header.endRefreshing()
                return
            }
            let model = result as! Choice
            self!.choiceModel = model
            self!.tableView.mj_header.endRefreshing()
        }
        Choice.loadChoiceBaseData(callBack)
    }
    
    override func tableRefreshFooter() {
        ++choicePage
        
        if choicePage > choiceMaxPage || choiceModel == nil{
            tableView.mj_footer.endRefreshingWithNoMoreData()
            return
        }
        let callBack: BaseApiCallBack = {[weak self] (result, error) in
            guard error == nil else {
                self!.tableView.mj_footer.endRefreshing()
                --self!.choicePage
                return
            }
            let model = result as! [Dinnerlist]
            self!.dinnerLists = model
            self!.tableView.mj_footer.endRefreshing()
        }
        Choice.loadChoiceMoreData(callBack, page: choicePage)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choiceModel?.data?.dinnerList?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = ChoiceCell.choiceCellWithTableView(tableView)
        let model = choiceModel?.data?.dinnerList?[indexPath.row]
        cell.model = model
 
        if (tableView.dragging || tableView.decelerating) && !(arrayIndex.contains(indexPath)){
            
            cell.goodsImg.sd_setImageWithURL(nil, placeholderImage: UIImage(named: "wutu"))
            cell.userIcon.sd_setImageWithURL(nil, placeholderImage: UIImage(named: "headerview"))
            
        }else {
            let goodsImgArray = model!.themeDinnerImageurl!.componentsSeparatedByString(",")
            cell.goodsImg.sd_setImageWithURL(NSURL(string: goodsImgArray[0]), placeholderImage: UIImage(named: "wutu"), completed: { (img, error, _, url) in
                
                if !self.arrayIndex.contains(indexPath) {
                    self.arrayIndex.append(indexPath)
                }
            })
            cell.userIcon.sd_setImageWithURL(NSURL(string: model!.themeDinnerChefImageurl!), placeholderImage: UIImage(named: "headerview"))
            }
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableView.fd_heightForCellWithIdentifier(String(ChoiceCell), cacheByIndexPath: indexPath, configuration: nil)
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
