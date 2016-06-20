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
    var model = [Menu](){
        didSet{
            featureTable.reloadData()
        }
    }
    var childTableH: CGFloat = 0
    private lazy var featureTable: FeatureDinnerTableView = {
        let table = FeatureDinnerTableView(frame: CGRectZero, style: .Plain)
        table.delegate = self
        table.bounces = false
        table.dataSource = self
        table.registerClass(FeatureDinnerDetailCell.self, forCellReuseIdentifier: String(FeatureDinnerDetailCell))
        table.fd_debugLogEnabled = true
        return table
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(featureTable)
        setNeedsUpdateConstraints()
    }
    
//    func configureCellModel(model: [Menu]) {
//        self.model = model
//        for index in 0...model.count - 1 {
//            let H = featureTable.fd_heightForCellWithIdentifier(String(FeatureDinnerDetailCell), cacheByIndexPath: NSIndexPath(forRow: index, inSection: 0), configuration: { (cell) in
//                (cell as! FeatureDinnerDetailCell).model = self.model[index]
//            })
//            childTableH += H
//        }
//        featureTable.autoSetDimension(.Height, toSize: childTableH)
//        layoutIfNeeded()
//        featureTable.reloadData()
//    }
    
    override func updateConstraints() {
        if !didUpdateConstraints {
            featureTable.autoSetDimension(.Height, toSize: 970)
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
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableView.fd_heightForCellWithIdentifier(String(FeatureDinnerDetailCell), cacheByIndexPath: indexPath, configuration: { (cell) in
            (cell as! FeatureDinnerDetailCell).model = self.model[indexPath.row]
        })
    }
}