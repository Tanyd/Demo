//
//  PersonalDinnerCell.swift
//  yinshijia
//
//  Created by Developer on 16/7/6.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit
enum PersonalDinnerCellType: Int {
    case GoodsType
    case CustomeMadeType
}
class PersonalDinnerCell: UITableViewCell {
    
    private var didUpdateConstraints = false
    private var containerViewH: CGFloat = 0
    private var customeMadeModels = [Themedinner](){
        didSet{
            containerViewH = 175.0.fitHeight() * CGFloat(customeMadeModels.count)
            personalDinnerTable.reloadData()
        }
    }
    
    private var goodsModels = [ChefInfoGoods]() {
        didSet{
            containerViewH = 175.0.fitHeight() * CGFloat(goodsModels.count)
            personalDinnerTable.reloadData()
        }
    }
    
    private lazy var personalDinnerTable: UITableView = {
        let view = UITableView(frame: CGRectZero, style: .Plain)
        view.delegate = self
        view.dataSource = self
        view.scrollEnabled = false
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(personalDinnerTable)
        setNeedsUpdateConstraints()
    }
    
    func configureModel(model: ChefInfo?,type: PersonalDinnerCellType) {
        if type == .GoodsType {
            goodsModels = (model?.data?.goods)!
        }else{
            customeMadeModels = (model?.data?.themeDinner)!
        }
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints {
            personalDinnerTable.autoPinEdgesToSuperviewEdges()
            personalDinnerTable.autoSetDimension(.Height, toSize: containerViewH)
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
        return goodsModels.count == 0 ? customeMadeModels.count : goodsModels.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(String(PersonalDinnerView)) as? PersonalDinnerView
        if cell == nil {
            cell = PersonalDinnerView(style: .Default, reuseIdentifier: String(PersonalDinnerView))
        }
        cell?.cellType = goodsModels.count == 0 ? .CustomeMadeType : .GoodsType
        goodsModels.count == 0 ?
            (cell!.customeMadeModel = customeMadeModels[indexPath.row]) :
            (cell!.goodsModel = goodsModels[indexPath.row])
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 175.0.fitHeight()
    }
}
