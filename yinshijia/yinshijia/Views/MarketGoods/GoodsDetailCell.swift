//
//  GoodsDetailCell.swift
//  yinshijia
//
//  Created by tanyadong on 16/7/9.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class GoodsDetailCell: UITableViewCell {
    
    private var didUpdateConstraints = false
    private var goodsH: CGFloat = 0
    var models = [Properties]()
    
    private lazy var goodsDetailTableView: UITableView = {
        let table = UITableView(frame: CGRectZero, style: .Plain)
        table.delegate = self
        table.dataSource = self
        table.scrollEnabled = false
        table.estimatedRowHeight = 44
        table.separatorStyle = .None
        table.rowHeight = UITableViewAutomaticDimension
        return table
    }()
    
    private lazy var titleHeader: UILabel = {
        let label = UILabel.labelCustomer("商品详情", fontType: Constant.Common.BoldFont, color: UIColor.blackColor(), fontSize: 15)
        label.textAlignment = .Center
        label.frame = CGRectMake(0, 0, 0, 80.0.fitHeight())
        return label
    }()
    
    private lazy var footerImg: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 700.0.fitHeight()))
        return img
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        goodsDetailTableView.tableHeaderView = titleHeader
        goodsDetailTableView.tableFooterView = footerImg
        contentView.addSubview(goodsDetailTableView)
        setNeedsUpdateConstraints()
    }
    
    func configureModel(model: [Properties],propertiesImg: String?) {
        if model.count > 0 {
            var totalH: CGFloat = 0
            for properties in model {
                let h = (properties.value! as NSString).getTextRectSize(UIFont.systemFontOfSize(13), size: CGSize(width: ScreenSize.SCREEN_WIDTH - 200.0.fitWidth(), height: CGFloat.max)).height
                totalH += h + 20.0.fitHeight()
            }
            
            goodsH = totalH + 700.0.fitHeight() + 80.0.fitHeight()
            footerImg.sd_setImageWithURL(NSURL(string: propertiesImg!), placeholderImage: nil)
            models = model
            goodsDetailTableView.reloadData()
        }
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints{
            
            goodsDetailTableView.autoPinEdgeToSuperviewEdge(.Top)
            goodsDetailTableView.autoPinEdgeToSuperviewEdge(.Right,withInset: 30.0.fitWidth())
            goodsDetailTableView.autoPinEdgeToSuperviewEdge(.Left,withInset: 30.0.fitWidth())
            NSLayoutConstraint.autoSetPriority(UILayoutPriorityDefaultHigh, forConstraints: {
                goodsDetailTableView.autoPinEdgeToSuperviewEdge(.Bottom,withInset: 30.0.fitHeight())
            })
            goodsDetailTableView.autoSetDimension(.Height, toSize: goodsH)
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

extension GoodsDetailCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count ?? 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(String(GoodsDetailTableViewCell)) as? GoodsDetailTableViewCell
        if cell == nil {
            cell = GoodsDetailTableViewCell(style: .Default, reuseIdentifier: String(GoodsDetailTableViewCell))
        }
        cell?.model = models[indexPath.row]
        return cell!
    }
}
