//
//  ScheduleInfoCell.swift
//  yinshijia
//
//  Created by tanyadong on 16/7/9.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class ScheduleInfoCell: UITableViewCell {

    private var didUpdateConstraints = false

    var model: String?{
        didSet{
            contentLabel.text = model
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let title = UILabel.labelCustomer("预定须知", fontType: Constant.Common.BoldFont, color: UIColor.blackColor(), fontSize: 15)
        title.textAlignment = .Center
        return title
    }()

    private lazy var contentLabel: UILabel = {
        let content = UILabel.labelCustomer(nil, fontType: nil, color: UIColor.lightGrayColor(), fontSize: 12)
        content.numberOfLines = 0
        return content
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints {
            titleLabel.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero, excludingEdge: .Bottom)
            titleLabel.autoSetDimension(.Height, toSize: 80.0.fitHeight())
            
            contentLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: titleLabel, withOffset: 20.0.fitHeight())
            contentLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: 30.0.fitWidth())
            contentLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: 30.0.fitWidth())
            contentLabel.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 30.0.fitHeight())
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
