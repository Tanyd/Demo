//
//  CommentCell.swift
//  yinshijia
//
//  Created by tanyadong on 16/7/3.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    private var didUpdateConstraints = false
    private var commentH: CGFloat = 0

    private lazy var commentTable: CustomeCommentTableView = {
       let table = CustomeCommentTableView(frame: CGRectZero, style: .Plain)
        return table
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(commentTable)
        setNeedsUpdateConstraints()
    }
    
    func configureModel(model: ChefDinner?) {
        if model?.data?.comment?.count > 0 {
            var totalH: CGFloat = 0
            for comment in (model?.data?.comment)! {
                let despH = (comment.content! as NSString).getTextRectSize(UIFont.systemFontOfSize(12), size: CGSize(width: ScreenSize.SCREEN_WIDTH - 70.0.fitWidth(), height: CGFloat.max)).height
                totalH += despH + 80.0.fitHeight() + 120.0.fitHeight() + 25.0.fitHeight() + 70.0.fitHeight()
            }
            commentH = totalH
            commentTable.commentModels = (model?.data?.comment)!
        }
    }
    override func updateConstraints() {
        if !didUpdateConstraints{
            
            commentTable.autoPinEdgeToSuperviewEdge(.Top)
            commentTable.autoPinEdgeToSuperviewEdge(.Right)
            commentTable.autoPinEdgeToSuperviewEdge(.Left)
            NSLayoutConstraint.autoSetPriority(UILayoutPriorityDefaultHigh, forConstraints: { 
                commentTable.autoPinEdgeToSuperviewEdge(.Bottom)
            })
            commentTable.autoSetDimension(.Height, toSize: commentH)
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
