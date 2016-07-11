//
//  CustomeCommentTableView.swift
//  yinshijia
//
//  Created by tanyadong on 16/7/3.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class CustomeCommentTableView: UITableView {

    private var titleView: UILabel!
    private var footerClick: (()->())!
    
    var commentModels = [Comment](){
        didSet{
            titleView.text = "食客评价(\(commentModels.count))"
            if commentModels.count > 2 {
                tableFooterView = footerView
                cellCount = 2
            }else{
                cellCount = commentModels.count
            }
        }
    }
    
    private var cellCount: Int? {
        didSet{
            reloadData()
        }
    }
    
    private lazy var footerView: UIView = {
        let footer = UIView(frame: CGRectMake(0, 0, 0, 145.0.fitHeight()))
        let btn = buttonNoHighlighted(type: .Custom)
        btn.titleLabel?.font = UIFont.systemFontOfSize(12)
        btn.setTitle("查看更多评价", forState: .Normal)
        btn.setTitleColor(Constant.Common.OrangeColor, forState: .Normal)
        btn.backgroundColor = UIColor.RGB(247, Green: 247, Blue: 247, Alpha: 1.0)
        btn.center = CGPointMake(ScreenSize.SCREEN_WIDTH * 0.5, 145.0.fitHeight() * 0.5)
        btn.bounds.size = CGSizeMake(245.0.fitWidth(), 65.0.fitHeight())
        btn.layer.cornerRadius = 30.0.fitWidth()
        btn.addTarget(self, action: "footerDidClick", forControlEvents: .TouchUpInside)
        footer.addSubview(btn)
        return footer
    }()
    
    convenience init(frame: CGRect, style: UITableViewStyle, loadMoreComments: ()->()) {
        self.init(frame: frame, style: style)
        separatorStyle = .None
        self.footerClick = loadMoreComments
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        setUI()
    }
    
    private func setUI() {
        delegate = self
        scrollEnabled = false
        dataSource = self
        estimatedRowHeight = 70
        rowHeight = UITableViewAutomaticDimension
        titleView = UILabel.labelCustomer("食客评价(0)", fontType: nil, color: UIColor.blackColor(), fontSize: 15)
        titleView.textAlignment = .Center
        titleView.frame = CGRectMake(0, 0, 0, 145.0.fitHeight())
        tableHeaderView = titleView
    }
    
    func footerDidClick() {
        footerClick()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomeCommentTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(String(CustomeCommentCell)) as? CustomeCommentCell
        if cell == nil {
            cell = CustomeCommentCell(style: .Default, reuseIdentifier: String(CustomeCommentCell))
        }
        cell?.selectionStyle = .None
        cell?.commentModel = commentModels[indexPath.row]
        return cell!
    }
}