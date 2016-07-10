//
//  SelectedTypeCell.swift
//  yinshijia
//
//  Created by tanyadong on 16/7/9.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class SelectedTypeCell: UITableViewCell {

    private var didUpdateConstraints = false
    
    private lazy var typeButton: UIButton = {
        let btn = UIButton(type: .Custom)
        btn.titleLabel?.font = UIFont.systemFontOfSize(14)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        btn.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        btn.setImage(UIImage(named: "chooseType"), forState: .Normal)
        btn.setTitle("选择类型", forState: .Normal)
        btn.contentHorizontalAlignment = .Center
        return btn
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(typeButton)
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints {
            typeButton.autoPinEdgeToSuperviewEdge(.Top, withInset: 20.0.fitHeight())
            typeButton.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 20.0.fitHeight())
            typeButton.autoPinEdgeToSuperviewEdge(.Left)
            typeButton.autoPinEdgeToSuperviewEdge(.Right)
            typeButton.autoSetDimension(.Height, toSize: 80.0.fitHeight())
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
