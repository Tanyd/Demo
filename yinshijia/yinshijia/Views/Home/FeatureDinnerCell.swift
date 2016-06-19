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

    private lazy var featureTable: FeatureDinnerTableView = {
        let table = FeatureDinnerTableView(frame: CGRectZero, style: .Plain)
        table.delegate = self
        table.dataSource = self
        table.registerClass(FeatureDinnerDetailCell.self, forCellReuseIdentifier: String(FeatureDinnerDetailCell))
        return table
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(featureTable)
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints {
            featureTable.autoPinEdgesToSuperviewEdges()
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

extension FeatureDinnerCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(String(FeatureDinnerDetailCell)) as? FeatureDinnerDetailCell
            if cell == nil {
            cell = FeatureDinnerDetailCell(style: .Default, reuseIdentifier: String(FeatureDinnerDetailCell))
        }
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableView.fd_heightForCellWithIdentifier(String(FeatureDinnerDetailCell), cacheByIndexPath: indexPath, configuration: { (cell) in
            
        })
    }
}