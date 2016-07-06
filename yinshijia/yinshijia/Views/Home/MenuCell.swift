//
//  MenuCell.swift
//  yinshijia
//
//  Created by tanyadong on 16/6/19.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    private var didUpdateConstraints = false
    var model: Plainmenu?{
        didSet{
            titleLable.text = model?.title
            contentLable.text = model?.desp
        }
    }
    private lazy var titleLable: UILabel = {
        let title = UILabel.labelCustomer(nil, fontType: nil, color: Constant.Common.OrangeColor, fontSize: 14)
        title.textAlignment = .Center
        return title
    }()
    
    private lazy var contentLable: UILabel = {
        let content = UILabel.labelCustomer(nil, fontType: nil, color: UIColor.grayColor(), fontSize: 12)
        content.numberOfLines = 0
        content.textAlignment = .Center
        return content
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLable)
        contentView.addSubview(contentLable)
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints {
            titleLable.autoPinEdgeToSuperviewEdge(.Top)
            titleLable.autoAlignAxisToSuperviewAxis(.Vertical)
            
            contentLable.autoPinEdge(.Top, toEdge: .Bottom, ofView: titleLable, withOffset: 25.0.fitHeight())
            contentLable.autoAlignAxisToSuperviewAxis(.Vertical)
            contentLable.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 60.0.fitHeight())
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
