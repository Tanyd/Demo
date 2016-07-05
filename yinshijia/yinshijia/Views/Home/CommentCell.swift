//
//  CommentCell.swift
//  yinshijia
//
//  Created by tanyadong on 16/7/3.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit
protocol CommentCellDelegate: NSObjectProtocol {
    func commentCellDidClick()
}
class CommentCell: UITableViewCell {

    private var didUpdateConstraints = false
    private var commentH: CGFloat = 0
    weak var delegate: CommentCellDelegate?
    
    private lazy var commentTable: CustomeCommentTableView = {
        let table = CustomeCommentTableView(frame: CGRectZero, style: .Plain, loadMoreComments: {
            if self.delegate != nil && (self.delegate?.respondsToSelector("commentCellDidClick"))!{
                self.delegate!.commentCellDidClick()
            }
        })
        return table
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(commentTable)
        setNeedsUpdateConstraints()
    }
    
    func configureModel(model: ChefDinner?) {
            var totalH: CGFloat = 0
        if model?.data?.comment?.count == 0 {
            totalH = 0
        }else if model?.data?.comment?.count > 2 {
                for index in 0...1 {
                    let comment = model?.data?.comment![index]
                    let despH = (comment!.content! as NSString).getTextRectSize(UIFont.systemFontOfSize(12), size: CGSize(width: ScreenSize.SCREEN_WIDTH - 130.0.fitWidth(), height: CGFloat.max)).height
                    totalH += despH + 315.0.fitHeight()
                }
            }else{
                for comment in (model?.data?.comment)! {
                    let despH = (comment.content! as NSString).getTextRectSize(UIFont.systemFontOfSize(12), size: CGSize(width: ScreenSize.SCREEN_WIDTH - 130.0.fitWidth(), height: CGFloat.max)).height
                    totalH += despH + 315.0.fitHeight()
                }
            }
        
        if model?.data?.comment?.count > 2 {
            commentH = totalH + 145.0.fitHeight() * 2.0 + 2
        }else {
            commentH = totalH + 145.0.fitHeight() + 2
        }
        commentTable.commentModels = (model?.data?.comment)!
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
