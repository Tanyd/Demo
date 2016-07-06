//
//  CustomeCommentCell.swift
//  yinshijia
//
//  Created by tanyadong on 16/7/3.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class CustomeCommentCell: UITableViewCell {

    private var didUpdateConstraints = false
    
    var commentModel: Comment? {
        didSet{
            
            for start in rankView.subviews {
                (start as! UIButton).selected = false
            }
            
            userName.text = commentModel?.name
            timerLable.text = commentModel?.createtime
            dinnerName.text = "定制饭局:" + (commentModel?.shopName)!
            contenText.text = commentModel!.content
            userIcon.sd_setImageWithURL(NSURL(string: commentModel!.headImageurl!), placeholderImage: UIImage(named: "headerview"), completed: { (image, error, cacheType, url) in
                self.userIcon.image = UIImage.circleImageWithImage(image)
            })
            for index in 0...(commentModel?.rank)! - 1 {
                let start = rankView.subviews[index] as! UIButton
                start.selected = true
            }
        }
    }
    
    private lazy var rankView: UIView = {
        let view = UIView.newAutoLayoutView()
        for index in 0...4 {
            let start = UIButton(type: .Custom)
            start.setImage(UIImage(named: "comment_fullstar"), forState: .Selected)
            start.setImage(UIImage(named: "comment_emptystar"), forState: .Normal)
            start.tag = index
            start.userInteractionEnabled = false
            view.addSubview(start)
        }
        return view
    }()
    
    private lazy var commentBackView: UIImageView = {
        let view = UIImageView.newAutoLayoutView()
        view.image = UIImage(named: "comment_bubble")
        return view
    }()
    
    private lazy var contenText: UILabel = {
        let text = UILabel.labelCustomer(nil, fontType: nil, color: UIColor.grayColor(), fontSize: 12)
        text.numberOfLines = 0
        return text
    }()
    
    private lazy var userIcon: UIImageView = {
        let img = UIImageView.newAutoLayoutView()
        img.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: "userIconDidClick:")
        img.addGestureRecognizer(tap)
        return img
    }()
    
    func userIconDidClick(sender: UITapGestureRecognizer) {
        
    }
    
    private lazy var userName: UILabel = {
        let name = UILabel.labelCustomer(nil, fontType: nil, color: UIColor.grayColor(), fontSize: 12)
        return name
    }()
    
    private lazy var timerLable: UILabel = {
        let time = UILabel.labelCustomer(nil, fontType: nil, color: UIColor.grayColor(), fontSize: 12)
        return time
    }()
    
    private lazy var dinnerName: UILabel = {
        let time = UILabel.labelCustomer(nil, fontType: nil, color: UIColor.grayColor(), fontSize: 12)
        return time
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(userIcon)
        contentView.addSubview(userName)
        contentView.addSubview(timerLable)
        contentView.addSubview(commentBackView)
        commentBackView.addSubview(rankView)
        commentBackView.addSubview(contenText)
        contentView.addSubview(dinnerName)
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints{
            
            userIcon.autoPinEdgeToSuperviewEdge(.Left, withInset: 35.0.fitWidth())
            userIcon.autoPinEdgeToSuperviewEdge(.Top, withInset: 30.0.fitHeight())
            userIcon.autoSetDimensionsToSize(CGSize(width: 85.0.fitHeight(), height: 85.0.fitHeight()))
            
            userName.autoPinEdge(.Left, toEdge: .Right, ofView: userIcon, withOffset: 25.0.fitWidth())
            userName.autoPinEdgeToSuperviewEdge(.Top, withInset: 35.0.fitHeight())
            
            timerLable.autoPinEdge(.Left, toEdge: .Left, ofView: userName)
            timerLable.autoPinEdge(.Top, toEdge: .Bottom, ofView: userName, withOffset: 20.0.fitHeight())
            
            commentBackView.autoPinEdge(.Top, toEdge: .Bottom, ofView: userIcon, withOffset: 20.0.fitHeight())
            commentBackView.autoPinEdgeToSuperviewEdge(.Left, withInset: 30.0.fitWidth())
            commentBackView.autoPinEdgeToSuperviewEdge(.Right, withInset: 30.0.fitWidth())
            commentBackView.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 70.0.fitHeight())
            
            dinnerName.autoPinEdge(.Left, toEdge: .Left, ofView: commentBackView)
            dinnerName.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 20.0.fitHeight())
            dinnerName.autoPinEdge(.Top, toEdge: .Bottom, ofView: commentBackView, withOffset: 20.0.fitHeight())
            
            rankView.autoPinEdgeToSuperviewEdge(.Top)
            rankView.autoPinEdgeToSuperviewEdge(.Left, withInset: 25.0.fitWidth())
            rankView.autoSetDimensionsToSize(CGSize(width: 175.0.fitWidth(), height: 80.0.fitHeight()))
            for index in 0...rankView.subviews.count - 1 {
                let start = rankView.subviews[index]
                start.autoAlignAxisToSuperviewAxis(.Horizontal)
                start.autoSetDimensionsToSize(CGSize(width: 35.0.fitWidth(), height: 35.0.fitWidth()))
                if index == 0 {
                    start.autoPinEdgeToSuperviewEdge(.Left)
                }else{
                    let pre = rankView.subviews[index - 1]
                    start.autoPinEdge(.Left, toEdge: .Right, ofView: pre)
                }
                
                if index == rankView.subviews.count - 1 {
                    start.autoPinEdgeToSuperviewEdge(.Right)
                }
            }
            
            contenText.autoPinEdge(.Top, toEdge: .Bottom, ofView: rankView)
            contenText.autoPinEdge(.Left, toEdge: .Left, ofView: rankView)
            contenText.autoPinEdgeToSuperviewEdge(.Right, withInset: 45.0.fitWidth())
            contenText.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 25.0.fitHeight())
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
