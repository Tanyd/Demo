//
//  ScheduleTitleCell.swift
//  yinshijia
//
//  Created by tanyadong on 16/7/11.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class ScheduleTitleCell: UITableViewCell {

    private var didUpdateConstraints = false
    var title: String?{
        didSet{
            titleLabel.text = title
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel.labelCustomer(nil, fontType: nil, color: UIColor.blackColor(), fontSize: 17)
        return label
    }()
    
    private lazy var closeBtn: UIButton = {
        let btn = UIButton(type: .Custom)
        btn.setTitle("关闭", forState: .Normal)
        btn.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(13)
        btn.action = {[weak self] in self?.closeSchedule()}
        return btn
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(closeBtn)
        setNeedsUpdateConstraints()
    }
    
    func closeSchedule() {
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints{
            titleLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: 30.0.fitWidth())
            titleLabel.autoAlignAxisToSuperviewAxis(.Horizontal)
            
            closeBtn.autoPinEdgeToSuperviewEdge(.Right, withInset: 30.0.fitWidth())
            closeBtn.autoPinEdgeToSuperviewEdge(.Top)
            closeBtn.autoPinEdgeToSuperviewEdge(.Bottom)
            closeBtn.autoSetDimension(.Width, toSize: 80.0.fitWidth())
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
