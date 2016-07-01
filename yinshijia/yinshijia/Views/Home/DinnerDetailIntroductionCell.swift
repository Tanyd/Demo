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
    private var marksViewH: CGFloat = 30.0.fitHeight()
    private var marksViewConstraint: NSLayoutConstraint!
    
    private lazy var marksView: UIView = {
        let view = UIView.newAutoLayoutView()
        return view
    }()
    
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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLable)
        contentView.addSubview(contentLable)
        contentView.addSubview(marksView)
        setNeedsUpdateConstraints()
    }
    
    func configureModel(model: ChefDinner?) {
        if marksView.subviews.count > 0 {return}
        if model?.data?.baseInfo?.tag?.length() > 0 {
            titleLable.text = model?.data?.baseInfo?.title
            contentLable.text = model?.data?.baseInfo?.desp
            let tags = (model!.data!.baseInfo!.tag! as NSString).componentsSeparatedByString(",")
            for index in 0...tags.count - 1 {
                let tag = tags[index]
                let mark = UILabel.lableCutomer(tag, fontType: nil, color: UIColor.whiteColor(), fontSize: 11)
                mark.backgroundColor = UIColor.grayColor()
                mark.layer.cornerRadius = 10
                mark.numberOfLines = 1
                marksView.addSubview(mark)
            }
            
            for index in 0...marksView.subviews.count - 1 {
                let mark = marksView.subviews[index]
                mark.autoPinEdgeToSuperviewEdge(.Top)
                mark.autoPinEdgeToSuperviewEdge(.Bottom)
                
                if index == 0{
                    mark.autoPinEdgeToSuperviewEdge(.Left)
                }else{
                    let preMark = marksView.subviews[index - 1]
                    mark.autoPinEdge(.Left, toEdge: .Right, ofView: preMark, withOffset: 20.0.fitWidth())
                }
            }
        }else{
            marksViewConstraint.constant = 0
        }
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints {
            titleLable.autoPinEdgeToSuperviewEdge(.Left, withInset: 30.0.fitWidth())
            titleLable.autoPinEdgeToSuperviewEdge(.Right, withInset: 30.0.fitWidth())
            titleLable.autoPinEdgeToSuperviewEdge(.Top, withInset: 60.0.fitHeight())
            
            contentLable.autoPinEdge(.Left, toEdge: .Left, ofView: titleLable)
            contentLable.autoPinEdge(.Right, toEdge: .Right, ofView: titleLable)
            contentLable.autoPinEdge(.Top, toEdge: .Bottom, ofView: titleLable, withOffset: 50.0.fitHeight())
            
            marksView.autoPinEdge(.Top, toEdge: .Bottom, ofView: contentLable, withOffset: 30.0.fitHeight())
            marksView.autoPinEdge(.Left, toEdge: .Left, ofView: contentLable)
            marksView.autoPinEdge(.Right, toEdge: .Right, ofView: contentLable)
            marksView.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 30.0.fitHeight())
            marksViewConstraint = marksView.autoSetDimension(.Height, toSize: marksViewH)
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
