//
//  MarketGoodsInfoViewController.swift
//  yinshijia
//
//  Created by Developer on 16/7/8.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class MarketGoodsInfoViewController: NavigationBarAnimationViewController {

    private var didUpdateConstraints = false
    private var bannerView: BannerView!
    private var tableView: UITableView!
    private var bannerViewHConstraint: NSLayoutConstraint?
    private let bannerViewH = 720.0.fitHeight()
    private var goodsModel: MarketGoods?
    private var scheduleButton: UIButton!

    private lazy var scheduleView: MarketGoodsScheduleView = {
        let view = MarketGoodsScheduleView(frame: self.view.bounds)
        view.model = self.goodsModel!.data
        self.view.insertSubview(view, belowSubview: self.scheduleButton)
        return view
    }()
    
    private lazy var testView: PopView = {
        let tt = UIView()
        tt.backgroundColor = UIColor.redColor()
        let t = PopView(view: tt, contenH: 300, bottomMargin: 90.0.fitHeight())
        self.view.insertSubview(t, belowSubview: self.scheduleButton)
        return t
    }()
    
    var goodsID: Int = 0 {
        didSet{
            loadBaseDate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.showWithStatus("加载中", maskType: .Clear, style: .Light)
        setUI()
        // Do any additional setup after loading the view.
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
//        if scheduleView.isShow {
//            if scheduleView.isShow {
//                scheduleView.dismiss()
//            }
//        }
    }
    
    private func loadBaseDate() {
        let callBack: BaseApiCallBack = {[weak self](result, error) in
            guard error == nil else {
                SVProgressHUD.dismiss()
                return
            }
            let model = result as? MarketGoods
            self!.goodsModel = model
            self!.bannerView.imgs = ((model?.data?.head_image)! as NSString).componentsSeparatedByString(",")
            self!.navigationItem.title = model?.data?.title
            self!.tableView.reloadData()
            self!.tableView.hidden = false
            self!.bannerView.hidden = false
            SVProgressHUD.dismiss()
        }
        MarketGoods.loadMarketGoodsDetail(callBack, id: goodsID)
    }
    
    private func setUI() {
        automaticallyAdjustsScrollViewInsets = false
        titleColorNormal = UIColor.clearColor()
        titleColorSelected = UIColor.blackColor()
        
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.sectionHeaderHeight = 0.0
        tableView.sectionFooterHeight = 20.0
        tableView.contentOffset.y = CGFloat(-bannerViewH)
        tableView.contentInset = UIEdgeInsets(top: bannerViewH, left: 0, bottom: 0, right: 0 )
        tableView.registerClass(GoodsIntroductionCell.self, forCellReuseIdentifier: String(GoodsIntroductionCell))
        tableView.registerClass(SelectedTypeCell.self, forCellReuseIdentifier: String(SelectedTypeCell))
        tableView.registerClass(ChefInfoCell.self, forCellReuseIdentifier: String(ChefInfoCell))
        tableView.registerClass(GoodsDetailCell.self, forCellReuseIdentifier: String(GoodsDetailCell))
        tableView.registerClass(ScheduleInfoCell.self, forCellReuseIdentifier: String(ScheduleInfoCell))
        tableView.registerClass(CommentCell.self, forCellReuseIdentifier: String(CommentCell))
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        
        bannerView = BannerView(frame: CGRectZero, focusImageViewClick: { (index) in
            
        })
        bannerView.contentMode = .ScaleAspectFill
        bannerView.clipsToBounds = true
        view.addSubview(bannerView)
        
        scheduleButton = UIButton(type: .Custom)
        scheduleButton.setTitle("订购预约", forState: .Normal)
        scheduleButton.backgroundColor = Constant.Common.OrangeColor
        scheduleButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        scheduleButton.titleLabel?.font = UIFont.systemFontOfSize(13)
        scheduleButton.addTarget(self, action: "showScheduleView:", forControlEvents: .TouchUpInside)
        view.addSubview(scheduleButton)
        view.setNeedsUpdateConstraints()
    }
    

    func showScheduleView(sender: UIButton) {
//        testView.show()
        if !scheduleView.isShow {
            scheduleView.show()
        }else{
            print("订购");
        }
    }
    
    
    override func updateViewConstraints() {
        if !didUpdateConstraints {
            bannerView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero, excludingEdge: .Bottom)
            bannerViewHConstraint = bannerView.autoSetDimension(.Height, toSize: CGFloat(bannerViewH))
            tableView.autoPinEdgesToSuperviewEdges()
            scheduleButton.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero, excludingEdge: .Top)
            scheduleButton.autoSetDimension(.Height, toSize: 90.0.fitHeight())
            didUpdateConstraints = true
        }
        super.updateViewConstraints()
    }
    
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        let marginY = contentOffsetY - (-CGFloat(bannerViewH))
        
        var height = CGFloat(bannerViewH) - marginY
        
        if height < CGFloat(64) {
            height = CGFloat(64)
        }
        
        var alpha = contentOffsetY / bannerViewH + 1
       
        if alpha > 1 {
            alpha = 0.99
        }
       
        if alpha > 0.7 {
            backItem.selected = true
            navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: titleColorSelected!,NSFontAttributeName: UIFont(name: Constant.Common.DefaultFont, size: 14)!]
        }else {
            backItem.selected = false
            navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: titleColorNormal!,NSFontAttributeName: UIFont(name: Constant.Common.DefaultFont, size: 14)!]
        }
        
        navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(UIColor(white: 1.0, alpha: alpha)), forBarMetrics: UIBarMetrics.Default)
        bannerViewHConstraint?.constant = height
        view.layoutIfNeeded()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MarketGoodsInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return goodsModel == nil ? 0 : 6
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goodsModel == nil ? 0 : 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier(String(GoodsIntroductionCell)) as? GoodsIntroductionCell
            if cell == nil {
                cell = GoodsIntroductionCell(style: .Default, reuseIdentifier: String(GoodsIntroductionCell))
            }
            let cell = cell as! GoodsIntroductionCell
            cell.model = goodsModel
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier(String(SelectedTypeCell)) as? SelectedTypeCell
            if cell == nil {
                cell = SelectedTypeCell(style: .Default, reuseIdentifier: String(SelectedTypeCell))
            }
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier(String(ChefInfoCell)) as? ChefInfoCell
            if cell == nil {
                cell = ChefInfoCell(style: .Default, reuseIdentifier: String(ChefInfoCell))
            }
            let cell = cell as! ChefInfoCell
            cell.type = .ChefGodds
            cell.configureGoodsModel(goodsModel)
        case 3:
            cell = tableView.dequeueReusableCellWithIdentifier(String(GoodsDetailCell)) as? GoodsDetailCell
            if cell == nil {
                cell = GoodsDetailCell(style: .Default, reuseIdentifier: String(GoodsDetailCell))
            }
            let cell = cell as! GoodsDetailCell
            cell.configureModel((goodsModel?.data?.properties)!, propertiesImg: goodsModel?.data?.properties_image)
        case 4:
            cell = tableView.dequeueReusableCellWithIdentifier(String(ScheduleInfoCell)) as? ScheduleInfoCell
            if cell == nil {
                cell = ScheduleInfoCell(style: .Default, reuseIdentifier: String(ScheduleInfoCell))
            }
            let cell = cell as! ScheduleInfoCell
            cell.model = goodsModel?.data?.book_info
        case 5:
            cell = tableView.dequeueReusableCellWithIdentifier(String(CommentCell)) as? CommentCell
            if cell == nil {
                cell = CommentCell(style: .Default, reuseIdentifier: String(CommentCell))
            }
            let cell = cell as! CommentCell
            cell.configureModel(goodsModel?.data?.comments)
        default:
            break
        }
        cell?.selectionStyle = .None
        return cell!
    }
    
     func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return tableView.fd_heightForCellWithIdentifier(String(GoodsIntroductionCell), cacheByIndexPath: indexPath, configuration: { (cell) in
                let cell = cell as! GoodsIntroductionCell
                cell.model = self.goodsModel
            })
            
        case 1:
            return tableView.fd_heightForCellWithIdentifier(String(SelectedTypeCell), cacheByIndexPath: indexPath, configuration: { (cell) in
            })
            
        case 2:
            return tableView.fd_heightForCellWithIdentifier(String(ChefInfoCell), cacheByIndexPath: indexPath, configuration: { (cell) in
                let cell = cell as! ChefInfoCell
                cell.type = .ChefGodds
                cell.configureGoodsModel(self.goodsModel)
            })
        case 3:
            return tableView.fd_heightForCellWithIdentifier(String(GoodsDetailCell), cacheByIndexPath: indexPath, configuration: { (cell) in
                let cell = cell as! GoodsDetailCell
                cell.configureModel((self.goodsModel?.data?.properties)!, propertiesImg: self.goodsModel?.data?.properties_image)
            })
        case 4:
            return tableView.fd_heightForCellWithIdentifier(String(ScheduleInfoCell), cacheByIndexPath: indexPath, configuration: { (cell) in
                let cell = cell as! ScheduleInfoCell
                cell.model = self.goodsModel?.data?.book_info
            })
        case 5:
            return tableView.fd_heightForCellWithIdentifier(String(CommentCell), cacheByIndexPath: indexPath, configuration: { (cell) in
                let cell = cell as! CommentCell
                cell.configureModel(self.goodsModel?.data?.comments)
            })
        default:
            return 0
        }
        
    }
  
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
}
