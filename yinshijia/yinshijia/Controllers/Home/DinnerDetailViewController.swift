//
//  DinnerDetailViewController.swift
//  yinshijia
//
//  Created by tanyadong on 16/6/18.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class DinnerDetailViewController: BaseViewController {

    private var dinnerTable: UITableView!
    private var banner: BannerView?
    private var model: ChefDinner?
    private var back: UIButton!
    private var collect: UIButton!
    private var share: UIButton!
    
    var chefDinnerID: Int?{
        didSet{
            loadBaseDate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNaviagtionBarAppearance()
        setUI()
    }
    
    private func loadBaseDate() {
        let callBack: BaseApiCallBack = {[weak self](result, error) in
            guard error == nil else {
                return
            }
            self!.model = result as? ChefDinner
            self!.banner?.imgs = (self!.model?.data?.baseInfo?.theme_images?.componentsSeparatedByString(","))!
            self!.title = (result as? ChefDinner)?.data?.baseInfo?.title
            self!.dinnerTable.reloadData()
        }
        ChefDinner.loadDetailDinner(callBack, id: chefDinnerID!)
    }
    
    private func setNaviagtionBarAppearance() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        collect = UIButton(type: .Custom)
        collect.frame = CGRect(x: 10, y: 0, width: 30, height: 30)
        collect.setImage(UIImage(named: "rejuSave"), forState: .Normal)
        share = UIButton(type: .Custom)
        share.frame = CGRect(x: 10 + 30, y: 0, width: 30, height: 30)
        share.setImage(UIImage(named: "rejuShare"), forState: .Normal)
        back = UIButton(type: .Custom)
        back.frame = CGRect(x: 10, y: 0, width: 30, height: 30)
        back.setImage(UIImage(named: "rejuBack"), forState: .Normal)
        back.addTarget(self, action: "backItemClick", forControlEvents: .TouchUpInside)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.clearColor()]
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: share),UIBarButtonItem(customView: collect)]
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: back)
    }
    
    private func setUI() {
        automaticallyAdjustsScrollViewInsets = false
        dinnerTable = DinnerDetailTableView(frame: CGRectMake(0, 0, ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT), style: .Plain)
        banner = BannerView(frame: CGRectMake(0, 0, ScreenSize.SCREEN_WIDTH, 600.0.fitHeight()), focusImageViewClick: { (index) in
            
        })
        dinnerTable.registerClass(DinnerDetailIntroductionCell.self, forCellReuseIdentifier: String(DinnerDetailIntroductionCell))
        dinnerTable.registerClass(ChefInfoCell.self, forCellReuseIdentifier: String(ChefInfoCell))
        dinnerTable.registerClass(FeatureDinnerCell.self, forCellReuseIdentifier: String(FeatureDinnerCell))
        dinnerTable.registerClass(MoreInfoCell.self, forCellReuseIdentifier: String(MoreInfoCell))
        dinnerTable.registerClass(AddressInfoCell.self, forCellReuseIdentifier: String(AddressInfoCell))
        dinnerTable.registerClass(OrderDescriptionCell.self, forCellReuseIdentifier: String(OrderDescriptionCell))
        dinnerTable.registerClass(CommentCell.self, forCellReuseIdentifier: String(CommentCell))
        dinnerTable.tableHeaderView = banner
        dinnerTable.delegate = self
        dinnerTable.dataSource = self
        dinnerTable.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 90.0.fitHeight(), right: 0)
        view.addSubview(dinnerTable)
        
        let madeButton = CustomMadeView(frame: CGRectMake(0, ScreenSize.SCREEN_HEIGHT - 90.0.fitHeight(), ScreenSize.SCREEN_WIDTH, 90.0.fitHeight())) { 
            
        }
        view.addSubview(madeButton)
    }

    func backItemClick() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        var alpha = contentOffsetY / ScreenSize.SCREEN_HEIGHT
        if alpha > 1 {
            alpha = 0.99
        }
        
        if alpha > 0.7 {
            share.setImage(UIImage(named: "rejuShareD"), forState: .Normal)
            collect.setImage(UIImage(named: "rejuSaveD"), forState: .Normal)
            back.setImage(UIImage(named: "rejuBackD"), forState: .Normal)
            navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.blackColor()]
        }else {
            share.setImage(UIImage(named: "rejuShare"), forState: .Normal)
            collect.setImage(UIImage(named: "rejuSave"), forState: .Normal)
            back.setImage(UIImage(named: "rejuBack"), forState: .Normal)
            navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.clearColor()]
        }
        
        navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(UIColor(white: 1.0, alpha: alpha)), forBarMetrics: UIBarMetrics.Default)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 
}

extension DinnerDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (model == nil ? 0 : 7)
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
        case 3:
            cell = tableView.dequeueReusableCellWithIdentifier(String(MoreInfoCell)) as? MoreInfoCell
            if cell == nil {
                cell = MoreInfoCell(style: .Default, reuseIdentifier: String(MoreInfoCell))
            }
            let cell = cell as! MoreInfoCell
            cell.delegate = self
            cell.configureModel(model)
        case 4:
            cell = tableView.dequeueReusableCellWithIdentifier(String(AddressInfoCell)) as? AddressInfoCell
            if cell == nil {
                cell = AddressInfoCell(style: .Default, reuseIdentifier: String(AddressInfoCell))
            }
            let cell = cell as! AddressInfoCell
            cell.configureModel(model)
        case 5:
            cell = tableView.dequeueReusableCellWithIdentifier(String(OrderDescriptionCell)) as? OrderDescriptionCell
            if cell == nil {
                cell = OrderDescriptionCell(style: .Default, reuseIdentifier: String(OrderDescriptionCell))
            }
            let cell = cell as! OrderDescriptionCell
            cell.configureModel(model)
        case 6:
            cell = tableView.dequeueReusableCellWithIdentifier(String(CommentCell)) as? CommentCell
            if cell == nil {
                cell = CommentCell(style: .Default, reuseIdentifier: String(CommentCell))
            }
            let cell = cell as! CommentCell
            cell.configureModel(model)
        default:
            break
        }
        cell?.selectionStyle = .None
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
        case 3:
            return tableView.fd_heightForCellWithIdentifier(String(MoreInfoCell), cacheByIndexPath: indexPath, configuration: { (cell) in
                let cell = cell as! MoreInfoCell
                cell.configureModel(self.model)
            })
        case 4:
            return tableView.fd_heightForCellWithIdentifier(String(AddressInfoCell), cacheByIndexPath: indexPath, configuration: { (cell) in
                let cell = cell as! AddressInfoCell
                cell.configureModel(self.model)
            })
        case 5:
            return tableView.fd_heightForCellWithIdentifier(String(OrderDescriptionCell), cacheByIndexPath: indexPath, configuration: { (cell) in
                let cell = cell as! OrderDescriptionCell
                cell.configureModel(self.model)
            })
        case 6:
            return tableView.fd_heightForCellWithIdentifier(String(CommentCell), cacheByIndexPath: indexPath, configuration: { (cell) in
                let cell = cell as! CommentCell
                cell.configureModel(self.model)
            })
        default:
            return 0
        }
        
    }
}

extension DinnerDetailViewController: MoreInfoCellDelegate {
    func moreInfoCellDidChangeView(height: CGFloat) {
        dinnerTable.reloadData()
        dinnerTable.fd_indexPathHeightCache.cacheHeight(height, byIndexPath: NSIndexPath(forRow: 3, inSection: 0))

    }

}
