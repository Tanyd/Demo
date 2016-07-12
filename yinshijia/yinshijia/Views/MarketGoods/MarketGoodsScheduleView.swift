//
//  MarketGoodsScheduleView.swift
//  yinshijia
//
//  Created by tanyadong on 16/7/11.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class MarketGoodsScheduleView: UIView {

    private var didUpdateConstraints = false
    var model:MarketGoodsData?{
        didSet{
            tableviewH = 44 + 44 + (ceil(CGFloat((model?.items?.count)!) / CGFloat(3)) + 1 ) * 44
            tableView.reloadData()
        }
    }
    private var tableviewH: CGFloat = 0
    private var tableView: UITableView!
    private var backGroudView: UIView!
    var isShow = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        hidden = true
        setUI()
    }
    
    private func setUI(){
        backGroudView = UIView.newAutoLayoutView()
        backGroudView.backgroundColor = UIColor.blackColor()
        backGroudView.alpha = 0.0
        let tap = UITapGestureRecognizer(target: self, action: "backGroudViewClick:")
        backGroudView.addGestureRecognizer(tap)
        addSubview(backGroudView)
        
        tableView = UITableView(frame: CGRectZero, style: .Plain)
        tableView.scrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
        addSubview(tableView)
        setNeedsUpdateConstraints()
    }
    
    func backGroudViewClick(tap: UITapGestureRecognizer) {
        dismiss()
    }
    
    func show() {
        hidden = false
        isShow = true
        UIView.animateWithDuration(0.3) {
            self.backGroudView.alpha = 0.4
            self.tableView.transform = CGAffineTransformMakeTranslation(0, -self.tableviewH)
        }
    }
    
    func dismiss(){
        UIView.animateWithDuration(0.3, animations: { 
            self.backGroudView.alpha = 0.0
            self.tableView.transform = CGAffineTransformIdentity
            }) { (_) in
                self.hidden = true
                self.isShow = false
        }
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints{
            backGroudView.autoPinEdgesToSuperviewEdges()
            tableView.autoPinEdgeToSuperviewEdge(.Top, withInset: ScreenSize.SCREEN_HEIGHT - 90.0.fitHeight())
            tableView.autoPinEdgeToSuperviewEdge(.Left)
            tableView.autoPinEdgeToSuperviewEdge(.Right)
            tableView.autoSetDimension(.Height, toSize: tableviewH)
            didUpdateConstraints = true
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MarketGoodsScheduleView: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier(String(ScheduleTitleCell)) as? ScheduleTitleCell
            if cell == nil {
                cell = ScheduleTitleCell(style: .Default, reuseIdentifier: String(ScheduleTitleCell))
            }
            let cell = cell as! ScheduleTitleCell
            cell.title = model?.title
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier(String(ScheduleTypeCell)) as? ScheduleTypeCell
            if cell == nil {
                cell = ScheduleTypeCell(style: .Default, reuseIdentifier: String(ScheduleTypeCell))
            }
            let cell = cell as! ScheduleTypeCell
            cell.items = model?.items
        default:
            cell = tableView.dequeueReusableCellWithIdentifier(String(ScheduleNumberCell)) as? ScheduleNumberCell
            if cell == nil {
                cell = ScheduleNumberCell(style: .Default, reuseIdentifier: String(ScheduleNumberCell))
            }
        }
        cell?.selectionStyle = .None
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.item {
        case 0:
            return 44
        case 1:
            return  (ceil(CGFloat((model?.items?.count)!) / CGFloat(3)) + 1) * 44
        default:
            return 44
        }
    }
}
