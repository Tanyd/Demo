//
//  PersonalDinnerCell.swift
//  yinshijia
//
//  Created by Developer on 16/7/6.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class PersonalDinnerCell: UITableViewCell {
    
    private var didUpdateConstraints = false
    private var containerViewH: CGFloat = 0
    private var containerViewConstraint: NSLayoutConstraint!
    private var personalDinnerModels = [Themedinner](){
        didSet{
            containerViewH = 175.0.fitHeight() * CGFloat(personalDinnerModels.count)
            personalDinnerTable.reloadData()
        }
    }
    
    private var chefMadeModels = [ChefInfoGoods]() {
        didSet{
            containerViewH = 175.0.fitHeight() * CGFloat(chefMadeModels.count)
            personalDinnerTable.reloadData()
        }
    }
    
    private lazy var personalDinnerTable: UITableView = {
        let view = UITableView(frame: CGRectZero, style: .Plain)
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(personalDinnerTable)
        setNeedsUpdateConstraints()
    }
    
    func configureModel(model: ChefInfo?) {
        
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints {
            personalDinnerTable.autoPinEdgesToSuperviewEdges()
            containerViewConstraint = personalDinnerTable.autoSetDimension(.Height, toSize: containerViewH)
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

extension PersonalDinnerCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personalDinnerModels.count == 0 ? chefMadeModels.count : personalDinnerModels.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(String(PersonalDinnerView)) as? PersonalDinnerView
        if cell == nil {
            cell = PersonalDinnerView(style: .Default, reuseIdentifier: String(PersonalDinnerView))
        }
        cell?.cellType = personalDinnerModels.count == 0 ? .PersonalDinner : .ChefMade
        personalDinnerModels.count == 0 ? (cell!.chefMadeModel = chefMadeModels[indexPath.row]) : (cell!.personalDinnerModel = personalDinnerModels[indexPath.row])
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 175.0.fitHeight()
    }
}
