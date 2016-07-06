//
//  FeatureDinnerDetailCell.swift
//  yinshijia
//
//  Created by tanyadong on 16/6/18.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class FeatureDinnerDetailCell: UITableViewCell {

    private var didUpdateConstraints = false
    var model: Menu?{
        didSet{
            dinnerImg.sd_setImageWithURL(NSURL(string: (model?.image)!), placeholderImage: nil)
            titleLable.text = model?.title
            contentLable.text = model?.desp
        }
    }
    private lazy var dinnerImg: UIImageView = {
       let img = UIImageView.newAutoLayoutView()
        return img
    }()
    
    private lazy var titleLable: UILabel = {
       let title = UILabel.labelCustomer(nil, fontType: nil, color: UIColor.grayColor(), fontSize: 14)
        title.textAlignment = .Center
        return title
    }()
    
    private lazy var contentLable: UILabel = {
        let content = UILabel.labelCustomer(nil, fontType: nil, color: UIColor.grayColor(), fontSize: 12)
        content.textAlignment = .Center
        content.numberOfLines = 0
        return content
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(dinnerImg)
        contentView.addSubview(titleLable)
        contentView.addSubview(contentLable)
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints {
            
            dinnerImg.autoPinEdgeToSuperviewEdge(.Top)
            dinnerImg.autoPinEdgeToSuperviewEdge(.Left, withInset: 30.0.fitWidth())
            dinnerImg.autoPinEdgeToSuperviewEdge(.Right, withInset: 30.0.fitWidth())
            dinnerImg.autoSetDimension(.Height, toSize: 555.0.fitHeight())
            
            titleLable.autoAlignAxisToSuperviewAxis(.Vertical)
            titleLable.autoSetDimension(.Height, toSize: 135.0.fitHeight())
            titleLable.autoPinEdge(.Top, toEdge: .Bottom, ofView: dinnerImg)
            
            contentLable.autoPinEdge(.Left, toEdge: .Left, ofView: dinnerImg)
            contentLable.autoPinEdge(.Right, toEdge: .Right, ofView: dinnerImg)
            contentLable.autoPinEdge(.Top, toEdge: .Bottom, ofView: titleLable)
            contentLable.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 35.0.fitHeight())
            
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
