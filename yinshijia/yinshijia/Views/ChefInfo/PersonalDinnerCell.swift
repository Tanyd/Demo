//
//  PersonalDinnerCell.swift
//  yinshijia
//
//  Created by Developer on 16/7/6.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class PersonalDinnerCell: UITableViewCell {

    private var didUpdateConstraints = false
    private var containerViewH: CGFloat = 0
    private var containerViewConstraint: NSLayoutConstraint!
    private lazy var containerView: UIView = {
        let view = UIView.newAutoLayoutView()
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(contentView)
        setNeedsUpdateConstraints()
    }
    
    func configureModel(model: ChefInfo?) {
        if model != nil {
            
        }
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints {
            containerView.autoPinEdgesToSuperviewEdges()
            containerViewConstraint = containerView.autoSetDimension(.Height, toSize: containerViewH)
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
