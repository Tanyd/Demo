//
//  FeatureDinnerCell.swift
//  yinshijia
//
//  Created by tanyadong on 16/6/19.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class FeatureDinnerCell: UITableViewCell {

    private var didUpdateConstraints = false
    var model = [Menu]()
    var childTableH: CGFloat = 0
    var childTableConstraint: NSLayoutConstraint?
    private lazy var featureTable: FeatureDinnerTableView = {
        let table = FeatureDinnerTableView(frame: CGRectZero, style: .Plain)
        table.delegate = self
        table.scrollEnabled = false
        table.dataSource = self
        table.estimatedRowHeight = 70
        table.rowHeight = UITableViewAutomaticDimension
        table.fd_debugLogEnabled = true
        return table
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(featureTable)
        setNeedsUpdateConstraints()
    }

    func configureModel(model: ChefDinner?) {
        if model?.data?.menu?.count > 0 {
            self.model = (model?.data?.menu)!
            var totalH: CGFloat = 0
            for menu in self.model {
                let titleH = (menu.title! as NSString).getTextRectSize(UIFont.systemFontOfSize(14), size: CGSize(width: ScreenSize.SCREEN_WIDTH, height: CGFloat.max)).height + 5
                let despH = (menu.desp! as NSString).getTextRectSize(UIFont.systemFontOfSize(14), size: CGSize(width: ScreenSize.SCREEN_WIDTH - 60.0.fitWidth(), height: CGFloat.max)).height
                let cellH = 720.0.fitHeight() + titleH + despH + 5
                totalH += cellH
            }
            childTableH = totalH
            updateConstraints()
            updateConstraintsIfNeeded()
            featureTable.reloadData()
        }
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints {
            featureTable.autoPinEdgeToSuperviewEdge(.Right)
            featureTable.autoPinEdgeToSuperviewEdge(.Top)
            featureTable.autoPinEdgeToSuperviewEdge(.Left)
            NSLayoutConstraint.autoSetPriority(UILayoutPriorityDefaultHigh, forConstraints: { 
                featureTable.autoPinEdgeToSuperviewEdge(.Bottom)
            })
            didUpdateConstraints = true
        }
        childTableConstraint = featureTable.autoSetDimension(.Height, toSize: childTableH)
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

extension FeatureDinnerCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(String(FeatureDinnerDetailCell)) as? FeatureDinnerDetailCell
            if cell == nil {
            cell = FeatureDinnerDetailCell(style: .Default, reuseIdentifier: String(FeatureDinnerDetailCell))
        }
        cell?.model = model[indexPath.row]
        return cell!
    }

}