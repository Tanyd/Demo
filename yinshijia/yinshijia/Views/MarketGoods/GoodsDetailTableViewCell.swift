//
//  GoodsDetailTableViewCell.swift
//  yinshijia
//
//  Created by tanyadong on 16/7/9.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class GoodsDetailTableViewCell: UITableViewCell {

    private var didUpdateConstraints = false
    
    var model: Properties? {
        didSet{
            titileLabel.text = ((model?.title)! as NSString).componentsSeparatedByString(",").first! + ":"
            subTitleLabel.text = model?.value
        }
    }
    
    private lazy var titileLabel: UILabel = {
        let label = UILabel.labelCustomer(nil, fontType: nil, color: UIColor.lightGrayColor(), fontSize: 13)
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel.labelCustomer(nil, fontType: nil, color: UIColor.lightGrayColor(), fontSize: 13)
        label.preferredMaxLayoutWidth = 485.0.fitWidth()
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titileLabel)
        contentView.addSubview(subTitleLabel)
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints {
            titileLabel.autoPinEdgeToSuperviewEdge(.Top)
            titileLabel.autoPinEdgeToSuperviewEdge(.Left)
            
            subTitleLabel.autoPinEdge(.Left, toEdge: .Right, ofView: titileLabel, withOffset: 50.0.fitWidth())
            subTitleLabel.autoPinEdgeToSuperviewEdge(.Top)
            subTitleLabel.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 20.0.fitHeight())
            didUpdateConstraints = true
        }
        super.updateConstraints()
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
