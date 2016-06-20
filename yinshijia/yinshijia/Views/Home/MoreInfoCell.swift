//
//  MoreInfoCell.swift
//  yinshijia
//
//  Created by tanyadong on 16/6/19.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class MoreInfoCell: UITableViewCell {
    
    private var didUpdateConstraints = false
    var plainMenus = [Plainmenu]() {
        didSet{
            menuTable.reloadData()
        }
    }
    var amenities = [Amenities]() {
        didSet{
            
        }
    }
    var address: String? {
        didSet{
            
        }
    }
    private lazy var buttonPage: BtnPageView = {
        let page = BtnPageView(frame:  CGRectZero, buttonTitles: ["菜单","环境","信息"])
        page.delegate = self
        return page
    }()
    
    private lazy var menuTable: MenuTable = {
        let menu = MenuTable(frame: CGRectZero, style: .Plain)
        menu.tag = 0
        menu.registerClass(MenuCell.self, forCellReuseIdentifier: String(MenuCell))
        menu.dataSource = self
        menu.delegate = self
        return menu
    }()
    
    private lazy var environmentView: EnvironmentInfoView = {
        let view = EnvironmentInfoView(frame: CGRectZero)
        view.tag = 1
        return view
    }()
    
    private lazy var addressView: AddressInfoView = {
        let view = AddressInfoView(frame: CGRectZero)
        view.tag = 2
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    private func setUI() {
        contentView.addSubview(buttonPage)
        contentView.addSubview(menuTable)
//        contentView.addSubview(environmentView)
//        environmentView.hidden = true
//        contentView.addSubview(addressView)
//        addressView.hidden = true
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints {
            
            buttonPage.autoPinEdgeToSuperviewEdge(.Left, withInset: 30.0.fitWidth())
            buttonPage.autoPinEdgeToSuperviewEdge(.Right, withInset: 30.0.fitWidth())
            buttonPage.autoPinEdgeToSuperviewEdge(.Top)
            buttonPage.autoSetDimension(.Height, toSize: 100.0.fitHeight())
            
            menuTable.autoPinEdge(.Top, toEdge: .Bottom, ofView: buttonPage, withOffset: 30.0.fitHeight())
            menuTable.autoPinEdge(.Left, toEdge: .Left, ofView: buttonPage)
            menuTable.autoPinEdge(.Right, toEdge: .Right, ofView: buttonPage)
            menuTable.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 30.0.fitHeight())
            
//            environmentView.autoPinEdge(.Top, toEdge: .Bottom, ofView: buttonPage, withOffset: 30.0.fitHeight())
//            environmentView.autoPinEdge(.Left, toEdge: .Left, ofView: buttonPage)
//            environmentView.autoPinEdge(.Right, toEdge: .Right, ofView: buttonPage)
//            environmentView.autoSetDimension(.Height, toSize: 1000.0.fitHeight())
//            environmentView.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 30.0.fitHeight())
//            
//            addressView.autoPinEdge(.Top, toEdge: .Bottom, ofView: buttonPage, withOffset: 30.0.fitHeight())
//            addressView.autoPinEdge(.Left, toEdge: .Left, ofView: buttonPage)
//            addressView.autoPinEdge(.Right, toEdge: .Right, ofView: buttonPage)
//            addressView.autoSetDimension(.Height, toSize: 550.0.fitHeight())
//            addressView.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 30.0.fitHeight())

            didUpdateConstraints = true
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension MoreInfoCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plainMenus.count ?? 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(String(MenuCell)) as? MenuCell
        if cell == nil {
            cell = MenuCell(style: .Default, reuseIdentifier: String(MenuCell))
        }
        cell?.model = plainMenus[indexPath.row]
        return cell!
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableView.fd_heightForCellWithIdentifier(String(MenuCell), cacheByIndexPath: indexPath, configuration: { (cell) in
            (cell as! MenuCell).model = self.plainMenus[indexPath.row]
        })
    }
}

extension MoreInfoCell: BtnPageViewDelegate {
    func btnPageViewDidTouchButton(fromIndex: Int, toIndex: Int) {
        let fromView = contentView.viewWithTag(fromIndex)
        fromView?.hidden = true
        let toView = contentView.viewWithTag(toIndex)
        toView?.hidden = false
    }
}
