//
//  DinnerDetailIntroductionCell.swift
//  yinshijia
//
//  Created by tanyadong on 16/6/18.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class DinnerDetailIntroductionCell: UITableViewCell {

    private var didUpdateConstraints = false
    var title: String?{
        didSet{
            titleLable.text = title
        }
    }
    var tags: String?{
        didSet{
            let strs = tags?.componentsSeparatedByString(",")
            if strs?.count > 0 {
                
            }
        }
    }
    var introduction: String?{
        didSet{
            contentLable.text = introduction
        }
    }
    private lazy var titleLable: UILabel = {
       let title = UILabel.lableCutomer(nil, fontType: Constant.Common.BoldFont, color: UIColor.blackColor(), fontSize: 16)
        title.numberOfLines = 0
        return title
    }()
    
    private lazy var contentLable: UILabel = {
       let content = UILabel.lableCutomer(nil, fontType: nil, color: UIColor.blackColor(), fontSize: 13)
        content.numberOfLines = 0
        return content
    }()
    
    private lazy var markLable: UILabel = {
        let mark = UILabel.lableCutomer("邵新黄酒", fontType: nil, color: UIColor.whiteColor(), fontSize: 11)
        mark.backgroundColor = UIColor.grayColor()
        mark.layer.cornerRadius = 4.0
        return mark
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLable)
        contentView.addSubview(contentLable)
        contentView.addSubview(markLable)
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints {
            titleLable.autoPinEdgeToSuperviewEdge(.Left, withInset: 30.0.fitWidth())
            titleLable.autoPinEdgeToSuperviewEdge(.Right, withInset: 30.0.fitWidth())
            titleLable.autoPinEdgeToSuperviewEdge(.Top, withInset: 60.0.fitHeight())
            
            contentLable.autoPinEdge(.Left, toEdge: .Left, ofView: titleLable)
            contentLable.autoPinEdge(.Right, toEdge: .Right, ofView: titleLable)
            contentLable.autoPinEdge(.Top, toEdge: .Bottom, ofView: titleLable, withOffset: 50.0.fitHeight())
            
            markLable.autoPinEdge(.Top, toEdge: .Bottom, ofView: contentLable, withOffset: 30.0.fitHeight())
            markLable.autoPinEdge(.Left, toEdge: .Left, ofView: titleLable)
            markLable.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 30.0.fitHeight())
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
