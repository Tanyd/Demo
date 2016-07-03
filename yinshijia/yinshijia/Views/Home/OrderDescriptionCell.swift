//
//  OrderDescriptionCell.swift
//  yinshijia
//
//  Created by tanyadong on 16/7/3.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class OrderDescriptionCell: UITableViewCell {

    private var didUpdateConstraints = false

    private lazy var titleLable: UILabel = {
        let title = UILabel.lableCutomer("饭局地址", fontType: nil, color: UIColor.blackColor(), fontSize: 17)
        title.textAlignment = .Center
        return title
    }()
    
    private lazy var contenLable: UILabel = {
        let title = UILabel.lableCutomer(nil, fontType: nil, color: UIColor.grayColor(), fontSize: 12)
        title.textAlignment = .Left
        title.numberOfLines = 0
        return title
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLable)
        contentView.addSubview(contenLable)
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints {
            titleLable.autoAlignAxisToSuperviewAxis(.Vertical)
            titleLable.autoPinEdgeToSuperviewEdge(.Top, withInset: 60.0.fitHeight())
            
            contenLable.autoPinEdgeToSuperviewEdge(.Left, withInset: 30.0.fitWidth())
            contenLable.autoPinEdgeToSuperviewEdge(.Right, withInset: 30.0.fitWidth())
            contenLable.autoPinEdge(.Top, toEdge: .Bottom, ofView: titleLable, withOffset: 45.0.fitHeight())
            contenLable.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 30.0.fitHeight())
            didUpdateConstraints = true
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureModel(model: ChefDinner?) {
        if model != nil {
            contenLable.text = model?.data?.baseInfo?.orderDescription
        }
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
